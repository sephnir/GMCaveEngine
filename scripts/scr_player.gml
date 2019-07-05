///scr_player()
//Set in create

if (live_call()) return live_result;

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

