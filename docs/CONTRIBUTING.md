# Contributing guidelines

- Clone the repository: `git clone https://github.com/avisiedo/shell-lib.git`
- Open an [issue](https://github.com/avisiedo/shell-lib/issues/new). <!-- TODO Review link -->
- Create a branch: `git checkout -b my-change`
- Provide unit tests for the change at `test/` directory.
- Add changes to align with the unit test: `make test`
- Verify linter pass and make necessary changes: `make lint`
- Push your PR: `git push`
- Check the pipeline is success, else make the necessary changes.
- If the PR is not attended in 7 days, ping me in the PR `@avisiedo`
- As soon as I review the changes I will ping you (for changes and
  for notifying the merge).
- Thanks for your contribution and patient :)

## Commit and PR message format guideline

I am trying to use on my repository
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)

Please read the conventions and try to adjust to it.

In short:

```raw
<type>: <short description>

My description about the change that does not exceed 60
chars on width, and describe what I am changing and why to
change it.

Signed-By: First Last Name <user@example.com>
Co-Authored-By: A collaborator <user@example.com>
```

The PR follow the same format, but additionally we provide a list of pending
tasks so anyone could collaborate in some of the available tasks. For instance

```raw
Title: <type>: <short description>

My description about the change that does not exceed 60
chars on width, and describe what I am changing and why to
change it.

Pending tasks:

- [ ] is_number
- [ ] is_alpha
...

Signed-By: First Last Name <user@example.com>
Co-Authored-By: A collaborator <user@example.com>
```

The pending tasks will help on the progress of the changes, and will define Ready For Review.
