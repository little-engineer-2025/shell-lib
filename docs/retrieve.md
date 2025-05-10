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
# If the shell to retrieve is in a directory we can indicate it by
dependencies+=(lib/test.lib.sh)
# When no version is indicated, try to retrieve from master or main branch
# but we can indicate the branch or tag version by:
dependencies+=(test.lib.sh@v1.0.0)
```

Finally we invoke for our repository the below to retrieve the
shell lib dependencies:

```sh
bash <(curl -s https://raw.githubusercontent.com/little-engineer-2025/shell-lib/refs/heads/main/retrieve.sh)
```


