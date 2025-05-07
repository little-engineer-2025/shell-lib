# check.lib.sh

## Overview

provides primitives to validate string arguments.

## Index

* [is_number](#isnumber)
* [is_alpha](#isalpha)
* [is_alphanum](#isalphanum)
* [is_whitespace](#iswhitespace)
* [is_fqdn](#isfqdn)
* [is_domain](#isdomain)

### is_number

check the argument is a string that represent a number.

#### Arguments

* **$1** (a): string using

### is_alpha

check the argument is a string that represent a aplha
characters.

#### Arguments

* **$1** (a): string using

### is_alphanum

check the argument is a string that represent an
alphanumeric sequence.

#### Arguments

* **$1** (a): string using

### is_whitespace

check the argument is a string that represent
a sequence of white spaces (<space>, <tab>, <newline>).

#### Arguments

* **$1** (a): string using

### is_fqdn

check the argument is a sequence of chars
that represent a full qualified domain name,
for instance `alpha.example.com`

#### Arguments

* **$1** (a): string using

### is_domain

check the argument is a sequence of chars
that represent a domain name.
for instance `example.com`

#### Arguments

* **$1** (a): string using

