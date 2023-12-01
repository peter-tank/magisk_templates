# magisk_templates for Vivo/Android 11, Funtouch 10.5

```
.
├── README.md
├── T2Hardkey
│   ├── LICENSE
│   ├── META-INF
│   │   └── com
│   │       └── google
│   │           └── android
│   │               ├── update-binary
│   │               └── updater-script
│   ├── README.md
│   ├── common
│   │   ├── functions.sh
│   │   └── install.sh
│   ├── customize.sh
│   ├── module.prop
│   ├── system
│   │   └── usr
│   │       └── keylayout
│   │           └── Generic.kl
│   └── uninstall.sh
├── aik_suu
│   ├── aik
│   ├── aik.diff
│   ├── remount.sh
│   ├── remount.sh.diff
│   └── tsu.diff
├── gapps_core
│   ├── META-INF
│   │   └── com
│   │       └── google
│   │           └── android
│   │               ├── update-binary
│   │               └── updater-script
│   ├── common
│   │   ├── addon
│   │   │   └── placeholder
│   │   ├── functions.sh
│   │   └── install.sh
│   ├── customize.sh
│   ├── data_com.android.vending
│   ├── data_com.google.android.gms
│   ├── data_com.google.android.gsf
│   ├── fake.sh
│   ├── functions.sh
│   ├── module.prop
│   ├── pre_install.app
│   ├── pre_install.sh
│   ├── sepolicy.rule
│   ├── service.app
│   ├── service.sh
│   ├── system
│   │   ├── etc
│   │   │   ├── permissions
│   │   │   │   ├── com.android.launcher3.xml
│   │   │   │   ├── com.google.android.apps.maps.xml
│   │   │   │   ├── com.google.android.apps.nexuslauncher.xml
│   │   │   │   └── privapp-permissions-com.google.android.apps.nexuslauncher.xml
│   │   │   └── sysconfig
│   │   │       └── hiddenapi-whitelist-com.google.android.apps.nexuslauncher.xml
│   │   ├── framework
│   │   │   ├── com.google.android.maps.jar
│   │   │   ├── com.google.android.media.effects.jar
│   │   │   └── com.google.widevine.software.drm.jar
│   │   ├── lib64
│   │   ├── priv-app
│   │   │   ├── AndroidPlatformServices
│   │   │   ├── GoogleServicesFramework
│   │   │   │   └── oat
│   │   │   │       └── arm64
│   │   │   ├── Phonesky
│   │   │   └── PrebuiltGmsCore
│   │   │       └── m
│   │   │           └── independent
│   │   ├── product
│   │   │   └── app
│   │   │       └── LatinIMEGooglePrebuilt
│   │   └── usr
│   │       ├── share
│   │       │   └── ime
│   │       │       └── google
│   │       │           └── d3 lms
│   │       └── srec
│   │           └── en-US
│   └── uninstall.sh
├── gapps_product
│   ├── META-INF
│   │   └── com
│   │       └── google
│   │           └── android
│   │               ├── update-binary
│   │               └── updater-script
│   ├── common
│   │   ├── addon
│   │   │   └── placeholder
│   │   ├── functions.sh
│   │   └── install.sh
│   ├── customize.sh
│   ├── data_com.android.vending
│   ├── fake.sh
│   ├── functions.sh
│   ├── module.prop
│   ├── pre_install.app
│   ├── pre_install.sh
│   ├── sepolicy.rule
│   ├── service.app
│   ├── service.sh
│   ├── system
│   │   ├── app
│   │   │   ├── Gmail2
│   │   │   │   └── oat
│   │   │   │       └── arm64
│   │   │   └── YouTube
│   │   │       └── oat
│   │   │           ├── arm
│   │   │           └── arm64
│   │   └── etc
│   │       └── permissions
│   │           └── com.google.android.apps.maps.xml
│   └── uninstall.sh
├── vivo_installer
│   ├── META-INF
│   │   └── com
│   │       └── google
│   │           └── android
│   │               ├── update-binary
│   │               └── updater-script
│   ├── com.android.packageinstaller
│   ├── common
│   │   ├── addon
│   │   │   └── placeholder
│   │   ├── functions.sh
│   │   └── install.sh
│   ├── customize.sh
│   ├── data_com.android.chrome
│   ├── data_com.android.location.fused
│   ├── data_com.android.packageinstaller
│   ├── data_kl.ime.oh
│   ├── fake.sh
│   ├── functions.sh
│   ├── module.prop
│   ├── pre_install.app
│   ├── pre_install.sh
│   ├── selinux.filter
│   ├── sepolicy.rule
│   ├── service.app
│   ├── service.sh
│   ├── system
│   │   ├── app
│   │   │   ├── kl.ime.oh
│   │   │   │   ├── lib
│   │   │   │   │   └── arm
│   │   │   │   └── ota
│   │   │   └── klye.hanwriting
│   │   │       └── lib
│   │   │           └── arm
│   │   ├── priv-app
│   │   │   ├── FusedLocation
│   │   │   │   └── oat
│   │   │   │       └── arm64
│   │   │   └── PackageInstaller
│   │   │       └── oat
│   │   │           └── arm64
│   │   └── product
│   │       └── app
│   │           └── Chrome
│   │               └── oat
│   │                   ├── arm
│   │                   └── arm64
│   ├── system.prop
│   ├── uninstall.sh
│   ├── v_deleted_sys_app.xml
│   └── vivo_settings.sh
└── vivo_mods
    ├── META-INF
    │   └── com
    │       └── google
    │           └── android
    │               ├── update-binary
    │               └── updater-script
    ├── common
    │   ├── addon
    │   │   └── placeholder
    │   ├── functions.sh
    │   └── install.sh
    ├── customize.sh
    ├── module.prop
    ├── sepolicy.rule
    ├── system
    │   ├── etc
    │   │   ├── default-permissions
    │   │   │   ├── default-permissions-google.xml
    │   │   │   ├── default-permissions.xml
    │   │   │   └── nikgapps-permissions.xml
    │   │   ├── launcher
    │   │   │   └── preconfig.xml
    │   │   ├── permissions
    │   │   │   ├── GoogleCellBroadcast_permissions.xml
    │   │   │   ├── GoogleDocumentsUI_permissions.xml
    │   │   │   ├── GoogleExtServices_permissions.xml
    │   │   │   ├── GoogleMediaProvider_permissions.xml
    │   │   │   ├── GoogleNetworkStack_permissions.xml
    │   │   │   ├── GooglePermissionController_permissions.xml
    │   │   │   ├── GoogleTethering_permissions.xml
    │   │   │   ├── NikGapps-privapp-permissions-google.xml
    │   │   │   ├── com.android.vending.xml
    │   │   │   ├── com.google.android.dialer.support.xml
    │   │   │   ├── com.google.android.gms.xml
    │   │   │   ├── com.google.android.gsf.xml
    │   │   │   ├── privapp-permissions-google-comms-suite.xml
    │   │   │   ├── privapp-permissions-google-p.xml
    │   │   │   ├── privapp-permissions-google-product.xml
    │   │   │   ├── privapp-permissions-google-system-ext.xml
    │   │   │   ├── privapp-permissions-google-system.xml
    │   │   │   ├── privapp-permissions-hotword.xml
    │   │   │   ├── privapp-permissions-vivo.xml
    │   │   │   ├── privapp-permissions-vivo.xml.diff
    │   │   │   └── split-permissions-google.xml
    │   │   ├── selinux_later
    │   │   │   ├── plat_mac_permissions.xml
    │   │   │   ├── plat_sepolicy.cil
    │   │   │   ├── plat_sepolicy.cil.diff
    │   │   │   └── plat_sepolicy_and_mapping.sha256
    │   │   ├── sysconfig
    │   │   │   ├── GoogleCellBroadcast_config.xml
    │   │   │   ├── backup.xml
    │   │   │   ├── com.google.android.mainline.patchlevel.1.xml
    │   │   │   ├── dialer_experience.xml
    │   │   │   ├── google-hiddenapi-package-allowlist.xml
    │   │   │   ├── google-hiddenapi-package-whitelist.xml
    │   │   │   ├── google-rollback-package-whitelist.xml
    │   │   │   ├── google-staged-installer-whitelist.xml
    │   │   │   ├── google.xml
    │   │   │   ├── google_build.xml
    │   │   │   ├── google_vr_build.xml
    │   │   │   ├── nexus.xml
    │   │   │   ├── nga.xml
    │   │   │   ├── pixel.xml
    │   │   │   ├── pixel_2019_exclusive.xml
    │   │   │   ├── pixel_experience_2017.xml
    │   │   │   ├── pixel_experience_2018.xml
    │   │   │   ├── pixel_experience_2019.xml
    │   │   │   ├── pixel_experience_2019_midyear.xml
    │   │   │   ├── pixel_experience_2020.xml
    │   │   │   ├── pixel_experience_2020_midyear.xml
    │   │   │   ├── preinstalled-packages-platform-handheld-product.xml
    │   │   │   ├── preinstalled-packages-platform-overlays.xml
    │   │   │   └── wellbeing.xml
    │   │   └── vivo-default-permissions
    │   │       ├── default-permissions-vivo.xml
    │   │       └── default-permissions-vivo.xml.diff
    │   ├── odm
    │   │   └── etc
    │   │       └── selinux
    │   │           └── precompiled_sepolicy
    │   ├── product
    │   │   ├── build.prop
    │   │   ├── build.prop.diff
    │   │   └── etc
    │   │       └── security
    │   │           └── fsverity
    │   │               └── play_store_fsi_cert.der
    │   └── vendor
    │       ├── build.prop.diff
    │       ├── build.propb
    │       └── etc
    │           └── vivo_config.ini
    ├── system.prop
    └── uninstall.sh

114 directories, 155 files
```
