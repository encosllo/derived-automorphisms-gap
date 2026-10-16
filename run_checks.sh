#!/bin/bash
# Reproduces all the files in logs/, in 4 parallel processes. Usage: ./run_checks.sh
# The whole run takes about 15 minutes; the longest job is synchronization_294.
cd "$(dirname "$0")"
run_job() {
  args="${1%%|*}"; rest="${1#*|}"; script="${rest%%|*}"; name="${rest##*|}"
  echo "$(date '+%F %T') start $name"
  gap -q -c "$args" gap/lib.g "gap/$script" < /dev/null 2>&1 | tr -d '\r' > "logs/$name.log"
  echo "$(date '+%F %T') end   $name"
}
export -f run_job
xargs -P 4 -I{} bash -c 'run_job "$@"' _ {} <<'JOBS'
nmin:=151;; nmax:=200;; skip:=[192];;|theorems.g|theorems_151-200
nmin:=101;; nmax:=150;; skip:=[128];;|theorems.g|theorems_101-150
nmin:=1;; nmax:=100;;|theorems.g|theorems_1-100
nmax:=120;;|synchronization.g|synchronization_1-120
|order192.g|order192
|table1.g|table1
|frattini_free.g|frattini_free
|remark83.g|remark83
|example48.g|example48
|example_coprime.g|example_coprime
|direct_powers.g|direct_powers
|example614.g|example614
|proposition616.g|proposition616
GROUPS:=[[294,9]];;|synchronization.g|synchronization_294
JOBS
