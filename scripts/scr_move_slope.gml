#define scr_move_slope
///scr_move_slope(spd)

var __sms_spd=argument0;
var newx = x+__sms_spd;
var newy = y; 

var blockedWall = false;

if(__sms_spd==0) exit;

//if (blockr && __sms_spd>0) blockedWall=true;
//else if (blockl && __sms_spd<0) blockedWall=true;

if( place_meeting(newx,newy, obj_blocks) ){
    blockedWall=true;
}

if(blockd){
    if( place_meeting(newx,newy, obj_blocks) ){
        while(true){
            newy-=1;
            
            if(!place_meeting(newx,newy, obj_blocks)){
                blockedWall = false;
                break;
            }
            else
            if(abs(y-newy)>=SLOPE_RANGE){
                newy = y;
                break;
            }
            
        }
    }
    else
    {
        blockedWall=false;
        
        while(true){
            newy+=1;
            
            if(place_meeting(newx,newy, obj_blocks)){
                newy-=1;
                break;
            }
            else
            if(abs(newy-y)>=SLOPE_RANGE){
                newy = y;
                break;
            }
            
        }
    }
}

if(!blockedWall) 
{
    x = newx;
    y = newy;
}
//else{show_debug_message("Blocked "+string(x) );}


#define scr_check_slope
///scr_check_slope(offX,offY)

var offx = argument0;
var offy = argument1;

return place_meeting(x+offx,y+offy, obj_slope);