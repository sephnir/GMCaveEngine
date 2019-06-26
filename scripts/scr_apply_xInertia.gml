///scr_apply_xInertia(inertia)

var inertia = argument0;

if(inertia>0){
    while (inertia > (1 * CSF)){
        //x+=1;
        scr_move_slope(1);
        inertia -= 1*CSF;
        
        scr_check_block();
    }
    
}
else if(inertia<0){
    while (inertia < -(1 * CSF)){
        //x-=1;
        scr_move_slope(-1);
        inertia += 1*CSF;
        
        scr_check_block();
    }
}

if (inertia != 0){
    scr_check_block();
    scr_move_slope(inertia/CSF);
}

