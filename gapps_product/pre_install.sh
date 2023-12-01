ui_print "- Upgrade packages..."

[ -f "$MODPATH/functions.sh" ] && . $MODPATH/functions.sh
logf_print() {
  local _mk

  test "$1" -eq 0 && _mk="I" || _mk="E"
  shift
  ui_print "   $_mk : $*"
}

cd $MODPATH;
BINPATH=/system/bin;
LOGF=/dev/stdout;

# pm uninstall-system-updates
wait_boot_complete && test -w "$MODPATH/system" && grep -v "^#" $MODPATH/pre_install.app | install_apk 2>&1