///scr_player_state()

if (live_call()) return live_result;

spriteIndex = spr_player;

maxhp = 3;
hp = 3;

curdir = -1;
curVertDir = 0;

lookaway = false;
walking = false;
dead = false;
drown = false;
disabled = false;
hide = false;
jumping = false;

lookScrollWant = 0;

inputsLocked = false;
inputsLockedPrev = true;

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
prevState = physicsType.LAND;
