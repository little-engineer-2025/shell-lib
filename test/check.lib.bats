#!/usr/bin/env bats
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alejandro Visiedo <alejandro.visiedo@gmail.com>
#

@test "is_number" {
  load "../check.lib.sh"

  is_number "12345"
  is_number "0"
  is_number "1"
  is_number "-1"
  is_number "0.0"
  is_number "-1.03"
  ! is_number "-"
  ! is_number "abc"
}

@test "is_alpha" {
  load "../check.lib.sh"

  is_alpha "abc"
  ! is_alpha "12345"
  ! is_alpha "abc\""
}

@test "is_alphanum" {
  load "../check.lib.sh"

  is_alphanum "abc123"
  is_alphanum "1a"
  is_alphanum "1"
  is_alphanum "a"
  is_alphanum "A"
  is_alphanum "-"
  is_alphanum "."
  ! is_alphanum "~"
  ! is_alphanum "("
  ! is_alphanum ","
}

@test "is_whitespace" {
  load "../check.lib.sh"

  is_whitespace ' '
  is_whitespace '\t'
  is_whitespace '\n'
  ! is_whitespace '\b'
  ! is_whitespace "a"
  ! is_whitespace "9"
  ! is_whitespace "."
}

@test "is_fqdn" {
  load "../check.lib.sh"

  is_fqdn "example.com"
  ! is_fqdn "example"
  ! is_fqdn "9example.com"
}

@test "is_domain" {
  load "../check.lib.sh"

  is_domain "example.com"
  is_domain "example-1.com"
  is_domain "e9xample.com"
  ! is_domain "-example.com"
  ! is_domain "9example.com"
}

@test "is_hostname" {
  load "../check.lib.sh"

  is_hostname "alpha.example.com"
  is_hostname "alpha1.example.com"
  is_hostname "alpha-beta.example.com"
  ! is_hostname "1alpha.example.com"
}

