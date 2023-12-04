logf_print 0 '- wireless settings...';
db_set 'global' 'wifi_scan_always_enabled' '0';
db_set 'global' 'wifi_wakeup_enabled' '0';
db_set 'global' 'captive_portal_http_url' 'http://204.ustclug.org';
db_set 'global' 'captive_portal_https_url' 'https://204.ustclug.org';
db_set 'global' 'captive_portal_use_https' '1';
db_set 'global' 'captive_portal_mode' '0';
db_set 'global' 'wifi_display_on' '0';
db_set 'global' 'ble_scan_always_enabled' '0';

db_set 'global' 'enable_cellular_on_boot' '0';
db_set 'global' 'cell_on' '0';
db_set 'global' 'cdma_cell_broadcast_sms' '0';
db_set 'global' 'multi_sim_data_call' '-1';

db_set 'global' 'preferred_network_mode' '22';
db_set 'global' 'preferred_network_mode-2' '10';
db_set 'global' 'network_recommendations_enabled' '0';
db_set 'global' 'mobile_data' '0';
db_set 'global' 'mobile_data_always_on' '0';
db_set 'global' 'data_roaming' '0';

logf_print $? '- gps settings...';
db_set 'global' 'assisted_gps_enabled' '0';
db_set 'global' 'location_global_kill_switch' '1';
db_set 'global' 'location_background_throttle_interval_ms' '600000';
db_set 'secure' 'allowed_geolocation_origins' 'http://www.google.com http://www.google.co.uk'
db_set 'secure' 'locationPackagePrefixBlacklist' 'com.baidu.android.location';
db_set 'secure' 'locationPackagePrefixWhitelist' '';
db_set 'secure' 'mock_location' '1';
db_set 'secure' 'location_providers_allowed' '-gps,-data,-wifi';
db_set 'secure' 'location_changer' '2';

logf_print $? '- locales settings...';
db_set 'global' 'upload_apk_enable' '0';
db_set 'system' 'system_locales' 'en-US,bo-IN,zh-Hant-TW,zh-Hans-CN';
db_set 'secure' 'default_input_method' 'kl.ime.oh/.I';
db_set 'secure' 'enabled_input_methods' 'org.videomap.droidmoteclient/.DroidMoteClientIme:kl.ime.oh/.I:com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME';
db_set 'secure' 'tts_default_locale' 'com.google.android.tts:cmn_CN';
db_set 'secure' 'tts_default_synth' 'com.google.android.tts';
db_set 'secure' 'voice_interaction_service' '';

logf_print $? '- other settings...';
db_set 'global' 'boot_count' '1';
db_set 'global' 'Phenotype_boot_count' '1';
db_set 'secure' 'lock_screen_owner_info_enabled' '0';
db_set 'secure' 'lock_screen_show_notifications' '0';
db_set 'secure' 'sysui_qs_tiles' 'wifi,hotspot,bt,location,cell,airplane,caffeine,flashlight,battery,rotation,nfc,cast,reading_mode,night,dnd,custom(com.example.barcodescanner/.feature.tile.QuickSettingsTileService),custom(web1n.stopapp/.service.QuickSettingService),profiles';
db_set 'system' 'transition_animation_scale' '0.0';
db_set 'system' 'window_animation_scale' '0.0';
db_set 'system' 'animator_duration_scale' '0.0';
db_set 'system' 'volume_alarm' '1';
db_set 'system' 'volume_bluetooth_sco' '1';
db_set 'system' 'volume_music' '3';
db_set 'system' 'volume_music_speaker' '0';
db_set 'system' 'volume_notification' '1';
db_set 'system' 'volume_ring' '3';
