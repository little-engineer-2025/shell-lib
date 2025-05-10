setup() {
    load "../retrieve.sh"
}

@test "is_repository" {
    is_repository "github.com/little-engineer-2025/shell-lib"
    ! is_repository "github.com"
    ! is_repository "github.com/little-engineer-2025"
    ! is_repository "github.com/little-engineer-2025/shell-lib/blob"
}

@test "is_source_github" {
    is_source_github "github.com/little-engineer-2025/shell-lib"
    is_source_github "github.com"
    ! is_source_github "gitlab.com"
}

@test "is_source_gitlab" {
    is_source_gitlab "gitlab.com/little-engineer-2025/shell-lib"
    is_source_gitlab "gitlab.com"
    ! is_source_gitlab "github.com"
}

@test "get_version" {
    [ "$(get_version "check.lib.sh")" == "" ]
    [ "$(get_version "check.lib.sh@main")" == "main" ]
    [ "$(get_version "check.lib.sh@v1.0.0")" == "v1.0.0" ]
}

@test "retrieve_default_branch_for_remote_repo" {
    [ "$(retrieve_default_branch_for_remote_repo "github.com/little-engineer-2025/shell-lib")" == "main" ]
    [ "$(retrieve_default_branch_for_remote_repo "github.com/reujab/silver")" == "master" ]
}

@test "get_shell_filename" {
    [ "$(get_shell_filename "lib/check.lib.sh@main")" == "check.lib.sh" ]
    [ "$(get_shell_filename "lib/check.lib.sh")" == "check.lib.sh" ]
    [ "$(get_shell_filename "check.lib.sh@main")" == "check.lib.sh" ]
    [ "$(get_shell_filename "check.lib.sh")" == "check.lib.sh" ]
}

@test "get_shell_file_path" {
    [ "$(get_shell_file_path "lib/check.lib.sh")" == "lib/check.lib.sh" ]
    [ "$(get_shell_file_path "lib/check.lib.sh@main")" == "lib/check.lib.sh" ]
    [ "$(get_shell_file_path "check.lib.sh")" == "check.lib.sh" ]
    [ "$(get_shell_file_path "check.lib.sh@main")" == "check.lib.sh" ]
}

@test "is_empty" {
    is_empty ""
    is_empty
    ! is_empty "a"
    ! is_empty "_"
    ! is_empty "9"
}

