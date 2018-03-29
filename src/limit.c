#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/wait.h>
#include <unistd.h>

void
set_limit( int resource, rlim_t value )
{
    struct rlimit limits;
    int status;

    status = getrlimit( resource, &limits );
    if ( status == -1 ) {
        perror( NULL );
        exit( 127 );
    }

    if ( limits.rlim_max < value ) {
        fprintf( stderr,
            "warning (%d): requested value %ld exceeds max value %ld\n",
            resource, value, limits.rlim_max
        );
        return;
    }

    limits.rlim_max = value;
    if ( limits.rlim_cur > value )
        limits.rlim_cur = value;

    setrlimit( resource, &limits );
    if ( status == -1 ) {
        perror( NULL );
        exit( 127 );
    }
}

pid_t pid;

void
child_timeout( int sig )
{
    int status;

    status = kill( pid, SIGKILL );
    if ( status == -1 ) {
        perror( NULL );
        exit( 127 );
    }
}

int
main( int argc, char ** argv )
{
    struct sigaction act;
    char ** args, *end;
    unsigned seconds;
    int i;

    if ( argc < 3 ) {
        fprintf( stderr, "Usage: %s seconds command...\n", argv[ 0 ] );
        return 127;
    }

    seconds = strtoul( argv[ 1 ], &end, 10 );
    if ( end[ 0 ] != '\0' ) {
        fprintf( stderr, "cannot parse integer '%s'\n", argv[ 1 ] );
        return 127;
    }

    pid = fork();
    if ( pid == 0 ) {
        /* create a new process group for the command to make it harder to kill
        the caller */

        pid = getpid();
        setpgid( pid, pid );

        set_limit( RLIMIT_AS, (rlim_t)2 * 1024 * 1024 * 1024 );
        set_limit( RLIMIT_FSIZE, (rlim_t)2 * 1024 * 1024 * 1024 );
        set_limit( RLIMIT_NOFILE, 128 );
        set_limit( RLIMIT_NPROC, 1024 );

        args = (char**) malloc( sizeof( char* ) * argc );
        for ( i = 2; i < argc; ++i )
            args[ i - 2 ] = argv[ i ];
        args[ argc - 2 ] = 0;
        args[ argc - 1 ] = 0;

        if ( execvp( *args, args ) ) {
            perror( NULL );
            return 127;
        }
    } else {
        if ( seconds > 0 ) {
            act.sa_handler = child_timeout;
            act.sa_flags   = 0;
            i = sigemptyset( &act.sa_mask );
            if ( i == -1 ) {
                perror( NULL );
                kill( pid, SIGKILL );
                return 127;
            }

            i = sigaction( SIGALRM, &act, NULL );
            if ( i == -1 ) {
                perror( NULL );
                kill( pid, SIGKILL );
                return 127;
            }
            ualarm( seconds * 1000, 0 );
        }
        i = 127;
        if ( waitpid( pid, &i, 0 ) != pid )
            perror( NULL );
        if ( kill( -pid, SIGKILL ) == -1 && errno != ESRCH )
            perror( NULL );

        if ( WIFEXITED( i ) )
            return WEXITSTATUS( i );
        if ( WIFSIGNALED( i ) ) {
            fprintf( stderr, "Killed (%d)\n", WTERMSIG( i ) );
            return WTERMSIG( i );
        }
        return 127;
    }
}

