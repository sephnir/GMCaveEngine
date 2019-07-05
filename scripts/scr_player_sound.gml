
if (live_call()) return live_result;

if(prevImageIndex != image_index) {
    prevImageIndex = image_index;

    if(walking){
        if(image_index == 0 || image_index == 3){
            audio_play_sound(snd_player_walk,10,false);
        }
    }
}

    
if(prevWalking!=walking && !walking && blockd){
    audio_play_sound(snd_player_walk,10,false);
}
