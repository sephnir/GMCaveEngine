///scr_player_move()

if (live_call()) return live_result;

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
