create_macros();
create_globals();

create_savefile();

load_savefile();
load_settings();

audio_master_gain(ss.vol);
set_fullscreen(ss.fullscreen);

audio_stop_all();

exception_unhandled_handler(error);

randomize();