
if (live_call()) return live_result;

// handle landing and bonking head
if (blockd && yInertia > 0)
{
    if (yInertia > $400 && !hide){
        audio_play_sound(snd_thud, 10, false);
    }

    yInertia = 0;
    jumping = 0;
}
else if (blocku && yInertia < 0)
{

    if (yInertia < -$200 && !hide && blocku){
        instance_create(x+sprite_width/2 , bbox_top, obj_star_caret);    
        instance_create(x+sprite_width/2 , bbox_top, obj_star_caret);   
    
        audio_play_sound(snd_bonk_head, 10, false);
    }

    yInertia = 0;
    jumping = false;
      
}


if(obj_controller.msgVisible){
    inputsLocked = true;
}
else{
    inputsLocked = false;
}

prevWalking = walking;

