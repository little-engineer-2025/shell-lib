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

