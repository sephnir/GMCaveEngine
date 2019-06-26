#define scr_player
///scr_player()
//Set in create

//Initialize variables
scr_player_const();
scr_player_state();

A_IDLE_LEFT = array(0);
A_JUMP_LEFT = array(2);
A_FALL_LEFT = array(1);
A_WALK_LEFT = array(2,0,1,0);
A_UP_LEFT = array(3,4,3,5);

A_IDLE_RIGHT = array(11);
A_JUMP_RIGHT = array(13);
A_FALL_RIGHT = array(12);
A_WALK_RIGHT = array(13,11,12,11);
A_UP_RIGHT = array(14,15,14,16);



scr_set_anim(spr_player, A_IDLE_LEFT, 0);


#define scr_player_const
///scr_player_const()

enum physicsType{
    LAND,
    WATER
}

REPEL_SPEED = 1*CSF;
SLOPE_RANGE = 10;

//Land
WALK_SPEED[physicsType.LAND] = $32c;
FALL_SPEED[physicsType.LAND] = $5ff;

FALL_ACCEL[physicsType.LAND] = $50;
JUMP_FALL_ACCEL[physicsType.LAND] = $20;

WALK_ACCEL[physicsType.LAND] = $55;
JUMP_WALK_ACCEL[physicsType.LAND] = $20;

DECEL_SPEED[physicsType.LAND] = $33;
JUMP_VELOCITY[physicsType.LAND] = $500;

//Water
WALK_SPEED[physicsType.WATER] = $196;
FALL_SPEED[physicsType.WATER] = $2ff;

FALL_ACCEL[physicsType.WATER] = $28;
JUMP_FALL_ACCEL[physicsType.WATER] = $10;

WALK_ACCEL[physicsType.WATER] = $2a;
JUMP_WALK_ACCEL[physicsType.WATER] = $10;

DECEL_SPEED[physicsType.WATER] = $19;
JUMP_VELOCITY[physicsType.WATER] = $280;

#define scr_player_state
///scr_player_state()

curdir = 1;

lookaway = false;
walking = false;
dead = false;
drown = false;
disabled = false;
hide = false;
jumping = false;

onSlopeL = false;
onSlopeR = false;
ceilSlopeL = false;
ceilSlopeR = false;

blockd = true;
blocku=false;
blockr=false;
blockl=false;

hurtTime = 0;
hurtFlashState = 0;

xInertia = 0;
yInertia = 0;

state = physicsType.LAND;

#define scr_player_jump

//Check jump
if (keyboard_check_pressed(obj_controller.btnJump))
  {
    if (blockd)
    {
      if (!jumping)
      {
        jumping = true;
        yInertia -= JUMP_VELOCITY[state];
      }
    }
}

#define scr_player_walk
///scr_player_walk()
//Set in step

var walkAccel;

if(blockd)
    walkAccel = WALK_ACCEL[state] 
else 
    walkAccel = JUMP_WALK_ACCEL[state];

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
        if (!ceilSlopeL && xInertia < - $180)
          xInertia = -$180;
        if (xInertia < 0 && !keyboard_check(obj_controller.btnLeft))
          xInertia = 0;
      }
      if (blockr)
      {
        if (!ceilSlopeR && xInertia > $180)
          xInertia = $180;
        if (xInertia > 0 && !keyboard_check(obj_controller.btnRight))
          xInertia = 0;
      }
}


#define scr_player_fall

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

#define scr_player_move
///scr_player_move()
//Set in step

if (xInertia > FALL_SPEED[state])
    xInertia = FALL_SPEED[state];
if (xInertia < -FALL_SPEED[state])
    xInertia = -FALL_SPEED[state];
if (yInertia > FALL_SPEED[state])
    yInertia = FALL_SPEED[state];
if (yInertia < -FALL_SPEED[state])
    yInertia = -FALL_SPEED[state];
if (blockd && yInertia > 0)
    yInertia = 0;
    
scr_apply_yInertia(yInertia);

if (xInertia > DECEL_SPEED[state] || xInertia < -DECEL_SPEED[state])
{
    scr_apply_xInertia(xInertia);
}

#define scr_player_anim

if(!blockd){
    if(jumping){
        if(curdir > 0){
            scr_set_anim(spr_player, A_JUMP_RIGHT, 0);
        }
        if(curdir < 0){
            scr_set_anim(spr_player, A_JUMP_LEFT, 0);
        }
    }
    else {
        if(curdir > 0){
            scr_set_anim(spr_player, A_FALL_RIGHT, 0);
        }
        if(curdir < 0){
            scr_set_anim(spr_player, A_FALL_LEFT, 0);
        }
    }
}
else if(walking){
    if(curdir > 0){
        scr_set_anim(spr_player, A_WALK_RIGHT, 0.15);
    }
    if(curdir < 0){
        scr_set_anim(spr_player, A_WALK_LEFT, 0.15);
    }
}
else
{
    if(curdir > 0){
        scr_set_anim(spr_player, A_IDLE_RIGHT, 0);
    }
    if(curdir < 0){
        scr_set_anim(spr_player, A_IDLE_LEFT, 0);
    }
}

#define scr_player_aftermove
// handle landing and bonking head
if (blockd && yInertia > 0)
{
  yInertia      = 0;
  jumping       = 0;
}
else if (blocku && yInertia < 0)
{
  // he behaves a bit differently when bonking his head on a
  // solid-brick object vs. bonking his head on the map.

  
  yInertia = 0;
  jumping = false;
    
}
#define scr_player_repel
