# Shell scripts

This is a collection of shell scripts that can be
included to provide some common behaviors and avoid
repeat over and over again similar code.

- [log.lib.sh](docs/log.lib.md) provides log primitives to print out messages
  with a common format from your shell scripts. deps: `check.lib.sh`
- [check.lib.sh](docs/check.lib.md) provides common functions for check
  strings, useful for validating input reads from the user.

TODO:

- Provide a simple way to install the scripts in your
  environment. For instance a `dependencies.sh` which
  provide information about sources where to retrieve
  lib shells and copy them to your `lib/` directory.
  (I don't want to call it a package manager).
  - The references about the version to install will
    align the git repository in an easy way (tags or main branch).
  - Add support to retrieve lib shells from different
    repositories, providing a way to combine from
    different sources.

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

