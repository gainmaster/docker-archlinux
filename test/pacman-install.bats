setup() {
  run docker run -d --name archlinux bachelorthesis/archlinux
}

@test "package installs cleanly" {
  run docker exec archlinux pacman-install openssl
  [ $status -eq 0 ]
}

@test "package is acutaly installed" {
  run docker exec archlinux pacman-install openssl
  run docker exec archlinux which openssl
  [ $status -eq 0 ]
}

@test "pacman cache is empty after install" {
  run docker exec archlinux pacman-install openssl
  run docker exec archlinux bash -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

teardown() {
  docker rm archlinux
}