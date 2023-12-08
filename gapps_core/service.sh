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
fix_com_google_android_apps_nexuslauncher() {
  local app apk data;
  app="$1"; apk="$2";

  $BINPATH/pm set-home-activity com.vivo.simplelauncher >/dev/null;
  #$BINPATH/pm set-home-activity com.google.android.apps.nexuslauncher >/dev/null;
  logf_print $? "pm set-home-activity com.vivo.simplelauncher";
}
 #$BINPATH/pm set-home-activity com.google.android.apps.nexuslauncher >/dev/null;
 #logf_print $? "pm set-home-activity com.google.android.apps.nexuslauncher";
 # $BINPATH/pm 'set-home-activity' 'com.vivo.simplelauncher/com.vivo.simplelauncher.SimpleLauncher' >/dev/null;
 # logf_print "$?" "pm set-home-activity com.vivo.simplelauncher/com.vivo.simplelauncher.SimpleLauncher";
 # pm uninstall-system-updates
 # pm uninstall com.google.android.inputmethod.latin

wait_boot_complete && test -w "./system" && grep -v "^#" ./service.app | install_apk 2 >&1 >> "$LOGF" &
# pm uninstall-system-updates

wait_boot_complete && {
[ -f "$MODPATH/vivo_settings.sh" ] && . $MODPATH/vivo_settings.sh;
}

#$TEST && exit 0;
