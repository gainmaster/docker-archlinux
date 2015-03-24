setup() {
  run docker run --name archlinux bachelorthesis/archlinux >/dev/null 2>&1
}

@test "package installs cleanly" {
  run docker exec archlinux pacman-install openssl
  [ $status -eq 0 ]
}

@test "package installs" {
  run docker exec archlinux which openssl
  [ $status -eq 0 ]
}

@test "pacman cache is empty after install" {
  run docker exec archlinux bash -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

teardown() {
  docker rm archlinux
}