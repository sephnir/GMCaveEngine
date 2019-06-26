///scr_player_play_anim()
///Call on step


__sanim_current += __sanim_animSpd;

if(__sanim_current >= __sanim_length){
    __sanim_current = 0;
}

image_index = __sanim_seqArray[floor(__sanim_current)];

