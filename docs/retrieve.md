# retrieve.sh

main process to retrieve shell libs and copy them

## Overview

Customize the directory where to store the
retrieved shell libs by the SHELL_LIB_DIR environment
variable. This script require the file 'dependencies.sh'
exists in the current directory; this file define an
array with the list of dependencies; everytime a different
source is used, that should be indicated in the array to
change the source repository. For instance, below can be
seen a definition:
```sh
dependencies=()
# Set initial source to github.com/little-engineer-2025/shell-lib
dependencies+=(github.com/little-engineer-2025/shell-lib)
# Add three shells from it
dependencies+=(text.lib.sh log.lib.sh check.lib.sh)
```


