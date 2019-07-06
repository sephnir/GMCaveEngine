while(!ds_queue_empty(obj_controller.actionList)){
    var actionType = ds_queue_dequeue(obj_controller.actionList); 
    var actionMsg = ds_queue_dequeue(obj_controller.actionMsg); 
    
    if(actionType == obj_controller.ACTION_TYPE.MSG_LINE){
        scr_textbox_setText(actionMsg);
        break;
    }
    else if(actionType == obj_controller.ACTION_TYPE.MSG_FACE){
        var num = string_split(actionMsg, " ");
        scr_textbox_setFace(real(num[0]),real(num[1]),real(num[2]));
    }
    else if(actionType == obj_controller.ACTION_TYPE.MSG_CLEAR){
        scr_textbox_clearText();
    }
    else break;
}
