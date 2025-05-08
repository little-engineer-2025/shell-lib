#!/bin/bash
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

# @brief check if the argument is a repository source
# @arg $1 string with the repository source "github.com/little-engineer-2025/shell-lib"
is_repository() {
	local item="$1"
	[[ "${item}" =~ ^(github\.com)/([a-zA-Z0-9\-]+)/([a-zA-Z0-9\-]+)$ ]]
}

# @brief get the version of a dependency item; if no version
# is found then the output is an empty string.
# @stdout receive the string output of the version
get_version() {
	local version="$1"
	version="${version##*@}"
	if [ "${version}" == "$1" ]; then
		printf ""
	else
		printf "%s" "${version}"
	fi
}

# @brief retrieve the default branch for a given remote repo
# @arg $1 the repository source in the form "hostname/user/repo-name"
# @stdout receive the name of the figured out default branch
retrieve_default_branch_for_remote_repo() {
	local repo="$1"
	local remote_default_branch="main"
	remote_default_branch="$(git ls-remote --symref "https://${repo}.git" HEAD | head -n 1 | grep -oP '(?<=refs/heads/)\w+')"
	printf "%s" "${remote_default_branch}"
}

# @brief retrieve the shell filename without version and directories.
# @arg $1 the shell reference indicated into the dependencies.
# @stdout the string with the expected format.
get_shell_filename() {
    local value="$1"
    value="${value%@*}"
    value="${value##*/}"
    printf "%s" "${value}"
}

# @brief retrieve the shell file path without version.
# @arg $1 the shell reference indicated into the dependencies.
# @stdout the string with the expected format.
get_shell_file_path() {
    local value="$1"
    value="${value%@*}"
    printf "%s" "${value}"
}

download() {
    local current_source="$1"
    local version="$2"
    local file_path="$3"
    local ret
    temp_path="$(mktemp /tmp/retrieve.XXXXXXX)"
    git archive "https://${current_source}.git" "${version}" "${file_path}" -o "${temp_path}" || {
        ret=$?
        rm -f "${temp_path}"
        log_fatal "git archive exit-code=${ret}"
    }
    mv "${temp_path}" "${target_path}" || {
        ret=$?
        rm -f "${temp_path}"
        log_fatal "mv exit-code=${ret}"
    }
    rm -f "${temp_path}"
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
		printf "fatal: 'dependencies.sh' not found\n" >&2
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
			continue
		fi

		# Check a source is selected
		[ "${current_source}" != "" ] || {
			printf "fatal: no repository source was specified before trying to retrieve '%s'\n" "${item}"
			return 1
		}
		local version=""
		version="$(get_version "${item}")"
		[ "${version}" != "" ] || version="${default_branch}"
		file_path="$(get_shell_file_path "${item}")"
		filename="$(get_shell_filename "${item}")"
		target_path="${shell_lib_dir}/${filename}"
        download "${current_source}" "${version}" "${file_path}" || {
            log_fatal "retrieving current_source='${current_source}' version='${version}' file_path='${file_path}'"
        }
	done

	return 0
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
	main "$@"
	exit $?
fi
