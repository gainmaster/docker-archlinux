setup() {
  docker history bachelorthesis/archlinux >/dev/null 2>&1
}

@test "timezone" {
  run docker run bachelorthesis/archlinux date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "pacman mirror list is correct" {
  run docker run bachelorthesis/archlinux cat /etc/pacman.d/mirrorlist
  [ $status -eq 0 ]
  [ 
    "${lines[0]}" = "Server = http://mirror.archlinux.no/$repo/os/$arch" 
    "${lines[1]}" = "Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch" 
  ]
}

@test "pacman cache is empty" {
  run docker run bachelorthesis/archlinux bash -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "package installs cleanly" {
  run docker run bachelorthesis/archlinux pacman-install openssl
  [ $status -eq 0 ]
}