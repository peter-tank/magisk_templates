is_realpath() {
  realpath "$1" 2>/dev/null | grep -qF "$2";
}

is_boot_completed() {
  test "$(getprop sys.boot_completed 0)" = "1";
}

logf_print() {
  local _rt _mk;
  _rt=$1; shift 1;
  test -n "$_rt" && test "$_rt" -eq 0 && _mk="I" || _mk="E";
  $TEST && _mk="$_rt";
  test "$_rt" -eq 255 && _mk="I" 
  test "$_rt" -ne 0 && $BINPATH/cmd -l 2>/dev/null | grep -q vibrator && $BINPATH/cmd vibrator vibrate 50;
  printf "%.18s%6s%6s %s : %s #> %s\n" "$(date +"%m-%d %T.%N")" "$$" "$!" "$_mk" "$MODID" "$*";
}

wait_settings_ready() {
  is_boot_completed || while $BINPATH/cmd -l 2>/dev/null | grep -q " settings$"; do sleep 0.1; done;
}

wait_packages_ready() {
  is_boot_completed || while test -z "$($BINPATH/pm list packages 2>/dev/null)"; do sleep 0.1; done;
}

wait_boot_complete() {
  while ! is_boot_completed; do sleep 0.1; done;
}

db_set() {
  test "$3" != ":notset" && $BINPATH/settings put "$1" "$2" "$3" || $BINPATH/settings delete "$1" "$2" >/dev/null;
}

db_get() {
  local _rt;
  _rt=$($BINPATH/settings get "$1" "$2");
  test "$_rt" != "null" && echo -n "$_rt" || echo -n "$3"; 
}

srv_ready_cmd() {
  test "$1" = "data" || while ! $BINPATH/service list | grep -qi "android.*${3:-I${1}Manager}"; do sleep 0.02; done;
  $BINPATH/svc "$1" "$2" 2>&1 >/dev/null;
  logf_print "$?" "+ svc "$1" "$2"";
}

is_sys_app() {
  $BINPATH/pm list packages -s 2>/dev/null | grep -qFx "package:$1";
}

get_data_app() {
  local app pa dep;
  app="$1"; pa="$2"; dep="$3"; fn="$4";

  if $BINPATH/pm list packages 2>/dev/null | grep -q "package:$app$"; then
    $BINPATH/pm list packages -f 2>/dev/null | grep ".apk=$app$" | sed -ne "s|^package:$pa\(.*\)${fn:-base.apk}=[^=]*$|$pa\1|p";
  else
    if test -z "$fn"; then
      find "${pa:-"/data/app"}" -mindepth ${dep:-1} -maxdepth ${dep:-2} -type d -name "$app" 2>/dev/null;
    else
      find "${pa:-"/data/app"}" -mindepth ${dep:-1} -maxdepth ${dep:-2} -type f -name "$fn" 2>/dev/null;
    fi
  fi
}

get_sum() {
  md5sum -b "$1" 2>/dev/null | cut -d' ' -f1;
}

f_size() {
  stat -c %s "$1" 2>/dev/null;
}

is_same_apk() {
  test "$(get_sum "$1")" = "$(get_sum "$2")";
}

