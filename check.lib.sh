#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alejandro Visiedo <alejandro.visiedo@gmail.com>
#

is_number() {
	[[ "$1" =~ ^(-?[0-9]+)(\.[0-9]+)?$ ]]
}

is_alpha() {
	[[ "$1" =~ ^[a-zA-Z]*$ ]]
}

is_alphanum() {
	[[ "$1" =~ ^[a-zA-Z0-9\.\-]*$ ]]
}

is_whitespace() {
	[[ "$1" =~ ^[\ \\\t\\\n]*$ ]]
}

is_fqdn() {
	[[ "$1" =~ ^([a-z][a-z0-9\-]*\.)([a-z][a-z0-9\-]*)$ ]]
}

is_domain() {
	[[ "$1" =~ ^([a-z][a-z0-9\-]*\.)+([a-z][a-z0-9\-]*)$ ]]
}

is_hostname() {
	[[ "$1" =~ ^([a-z][a-z0-9\-]*\.)*([a-z][a-z0-9\-]*)$ ]]
}
