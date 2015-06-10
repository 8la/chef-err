#!/usr/bin/env bats

@test 'installs err with pip' {
  [[ $(/opt/err/env/bin/pip list | grep -E "^err[[:space:]]") ]]
}

@test 'err bot service should be running' {
  [[ $(ps aux | grep -Fo '/err.py' | uniq) = '/err.py' ]]
}
