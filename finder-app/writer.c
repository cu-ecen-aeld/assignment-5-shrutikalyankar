#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <syslog.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[])
{
    /* Initialize syslog */
    openlog("writer", LOG_PID | LOG_CONS, LOG_USER);

    /* Validate arguments */
    if (argc < 3) {
        syslog(LOG_ERR, "Invalid number of arguments");
        fprintf(stderr, "Usage: %s <writefile> <writestr>\n", argv[0]);
        closelog();
        return 1;
    }

    const char *writefile = argv[1];
    const char *writestr  = argv[2];

    /* Log debug message */
    syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);

    /* Open file: create if needed, truncate if exists */
    int fd = open(writefile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        syslog(LOG_ERR, "Failed to open file %s: %s",
               writefile, strerror(errno));
        closelog();
        return 1;
    }

    /* Write string to file */
    ssize_t bytes_written = write(fd, writestr, strlen(writestr));
    if (bytes_written == -1) {
        syslog(LOG_ERR, "Write failed for file %s: %s",
               writefile, strerror(errno));
        close(fd);
        closelog();
        return 1;
    }

    /* Close file */
    if (close(fd) == -1) {
        syslog(LOG_ERR, "Failed to close file %s: %s",
               writefile, strerror(errno));
        closelog();
        return 1;
    }

    closelog();
    return 0;
}
