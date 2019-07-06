///scr_action_add(action, message)

var action = argument0;
var message = argument1;

ds_queue_enqueue(actionList, action);
ds_queue_enqueue(actionMsg, message);