hard_install() {
  local app apk data ndata split pn iid wid rt sa;
  app="$1"; apk="$2";
  pn="${apk##*/}";

# do hard install
  split=$(cd ".$apk" && find . -mindepth 1 -maxdepth 1 -type f -name "*.apk" -print | grep -vFx "./$pn.apk");
#  if test -n "$split"; then
  if test "$app" != "com.android.packageinstaller"; then
    iid=$(${BINPATH}/pm install-create -r -t -f -d -g -i "$MODID" 2>/dev/null | sed 's/[^0-9]//g');
    test -z "$iid" && {
      logf_print 1 "! $app | pm install-create -r -t -f -d -g -i "$MODID"";
      return 0;
    }
    wid=0;
    for sa in "./$pn.apk" $split; do
      sa=".$apk/${sa:2}";
      cat "$sa" | ${BINPATH}/pm install-write -S "$(f_size "$sa")" "$iid" "$wid" - >/dev/null;
      wid=$((wid + 1));
    done
    ${BINPATH}/pm install-commit "$iid" >/dev/null;
    rt=$?;
    test "$rt" -eq 0 || ${BINPATH}/pm install-abandon "$iid";
    logf_print "$rt" "+ $app | pm install-split -r -t -f -d -g -i "$MODID" .${apk}/$wid:{"./$pn.apk" "$split"}";
  else
    ${BINPATH}/pm install -r -t -f -d -g -i "$MODID" ".${apk}/${pn}.apk" >/dev/null;
    rt=$?;
    logf_print "$?" "+ $app | pm install -r -t -f -d -g -i "$MODID" .${apk}/${pn}.apk";
  fi
  ndata=$(get_data_app "$app-*" "/data/app");
  if test -n "$ndata"; then
    data=$(realpath "$ndata" 2>/dev/null);
    if test "$rt" -eq 0 && test ! -f "./$app"; then
      if is_realpath "$data" "/data/app/"; then
        record_dir "$data";
        logf_print "$?" "+ $app | dir log to uninstaller: $data";
      else
        logf_print "$?" "! $app | goes wrong, dir log skiped!";
      fi
    fi
  else
    logf_print "$?" "! $app | not installed to /data/app, got: $(get_data_app "$app" "" "" ".apk").apk";
    rm -rf /data/system/package_cache/* 2>/dev/null;
    logf_print "$?" "! $app | rm -rf /data/system/package_cache/*";
  fi
}

add2uninstall() {
  local f;
  while read -r f; do
    grep -qFx "$f" "$INFO" || echo "$f" >> "$INFO";
  done
}

dirfiles() {
  local dir;
  find "$1" -mindepth 1 -maxdepth 1 -type d -print 2>/dev/null | while read -r dir;do dirfiles "$dir"; done;
  find "$1" -mindepth 1 -maxdepth 1 -type f -print 2>/dev/null;
}

record_dir() {
  test -d "$1" && test -n "$INFO" && dirfiles "$1" | add2uninstall;
}

upgrade_sys_app() {
  local app apk data ndata pass sa;
  app="$1"; apk="$2";
  pn="${apk##*/}";

  pass=false; sa=false;
  test -n "$($BINPATH/pm list packages 2>/dev/null)" && data=$(get_data_app "$app" "" "" ".apk");
  test -n "$data" && {
  is_same_apk "$data.apk" ".$apk/$pn.apk" && pass=true || logf_print 0 "- $app | version checking failed: "$data.apk"";
  if is_sys_app "$app"; then
      if is_realpath "$data.apk" "/data/app"; then
        sa=true;
        if test ! -f "./data_$app" && test ! -f "./$app"; then
          sa="uninstall"; pass=true;
          logf_print 0 "- $app | to keep your newer version, install before module.";
        fi
      elif test -f "./data_$app" || test -f "./$app"; then
        pass=false; sa=true;
        logf_print 0 "- $app | should be upgrade status: "$data.apk"";
      fi
      if $pass && $sa 2>/dev/null; then
        logf_print 0 "- $app | version forced pass: "$data.apk"";
        test -f "./update" && sa="uninstall";
      fi
    if test $sa = "uninstall"; then
      $BINPATH/pm uninstall-system-updates $app 2>&1 >/dev/null;
      logf_print $? "+ $app | pm $sa, force uninstall upgrades, double checking...";
    fi
  else
    touch "./$app";
    logf_print $? "! $app | packed version: $pass";
  fi
  }
  if ! $pass || $sa 2>/dev/null; then
    $sa || ndata="$(get_data_app "$app-*" "/data/app")";
    test -n "$ndata" && {
      if test -f "./$app" || test -f "./data_$app"; then return 0; fi;
      is_same_apk "$ndata/base.apk" ".$apk/$pn.apk" && return 0;
    }
    $pass || hard_install "$app" "$apk";
  fi
  return 0;
}

install_apk() {
cat | while read -r line; do
  apk="${line%%,*}";
  app="${line##*,}";
  check=".${apk}/${apk##*/}.apk";

  test -f "$check" && upgrade_sys_app "$app" "$apk" || logf_print "1" "! $app | access fails on: "$check"";
  pn="fix_$(echo "$app"|sed 's/\./_/g')";
  type "$pn" 2>&1 >/dev/null && $pn "$app" "$apk";
  pn=$(get_data_app "$app-*" "/data/app/");
  pn=$(realpath "$pn" 2>/dev/null);
  if is_sys_app "$app" && is_realpath "$pn" "/data/app"; then
    if test -f "./rm_$app"; then
      rm -rf "$pn" 2>/dev/null;
      logf_print "$?" "! $app | force removing: "$pn"";
    else
      logf_print 0 "- $app | keeping: "$pn"";
    fi
  fi
done
}

