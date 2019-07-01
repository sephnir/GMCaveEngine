///scr_make_splash(obj_water_instance, manualSplashImpact)
var obj = argument0;
var splash = argument1;

var __vspd = yInertia/CSF/3, //This instance's vertical speed
__pos = mean(bbox_left,bbox_right); //And it's horizontal center
var __x = __pos;

with obj {
    __pos -= x; //Compared to the water's placement
    __pos = clamp(round(__pos/sprite_width*nodes),0,nodes-1); //Converted to placement in array
    vspd[__pos] += __vspd;
    
    if(splash>0){
        objSplash = instance_create(__x,ypos[__pos], obj_splash);
        objSplash.x = __x - objSplash.sprite_width/2
        objSplash.image_yscale = splash;
        objSplash.following = self;
        objSplash.followingIndex = __pos;
    }
}
