#define scr_player
///scr_player()
//Set in create

//Initialize variables
scr_player_const();
scr_player_state();

A_IDLE = array(0);
A_JUMP = array(2);
A_FALL = array(1);
A_WALK = array(2,0,1,0);

A_IDLEUP = array(3);
A_JUMPUP = array(5);
A_FALLUP = array(4);
A_WALKUP = array(5,3,4,3);

A_JUMPDOWN = array(7);
A_FALLDOWN = array(6);
A_INSPECT = array(8);

scr_set_anim(spriteIndex, A_IDLE, 0);


#define scr_player_const
///scr_player_const()

enum physicsType{
    LAND,
    WATER
}

REPEL_SPEED = 1*CSF;
SLOPE_RANGE = 5;

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

spriteIndex = spr_player;

curdir = -1;
curVertDir = 0;

lookaway = false;
walking = false;
dead = false;
drown = false;
disabled = false;
hide = false;
jumping = false;

prevImageIndex = 0;
prevWalking = false;

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
        audio_play_sound(snd_player_jump,10,false);
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
    

if (xInertia > DECEL_SPEED[state] || xInertia < -DECEL_SPEED[state])
{
    scr_apply_xInertia(xInertia);
}

scr_apply_yInertia(yInertia);

#define scr_player_anim

if(!blockd){
    if(jumping){
        if(curVertDir == -1)
            scr_set_anim(spriteIndex, A_JUMPUP, 0);
        else if(curVertDir == 1)
            scr_set_anim(spriteIndex, A_JUMPDOWN, 0);
        else
            scr_set_anim(spriteIndex, A_JUMP, 0);
    }
    else {
        if(curVertDir == -1)
            scr_set_anim(spriteIndex, A_FALLUP, 0);
        else if(curVertDir == 1)
            scr_set_anim(spriteIndex, A_FALLDOWN, 0);
        else
            scr_set_anim(spriteIndex, A_FALL, 0);
    }
}
else if(walking){
    if(curVertDir == -1)
        scr_set_anim(spriteIndex, A_WALKUP, 0.15);
    else
        scr_set_anim(spriteIndex, A_WALK, 0.15);
}
else
{
    if(curVertDir == -1)
        scr_set_anim(spriteIndex, A_IDLEUP, 0);
    else
        scr_set_anim(spriteIndex, A_IDLE, 0);

}

#define scr_player_aftermove
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


prevWalking = walking;


#define scr_player_repel


#define scr_player_sound
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
