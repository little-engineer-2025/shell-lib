# Shell scripts

## Getting started

- Create `.envrc` and run `direnv allow`

```shell
export TOOLBOX="shell-dev"
export PATH="./tools:$PATH"
```

- Enter into your toolbox: `toolbox.sh enter`
- Run unit tests by: `bats test`
- Add a new test to `test/` directory.
- Run the unit tests which will fail.
- Modified your source shell to fit the unit test.

## Contributing

See: docs/CONTRIBUTING.md

## Security

See: docs/SECURITY.md

