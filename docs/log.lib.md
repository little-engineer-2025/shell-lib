# log.lib.sh

provide log message primitives.

## Overview

Print a debug message on standard error. The message
is printed out only if the minimum LOG_DEBUG level is active.

## Index

* [log_debug](#logdebug)
* [log_trace](#logtrace)
* [log_info](#loginfo)
* [log_warning](#logwarning)
* [log_error](#logerror)
* [log_fatal](#logfatal)
* [log_set_level](#logsetlevel)

### log_debug

Print a debug message on standard error. The message
is printed out only if the minimum LOG_DEBUG level is active.

#### Arguments

* **$1** (are): passed as part of the message to print out.

### log_trace

Print a trace message on standard error. The message
is printed out only if the minimum LOG_TRACE level is active.

#### Arguments

* **$1** (are): passed as part of the message to print out.

### log_info

Print an informative message on standard error. The message
is printed out only if the minimum LOG_INFO level is active.

#### Arguments

* **$1** (are): passed as part of the message to print out.

### log_warning

Print a warning message on standard error. The message
is printed out only if the minimum LOG_WARNING level is active.

#### Arguments

* **$1** (are): passed as part of the message to print out.

### log_error

Print an error message on standard error. The message
is printed out only if the minimum LOG_ERROR level is active.

#### Arguments

* **$1** (are): passed as part of the message to print out.

### log_fatal

Print a fatal error message on standard error and terminate the script.
The message is printed out only if the minimum LOG_FATAL level is active.

#### Arguments

* **$1** (are): passed as part of the message to print out.

#### Exit codes

* 1

### log_set_level

Set the log level. If some message does not have the
minimum level, the message is printed out.

#### Arguments

* **$1** (is): a number in [$LOG_DEBUG..$LOG_FATAL]

