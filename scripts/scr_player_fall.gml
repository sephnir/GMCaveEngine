
if (live_call()) return live_result;

if(disabled) exit;

if (yInertia < 0 && keyboard_check(obj_controller.btnJump))
  { 
    // use jump gravity
    if (yInertia < FALL_SPEED[state])
    {
      yInertia += JUMP_FALL_ACCEL[state];
      if (yInertia > FALL_SPEED[state])
        yInertia = FALL_SPEED[state];
    }
  }
  else
  { // use normal gravity
    if (yInertia < FALL_SPEED[state])
    {
      yInertia += FALL_ACCEL[state];
      if (yInertia > FALL_SPEED[state])
        yInertia = FALL_SPEED[state];
    }

    // if we no longer qualify for jump gravity then the jump is over
    jumping = 0;
}
