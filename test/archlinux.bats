setup() {
  docker history bachelorthesis/archlinux >/dev/null 2>&1
}

@test "timezone" {
  run docker run bachelorthesis/archlinux date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "pacman cache is empty" {
  run docker run bachelorthesis/archlinux bash -c "ls -1 /var/cache/pacman/pkg | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}