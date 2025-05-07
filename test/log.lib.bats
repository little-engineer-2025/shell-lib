#!/usr/bin/env bats
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alejandro Visiedo <alejandro.visiedo@gmail.com>
#

@test "Verify LOG_XXXXXXX constant values" {
  load "../log.lib.sh"

  [ "${LOG_DEBUG}" == "1" ]
  [ "${LOG_TRACE}" == "2" ]
  [ "${LOG_INFO}" == "3" ]
  [ "${LOG_WARNING}" == "4" ]
  [ "${LOG_ERROR}" == "5" ]
  [ "${LOG_FATAL}" == "6" ]

  [ "${LOG_DEFAULT}" == "${LOG_INFO}" ]
  [ "${LOG_CURRENT}" == "${LOG_DEFAULT}" ]
}

@test "log_set_level" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level "$LOG_TRACE"
  [ "${LOG_CURRENT}" == "${LOG_TRACE}" ]
  log_set_level "$LOG_INFO"
  [ "${LOG_CURRENT}" == "${LOG_INFO}" ]
}

@test "log_debug" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level $LOG_TRACE
  result=$(log_debug "test" 2>&1)
  [ "${result}" == "" ]
  log_set_level $LOG_DEBUG
  result=$(log_debug "test" 2>&1)
  [ "${result}" == "debug: test" ]
}

@test "log_trace" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level $LOG_INFO
  result=$(log_trace "test" 2>&1)
  [ "${result}" == "" ]
  log_set_level $LOG_TRACE
  result=$(log_trace "test" 2>&1)
  [ "${result}" == "trace: test" ]
  log_set_level $LOG_DEBUG
  result=$(log_trace "test" 2>&1)
  [ "${result}" == "trace: test" ]
}

@test "log_info" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level $LOG_WARNING
  result=$(log_info "test" 2>&1)
  [ "${result}" == "" ]
  log_set_level $LOG_INFO
  result=$(log_info "test" 2>&1)
  [ "${result}" == "info: test" ]
  log_set_level $LOG_TRACE
  result=$(log_info "test" 2>&1)
  [ "${result}" == "info: test" ]
}

@test "log_warning" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level $LOG_ERROR
  result=$(log_warning "test" 2>&1)
  [ "${result}" == "" ]
  log_set_level $LOG_WARNING
  result=$(log_warning "test" 2>&1)
  [ "${result}" == "warning: test" ]
  log_set_level $LOG_INFO
  result=$(log_warning "test" 2>&1)
  [ "${result}" == "warning: test" ]
}

@test "log_error" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level $LOG_FATAL
  result=$(log_error "test" 2>&1)
  [ "${result}" == "" ]
  log_set_level $LOG_ERROR
  result=$(log_error "test" 2>&1)
  [ "${result}" == "error: test" ]
  log_set_level $LOG_WARNING
  result=$(log_error "test" 2>&1)
  [ "${result}" == "error: test" ]
}

@test "log_fatal" {
  load "../check.lib.sh"
  load "../log.lib.sh"

  log_set_level $LOG_FATAL
  run log_fatal "test" 2>&1
  [ "${status}" -eq 1 ]
  [ "${output}" == "fatal: test" ]

  log_set_level $LOG_ERROR
  run log_fatal "test" 2>&1
  [ "${status}" -eq 1 ]
  [ "${output}" == "fatal: test" ]
}

