///scr_make_splash(obj_water_instance)
var obj = argument0;

var __vspd = yInertia/CSF/3, //This instance's vertical speed
__pos = mean(bbox_left,bbox_right); //And it's horizontal center
 
with obj {
    __pos -= x; //Compared to the water's placement
    __pos = clamp(round(__pos/sprite_width*nodes),0,nodes-1); //Converted to placement in array
    vspd[__pos] += __vspd;
}
