# Shell scripts

This is a collection of shell scripts that can be
included to provide some common behaviors and avoid
repeat over and over again similar code.

- [log.lib.sh](docs/log.lib.md) provides log primitives to print out messages
  with a common format from your shell scripts. deps: `check.lib.sh`
- [check.lib.sh](docs/check.lib.md) provides common functions for check
  strings, useful for validating input reads from the user.
- [text.lib.sh](docs/text.lib.md) provide text string helpers.

## Using on your repository

- Create `dependencies.sh` file with the content:

```sh
dependencies=()
dependencies+=(github.com/little-engineer-2025/shell-lib)
dependencies+=(check.lib.sh log.lib.sh text.lib.sh)
# dependencies+=(check.lib.sh@main log.lib.sh@main text.lib.sh@main)
# dependencies+=(check.lib.sh@1.0.0 log.lib.sh@1.0.0 text.lib.sh@1.0.0)
SHELL_LIB_DIR="${PWD}/lib"
```

- Retrieve the dependencies by:

```sh
bash <(curl -s https://raw.githubusercontent.com/little-engineer-2025/shell-lib/refs/heads/main/retrieve.sh)
```


## Getting started

- Create `.envrc` and run `direnv allow`

```shell
export TOOLBOX="shell-dev"
export PATH="./tools:$PATH"
```

- (optional)(Once) Create your toolbox: `toolbox.sh create`
  or trigger the preparation by: `toolbox.sh prepare`
- (optional)Enter into your toolbox: `toolbox.sh enter`

See Contributing section about how to contribute to the
repository.

> The leverage of toolbox is optional, but it allows to start
> with a development environment quickly. In case to do not
> use, have a look to the `toolbox.sh` file to see the packages
> that are installed into it.

If using the `toolbox.sh` helper, see:
https://github.com/little-engineer-2025/toolbox-sh

## Contributing

See: docs/CONTRIBUTING.md

## Security

See: docs/SECURITY.md

