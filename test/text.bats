setup() {
  load ../text.lib.sh
}

@test "uppercase" {
  [ "$(uppercase "hello world!")" == "HELLO WORLD!" ]
  [ "$(uppercase "hello" "world" "!")" == "HELLO WORLD !" ]
}

@test "lowercase" {
  [ "$(lowercase "HELLO WORLD!")" == "hello world!" ]
  [ "$(lowercase "HELLO" "WORLD" "!")" == "hello world !" ]
}

@test "trim" {
  [ "$(trim "  hello world  ")" == "hello world" ]
  [ "$(trim "  hello world")" == "hello world" ]
  [ "$(trim "hello world  ")" == "hello world" ]
}

@test "ltrim" {
  [ "$(ltrim "  hello world  ")" == "hello world  " ]
  [ "$(ltrim "  hello world")" == "hello world" ]
  [ "$(ltrim "hello world  ")" == "hello world  " ]
}

@test "rtrim" {
  [ "$(rtrim "  hello world  ")" == "  hello world" ]
  [ "$(rtrim "  hello world")" == "  hello world" ]
  [ "$(rtrim "hello world  ")" == "hello world" ]
}

@test "begins_with" {
  begins_with "" ""
  begins_with "abc" ""
  begins_with "abc" "a"
  begins_with "a.b.c" "a."
  ! begins_with "abc" "c"
}

@test "ends_with" {
  ends_with "" ""
  ends_with "abc" ""
  ends_with "abc" "c"
  ends_with "a.b.c" ".c"
  ! ends_with "abc" "a"
}

