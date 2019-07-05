///scr_player_const()

if (live_call()) return live_result;

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