#26s to boot complete
debug_selinux() {
local COUNTOUT UPDATE LINE BS DS;

test -z "$BINPATH" && BINPATH=/system/bin;
test -z "$MODDIR" && MODDIR=$(pwd);
if ! type logf_print 2>&1 >/dev/null; then
  logf_print() { echo "$*"; };
  sleep() { echo -n .; $BINPATH/sleep $1; };
fi

COUNTOUT=0;
NONSTOP=false;
test -f "./update" && NONSTOP=true;
logf_print 255 "SELinux: avc monitor (NONSTOP=$NONSTOP)...$(rm -vf $(pwd)/selinux.tmp)";
cat ./selinux.filter 2>/dev/null > ./selinux.tmp;
cat ./selinux.tmp 2>/dev/null | while read -r LINE; do
  logf_print 0 "SELinux: filter[$LINE]";
done
DC=10;BS=1;
clean_dmesg() {
local bn=$1 id=$2;
test -d "%bn" && logf_print 255 "SELinux: dont messup." && return;
awk 'BEGIN{FS="]";epoch="[";ok=0;split("permissive=,ksys_umount,logd,NetlinkEvent:,VIVO_TS,_VOTER,_charger,do_mount,_vote:,pinctrl,swrm_,bolero",a ,",");}
  /^\[[ 0-9.]*\]/{ok=0; if($1 > epoch) {epoch=$1; ok=1; for(i in a) {if(match($0, a[i]) != 0) {ok=0;break;}}}}
  /.*/{ if(ok){print;}}' $bn.* > ./dmesg$id
rm -f $bn.* 2>/dev/null;
logf_print $? "SELinux: dmesg: $MODDIR/dmesg$id";
}
while $NONSTOP || test "$COUNTOUT" -lt 300; do
  COUNTOUT=$((COUNTOUT + 1));
  $BINPATH/logcat -d 2>/dev/null | grep " avc: " \
    | sed -e '/ dev=[^=]*fs" /d' -e '/ scontext=u:r:logd:/d' -e 's/ino=\([^ ]*\) //g' -e 's/pid=\([^ ]*\) //g' | sort | uniq \
    | sed -ne 's/^.* avc: *\([^ ]*\).*{\([^}]*\)}\(.*\)scontext=u:r:\([^:]*\).* tcontext=u:[^:]*:\([^:]*\).*tclass=\([^ ]*\).*\(permissive=.*\)$/\3 \1 \7 TODO: allow \4 \5 \6 {\2}/p' \
    | while read -r LINE;
  do
    grep -qFx "$LINE" ./selinux.tmp && continue;
    echo "$LINE" >> ./selinux.tmp;
    logf_print 255 "SELinux: $LINE";
    COUNTOUT=$((COUNTOUT - 1));
  done
  if test "$((BS%DC))" -eq "$((DC%10))"; then
    dmesg > /cache/dmesg.$DC;
    DC=$((DC + 1));
    if test "$(($DC % 10))" -eq 0; then
      clean_dmesg "/cache/dmesg" ".$DC";
      DC=$((DC + 1));
    fi
  fi
  BS=$((BS + 1));
  sleep 1;
done
logf_print 0 "SELinux: new requesting:";
sed 's/^#//g' ./sepolicy.rule | sort >./sepolicy.sort
sed 's/.*TODO: \(.*\)$/\1/' ./selinux.tmp ./sepolicy.sort 2>/dev/null | sort | uniq > ./selinux.sort
$BINPATH/diff -L "TODO: $MODDIR/sepolicy.rule" -U0 $MODDIR/sepolicy.sort $MODDIR/selinux.sort | while read -r LINE;
  do
    echo "$LINE";
  done
test "$((($DC-1) % 10))" -eq 0 || clean_dmesg "/cache/dmesg" ".$DC";
clean_dmesg "./dmesg" "";
logf_print 255 "SELinux: DONE.";
}

shutdown_wireless() {
test "$(db_get global wifi_on 1)" -ne 0 && srvs="wifi";
test "$(db_get global bluetooth_on 1)" -ne 0 && srvs="${srvs} bluetooth"
db_set global "user_turn_on_off_bluetooth" 12;
test "$(db_get global mobile_data 1)" -ne 0 && srvs="${srvs} data";
for srv in $srvs; do #usb nfc
  srv_ready_cmd "$srv" "disable" &
  case "$srv" in
    bluetooth)
      #6: on, 8: off
      $BINPATH/service call bluetooth_manager 8 >/dev/null &
      ;;
  esac
done
}

airplane_mode() {
  test "$(db_get global airplane_mode_on 0)" -ne 1 && { 
  db_set global airplane_mode_radios "cell,bluetooth,wifi,nfc,wimax";
  db_set global airplane_mode_toggleable_radios "bluetooth,wifi,nfc";
  db_set global airplane_mode_on 1;
  logf_print $? "+ auto airplane mode starting...";
  $BINPATH/am broadcast -a "android.intent.action.AIRPLANE_MODE" >/dev/null;
  logf_print $? "+ auto airplane mode done.";
  }
}

vivo_charger() {
  write() {
    test -w "$1" && echo -n "$2" > "$1";
  }
  sleep 0.2;
  write /sys/class/power_supply/battery/keep_chg_soc 85;
  write /sys/class/power_supply/battery/exhibition_mode 0;
  write /sys/class/power_supply/cms/exhibition_mode 0;
  write /sys/class/cms_class/keep_chg_soc 85;
  logf_print "$?" "+ setprop sys.demo.no_charge_protect 2";
  write /sys/class/cms_class/exhibition_mode 0;
}

install_tts_voice() {
  local base src zip ns lp dst perm;
  base="/data/user_de/0/com.google.android.tts";
  src="./system/tts/google";
  test -w "$base" || return 0;
  perm=$(stat -c "%u:%u" "$base");
  find "$src" -type f -name "*.zvoice" | while read -r zip; do
    ns=$(basename "${zip}");
    lp=${ns%.zvoice};
    ns=$(basename $(dirname "$zip"));
    dst="files/superpacks/$ns/$lp";
    mkdir -p "$base/$dst";
    unzip "$zip" -qod "$base/$dst";
    logf_print $? "+ zvoice | $ns/$lp: $zip";
    chown -R $perm "$base/files";
    chcon -R --reference "$base" "$base/files";
    chmod -R 0700 "$base/files";
    record_dir "$base/$dst";
  done
}