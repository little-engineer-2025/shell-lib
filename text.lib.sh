#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alejandro Visiedo <alejandro.visiedo@gmail.com>
#
# @file text.lib.sh
# @brief Text helper tools

# @brief Convert input text to uppercase
# @arg $1 and rest of arguments to convert to uppercase
# @stdout The resulting string converted to uppercase.
uppercase() {
	local value="$*"
	value="${value^^}"
	printf "%s" "${value}"
}

# @brief Convert input text to lowercase
# @arg $1 and rest of arguments to convert to lowercase.
# @stdout The resulting string converted to lowercase.
lowercase() {
	local value="$*"
	value="${value,,}"
	printf "%s" "${value}"
}

# @brief Trim spaces from the string.
# @arg $1 and rest of arguments to trim. Be aware that
# when more than 1 argument is provided, all of them
# are joined in a string, and then the string
# transformation is applied. You could need to call several
# times the function to get the wished result.
# @stdout The resulting trimmed string.
trim() {
	local value="$*"
	value="${value#"${value%%[![:space:]]*}"}"
	value="${value%"${value##*[![:space:]]}"}"
	printf "%s" "${value}"
}

# @brief Trim left spaces from the string.
# @arg $1 and rest of arguments to trim. Be aware that
# when more than 1 argument is provided, all of them
# are joined in a string, and then the string
# transformation is applied. You could need to call several
# times the function to get the wished result.
# @stdout The resulting left trimmed string.
ltrim() {
	local value="$*"
	value="${value#"${value%%[![:space:]]*}"}"
	printf "%s" "${value}"
}

# @brief Trim right spaces from the string.
# @arg $1 and rest of arguments to trim. Be aware that
# when more than 1 argument is provided, all of them
# are joined in a string, and then the string
# transformation is applied. You could need to call several
# times the function to get the wished result.
# @stdout The resulting right trimmed string.
rtrim() {
	local value="$*"
	value="${value%"${value##*[![:space:]]}"}"
	printf "%s" "${value}"
}
