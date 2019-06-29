#define scr_check_block
scr_check_blockR();
scr_check_blockL();
scr_check_blockU();
scr_check_blockD();

#define scr_check_blockR
if(place_meeting(x+1,y, obj_blocks)){
    blockr = true;
    onSlopeR = false;
    ceilSlopeR = false;
    
    if(!position_meeting(bbox_right+1, bbox_bottom-1-SLOPE_RANGE, obj_blocks) && 
    !position_meeting(bbox_right+1, bbox_top, obj_blocks)){
        onSlopeR = true;
    }
    else if(!position_meeting(bbox_right+1, bbox_top+1+SLOPE_RANGE, obj_blocks) && 
        !position_meeting(bbox_right+1, bbox_bottom, obj_blocks)){
        ceilSlopeR = true;
    }
}
else{
    blockr = false;
    onSlopeR = false;
    ceilSlopeR = false;
}

#define scr_check_blockL
if(place_meeting(x-1,y, obj_blocks)){
    blockl = true;
    onSlopeL = false;
    ceilSlopeL = false;
    
    if(!position_meeting(bbox_left-1, bbox_bottom-1-SLOPE_RANGE, obj_blocks) && 
        !position_meeting(bbox_left-1, bbox_top, obj_blocks)){
        onSlopeL = true;
    }
    else if(!position_meeting(bbox_left-1, bbox_top+1+SLOPE_RANGE, obj_blocks) && 
        !position_meeting(bbox_left-1, bbox_bottom, obj_blocks)){
        ceilSlopeL = true;
    }
}
else{
    blockl = false;
    onSlopeL = false;
    ceilSlopeL = false;
}


#define scr_check_blockU
if(place_meeting(x,y-1, obj_blocks)){
    blocku = true;
}
else{
    blocku = false;
}


#define scr_check_blockD
if(place_meeting(x,y+1, obj_blocks)){
    blockd = true;
}
else{
    blockd = false;
}