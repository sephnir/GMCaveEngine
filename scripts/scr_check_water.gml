var splashImpact = 0; 

var tempX = mean(bbox_left,bbox_right);
var tempY = mean(bbox_top, bbox_bottom);

if(place_meeting(x,y, obj_water)){
    if(state == physicsType.LAND){
        if ((yInertia > $200 && !blockd) || 
            (xInertia < -$200 || xInertia > $200)){
            audio_play_sound(snd_splash,10,false);   
            splashImpact = yInertia/CSF/6;
            
            repeat(8){
                var droplet = instance_create(tempX-8+random(16),tempY,obj_droplet);
                droplet.xInertia = -$200+random($400) + xInertia/2;
                droplet.yInertia = -$200+random($280) - yInertia/2;
            }
            
            repeat(8){
                var bubble = instance_create(tempX-8+random(16),bbox_bottom,obj_bubble);
                bubble.xInertia = -$100+random($200) + xInertia/4;
                bubble.yInertia = $50+random($150) + yInertia/4;
            }
        }
    }
    
    scr_make_splash( instance_place(x,y,obj_water), splashImpact );
    
    state = physicsType.WATER;
}
else{
    state = physicsType.LAND;
    
}
