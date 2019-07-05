
if (live_call()) return live_result;

//Check jump
if(!disabled && !inputsLocked){
    if (keyboard_check_pressed(obj_controller.btnJump))
      {
        if (blockd)
        {
          if (!jumping)
          {
            jumping = true;
            yInertia -= JUMP_VELOCITY[state];
            audio_play_sound(snd_player_jump,10,false);
          }
        }
    }
}
