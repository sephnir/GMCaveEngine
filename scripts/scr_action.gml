enum ACTION_TYPE{
    MSG_LINE,
    MSG_CONT,
    MSG_WLAO,
    MSG_CLEAR,
    MSG_FACE
}

actionList = ds_queue_create();
actionMsg = ds_queue_create();
