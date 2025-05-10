#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alejandro Visiedo <alejandro.visiedo@gmail.com>
#
# @file retrieve.sh
# @brief helper script to install required shell scripts
# @example curl "https://github.com/..../retrieve.sh" | bash -
# @description Customize the directory where to store the
# retrieved shell libs by the SHELL_LIB_DIR environment
# variable. This script require the file 'dependencies.sh'
# exists in the current directory; this file define an
# array with the list of dependencies; everytime a different
# source is used, that should be indicated in the array to
# change the source repository. For instance, below can be
# seen a definition:
#
# ```sh
# dependencies=()
# # Set initial source to github.com/little-engineer-2025/shell-lib
# dependencies+=(github.com/little-engineer-2025/shell-lib)
# # Add three shells from it
# dependencies+=(text.lib.sh log.lib.sh check.lib.sh)
# # If the shell to retrieve is in a directory we can indicate it by
# dependencies+=(lib/test.lib.sh)
# # When no version is indicated, try to retrieve from master or main branch
# # but we can indicate the branch or tag version by:
# dependencies+=(test.lib.sh@v1.0.0)
# ```
#
# Finally we invoke for our repository the below to retrieve the
# shell lib dependencies:
#
# ```sh
# bash <(curl -s https://raw.githubusercontent.com/little-engineer-2025/shell-lib/refs/heads/main/retrieve.sh)
# ```

is_repository() {
	local item="$1"
	[[ "${item}" =~ ^(github\.com)/([a-zA-Z0-9\-]+)/([a-zA-Z0-9\-]+)$ ]]
}

is_source_github() {
	local item="$1"
	[[ "${item}" =~ ^(github\.com)(/.*)?$ ]]
}

is_source_gitlab() {
	local item="$1"
	[[ "${item}" =~ ^(gitlab\.com)(/.*)?$ ]]
}

get_version() {
	local version="$1"
	version="${version##*@}"
	if [ "${version}" == "$1" ]; then
		printf ""
	else
		printf "%s" "${version}"
	fi
}

retrieve_default_branch_for_remote_repo() {
	local repo="$1"
	local remote_default_branch="main"
	remote_default_branch="$(git ls-remote --symref "https://${repo}.git" HEAD | head -n 1 | grep -oP '(?<=refs/heads/)\w+')"
	printf "%s" "${remote_default_branch}"
}

get_shell_filename() {
	local value="$1"
	value="${value%@*}"
	value="${value##*/}"
	printf "%s" "${value}"
}

get_shell_file_path() {
	local value="$1"
	value="${value%@*}"
	printf "%s" "${value}"
}

is_empty() {
	[ -z "$1" ]
}

download() {
	local current_source="$1"
	local version="$2"
	local file_path="$3"
	local target_path="$4"
	local ret
	local repo=""
	local TERM_RM="rm"
	# TERM_RM="echo rm"

	! is_empty "${current_source}" || {
		printf "error: current_source='%s'\n" "${current_source}" >&2
		return 1
	}
	! is_empty "${version}" || {
		printf "error: version='%s'\n" "${version}" >&2
		return 1
	}
	! is_empty "${file_path}" || {
		printf "error: file_path='%s'\n" "${file_path}" >&2
		return 1
	}
	! is_empty "${target_path}" || {
		printf "error: target_path='%s'\n" "${target_path}" >&2
		return 1
	}

	repo="${current_source%%*/}"
	temp_path="$(mktemp -d /tmp/retrieve.XXXXXXX)"
	git clone --branch "${version}" --depth 1 "https://${current_source}.git" "${temp_path}/" &>/dev/null || {
		ret=$?
		${TERM_RM} -rf "${temp_path}"
		printf "error: cloning 'https://%s.git'\n" "${current_source}" >&2
		return $ret
	}
	cp -vf "${temp_path}/${file_path}" "${target_path}" &>/dev/null || {
		ret=$?
		${TERM_RM} -rf "${temp_path}"
		printf "error: copying '%s' to '%s'\n" "${temp_path}/${file_path}" "${target_path}" >&2
		return $ret
	}
	rm -rf "${temp_path}" &>/dev/null || {
		ret=$?
		${TERM_RM} -rf "${temp_path}"
		printf "error: removing '%s'\n" "${temp_path}" >&2
		return $ret
	}
	return 0
}

# @brief main process to retrieve shell libs and copy them
# to your lib/ directory by default.
# @return 0 on success
# @return 1 on failure
main() {
	set -e
	local deps_file="$PWD/dependencies.sh"
	local shell_lib_dir="${SHELL_LIB_DIR:-"${PWD}/lib"}"
	local current_source=""
	local default_branch=""
	local version=""
	local filename=""
	local file_path=""
	local target_path=""
	local dependencies=()

	[ -e "${deps_file}" ] || {
		printf "error: 'dependencies.sh' not found\n" >&2
		return 1
	}
	# shellcheck disable=SC1090
	source "${deps_file}"
	[ ${#dependencies[@]} -gt 0 ] || {
		printf "info: nothing to do\n" >&2
		return 0
	}
	# Create target directory
	[ -e "${shell_lib_dir}" ] || mkdir -p "${shell_lib_dir}"
	# Traverse the dependencies
	for item in "${dependencies[@]}"; do
		if is_repository "${item}"; then
			current_source="${item}"
			default_branch="$(retrieve_default_branch_for_remote_repo "${current_source}")"
			printf "info: current_source='%s'\n" "${current_source}" >&2
			continue
		fi

		# Check a source is selected
		[ "${current_source}" != "" ] || {
			printf "error: no repository source was specified before trying to retrieve '%s'\n" "${item}"
			return 1
		}
		local version=""
		version="$(get_version "${item}")"
		[ "${version}" != "" ] || version="${default_branch}"
		file_path="$(get_shell_file_path "${item}")"
		filename="$(get_shell_filename "${item}")"
		target_path="${shell_lib_dir}/${filename}"
		printf "info: downloading '%s' from '%s'\n" "${item}" "${current_source}" >&2
		download "${current_source}" "${version}" "${file_path}" "${target_path}" || {
			printf "error: retrieving current_source='%s' version='%s' file_path='%s' target_path='%s'\n" "${current_source}" "${version}" "${file_path}" "${target_path}"
			return 1
		}
	done

	return 0
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
	main "$@"
	exit $?
fi
