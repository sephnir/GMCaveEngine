
if (live_call()) return live_result;

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
else if(lookaway){
    scr_set_anim(spriteIndex, A_INSPECT, 0);
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
