logf_print $? '- google tts settings...';
db_set 'secure' 'tts_default_locale' 'com.google.android.tts:cmn_CN';
db_set 'secure' 'tts_default_synth' 'com.google.android.tts';
db_set 'secure' 'voice_interaction_service' '';

logf_print $? '- locales settings...';
db_set 'secure' 'default_input_method' 'com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME';
db_set 'secure' 'enabled_input_methods' 'org.videomap.droidmoteclient/.DroidMoteClientIme:kl.ime.oh/.I:com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME';
