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

sleep 1 && debug_selinux 2>&1 >> "$LOGF" &

wait_boot_complete && test -w "./system" && grep -v "^#" ./service.app | install_apk 2 >&1 >> "$LOGF" &
# pm uninstall-system-updates

wait_boot_complete && [ -f "$MODPATH/mokee_settings.sh" ] && . $MODPATH/mokee_settings.sh;


#$TEST && exit 0;
