if (live_call()) return live_result;

if(keyboard_check(obj_controller.btnDown))
{
    if(!disabled && !inputsLocked){
        if(keyboard_check_pressed(obj_controller.btnDown) && blockd){    
            if(!walking && !lookaway && !keyboard_check(obj_controller.btnJump) && !keyboard_check(obj_controller.btnShoot)){
                xInertia = 0;
                lookaway = true;
                instance_create(x,y,obj_qmark);
            }
            
        }
    }

}

//Lookaway deactivation
if(lookaway){
    var btnList = array(obj_controller.btnLeft,obj_controller.btnRight,obj_controller.btnUp,
        obj_controller.btnJump, obj_controller.btnShoot, -1);
    
    for(i=0;true;i++){
        key = btnList[i];
        if(key == -1) break;
        
        if(keyboard_check(key)){
            lookaway = false;
            break;
        }
    }
    
    if(!blockd){
        lookaway = false;
    }
}
