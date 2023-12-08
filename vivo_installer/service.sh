MODDIR=$(realpath "$0");
MODDIR=${MODDIR%/*};
BINPATH="/system/bin";
LOGF="/cache/magisk.log";
MODN="${MODDIR##*/}";

[ -f "$MODPATH/functions.sh" ] && . $MODPATH/functions.sh

#debugging
TEST=true;
if ! is_boot_completed; then
  cd "$MODDIR";
  TEST=false;
fi

#actually broken vibrator binder lib!
xfix_klye_hanwriting() {
  local app apk data;
  app="$1"; apk="$2";

  data=$(get_data_app "$app-*" "/data/app/" | head -n1);
  test -d "$data" && {
    find ".$apk/lib" -mindepth 1 -maxdepth 1 -type d -exec cp -Rf {} "$data/lib" \;
    chmod -R 0755 "$data/lib";
    chown -hR 1000:1000 "$data/lib";
    chcon -hR u:object_r:apk_data_file:s0 "./$data/lib";
  }
  logf_print 0 "- $app | do fix_$* $data";
}

wait_boot_complete && vivo_charger 2>&1 >> "$LOGF" &

wait_boot_complete && test -w "./system" && grep -v "^#" ./service.app | install_apk 2 >&1 >> "$LOGF" &
# pm uninstall-system-updates

wait_boot_complete && airplane_mode  2>&1 >> "$LOGF" &

wait_boot_complete && shutdown_wireless 2>&1 >> "$LOGF" &

wait_boot_complete && {
[ -f "$MODPATH/vivo_settings.sh" ] && . $MODPATH/vivo_settings.sh;
logf_print 0 "- waiting system-server crash...";
$TEST || $BINPATH/svc "system-server" "wait-for-crash" >/dev/null;
_rt=$?;
if test "$_rt" -eq 0; then
  $TEST && logf_print "$_rt" "- crash wait skiped for on device script testing." || logf_print "$_rt" "- system-server shutdown gracefully.";
else
  touch disable;
  logf_print "$_rt" "! system-server crashed: $_rt, auto disable module: $MODID"
fi
} 2>&1 >> "$LOGF" &

sleep 1 && debug_selinux 2>&1 >> "$LOGF" &

#$TEST && exit 0;
