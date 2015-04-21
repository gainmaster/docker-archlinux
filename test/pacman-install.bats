setup() {
  docker history gainmaster/archlinux >/dev/null 2>&1
}

@test "package installs cleanly" {
  run docker run gainmaster/archlinux pacman-install openssl
  [ $status -eq 0 ]
}

@test "package is acutaly installed" {
  run docker run gainmaster/archlinux bash -c "pacman-install openssl; which openssl"
  [ $status -eq 0 ]
}

@test "pacman cache is empty after install" {
  skip
  run docker run gainmaster/archlinux bash -c "pacman-install openssl > /dev/null 2>&1; ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}