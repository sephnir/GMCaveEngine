if(place_meeting(x,y, obj_water)){
    scr_make_splash( instance_place(x,y,obj_water) );
    state = physicsType.WATER;
}
else{
    state = physicsType.LAND;
}
