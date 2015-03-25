setup() {
  docker history bachelorthesis/archlinux >/dev/null 2>&1
}

@test "package installs cleanly" {
  run docker run bachelorthesis/archlinux pacman-install openssl
  [ $status -eq 0 ]
}

@test "package is acutaly installed" {
  run docker run bachelorthesis/archlinux bash -c "pacman-install openssl; which openssl"
  [ $status -eq 0 ]
}

@test "pacman cache is empty after install" {
  run docker run bachelorthesis/archlinux bash -c "pacman-install openssl; ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}