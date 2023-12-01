##########################################################################################
#
# MMT Extended Config Script
#
##########################################################################################

##########################################################################################
# Config Flags
##########################################################################################

# Uncomment and change 'MINAPI' and 'MAXAPI' to the minimum and maximum android version for your mod
# Uncomment DYNLIB if you want libs installed to vendor for oreo+ and system for anything older
# Uncomment DEBUG if you want full debug logs (saved to /sdcard)
MINAPI=30
MAXAPI=30
#DYNLIB=true
#DEBUG=true

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
/system/build-in-app
/system/app/AppBehaviorEngine
/system/app/AppFilter
/system/app/BBKAccount
/system/app/BBKCloud
/system/app/BBKLOG
/system/app/BBKNotes
/system/app/EPM
/system/app/Feedback
/system/app/HiBoard
/system/app/IManager
/system/app/vivoScan
/system/app/vivogame
/system/app/vivoPushEngine
/system/app/VivoTips
/system/app/VivoSmartNlp
/system/app/VivoAssistant
/system/app/Updater
/system/app/SmartKey
/system/app/LogSystem
/system/app/GameWatch
/system/app/Calculator
/system/app/Compass
/system/app/BBKStore
/system/app/AIEngine
/system/app/AIService
/system/app/AlipayService
/system/app/BBKAppStore
/system/app/CarLauncher
/system/app/CarNetworking
/system/app/DeviceReg
/system/app/FloatingBall
/system/app/GameCube
/system/app/IqooPowerSaving
/system/app/IqooSecure
/system/app/MagazineService
/system/app/PowerEffectManager
/system/app/RcsService
/system/app/SafeCenter
/system/app/SoterService
/system/app/VHomeGuide
/system/app/VLife_vivo
/system/app/VTouch
/system/app/Vivo3rdAlgoService
/system/app/VivoDaemonService
/system/app/VivoKaraoke
/system/app/VivoUnionApk
/system/app/VoiceWakeup
/system/app/com.vivo.quickpay
/system/app/vivoWallet
/system/app/vivospace-v2
/system/priv-app/VivoBrowser
/system/priv-app/EasyShare
/system/priv-app/VivoAppStoreEX
/system/priv-app/AiAgent
/system/priv-app/IoTServer
/system/priv-app/VivoShare
/system/priv-app/VivoSogouIME
/system/custom/app/BBKAccount
/system/custom/app/BBKCloud
/system/custom/app/BBKLOG
/system/custom/app/BBKNotes
/system/custom/app/BBKStore
"

##########################################################################################
# Permissions
##########################################################################################

set_permissions() {
  : # Remove this if adding to this function

  # Note that all files/folders in magisk module directory have the $MODPATH prefix - keep this prefix on all of your files/folders
  # Some examples:
  
  # For directories (includes files in them):
  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  
  # set_perm_recursive $MODPATH/system/lib 0 0 0755 0644
  # set_perm_recursive $MODPATH/system/vendor/lib/soundfx 0 0 0755 0644

  # For files (not in directories taken care of above)
  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  
  # set_perm $MODPATH/system/lib/libart.so 0 0 0644
  # set_perm /data/local/tmp/file.txt 0 0 644
}

##########################################################################################
# MMT Extended Logic - Don't modify anything after this
##########################################################################################

SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
