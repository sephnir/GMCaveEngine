///scr_player_walk()

if (live_call()) return live_result;

//Set in step

var walkAccel;

if(blockd)
    walkAccel = WALK_ACCEL[state] 
else 
    walkAccel = JUMP_WALK_ACCEL[state];

if(!disabled && !inputsLocked){
    //Check Up/Down
    if(keyboard_check(obj_controller.btnUp)){
        curVertDir = -1;
    }
    else if(!blockd && keyboard_check(obj_controller.btnDown)){
        curVertDir = 1;
    }
    else{
        curVertDir = 0;
    }
        
    //Check left
    if(keyboard_check(obj_controller.btnLeft)){
        curdir = -1;
        walking = true;
        
        if(xInertia > -WALK_SPEED[state]){
            xInertia -= WALK_ACCEL[state];
            
            if(xInertia < -WALK_SPEED[state]){
                xInertia = -WALK_SPEED[state];
            }
        }
        
    }
    
    else
    //Check right
    if(keyboard_check(obj_controller.btnRight)){
        curdir = 1;
        walking = true;
        
        if(xInertia < WALK_SPEED[state]){
            xInertia += WALK_ACCEL[state];
            
            if(xInertia > WALK_SPEED[state]){
                xInertia = WALK_SPEED[state];
            }
        }
    }
    
    else
    //No movement
    {
        walking = false;
    }
}
else{
    walking = false;
}

if (blockd && yInertia >= 0)
  { // deceleration on ground...
    // always move towards zero at decelspeed
    if (xInertia > 0)
    {
      if (!onSlopeR && blockr && !keyboard_check(obj_controller.btnRight))
      {
        xInertia = 0;
      }
      else if (xInertia > DECEL_SPEED[state])
      {
        xInertia -= DECEL_SPEED[state];
      }
      else
      {
        xInertia = 0;
      }
    }
    else if (xInertia < 0)
    {
      if (!onSlopeL && blockl && !keyboard_check(obj_controller.btnLeft))
      {
        xInertia = 0;
      }
      else if (xInertia < -DECEL_SPEED[state])
      {
        xInertia += DECEL_SPEED[state];
      }
      else
      {
        xInertia = 0;
      }
    }
  }
  else // deceleration in air...
    {
      // implements 2 things
      //1) if player partially hits a brick while in air, his inertia is lesser after he passes it
      //2) but, if he's trying to turn around, let him! don't "stick" him to it just because
      //of a high inertia when he hit it
      if (blockl)
      {
        if (xInertia < - $180){
            xInertia = -$180;
          
          }
        if (xInertia < 0 && !keyboard_check(obj_controller.btnLeft))
          xInertia = 0;
      }
      if (blockr)
      {
        if (xInertia > $180){
          xInertia = $180;
          }
        if (xInertia > 0 && !keyboard_check(obj_controller.btnRight))
          xInertia = 0;
      }
}

