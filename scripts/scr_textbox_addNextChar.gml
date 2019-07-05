
if(ds_list_size(msgWaitingText) == 0) exit;

var lastEntry = ds_list_size(msgDisplayedText)-1;
    
var limit = MSG_MAXLINELEN_NO_FACE;
if(msgFaceIndex>=0) limit = MSG_MAXLINELEN_FACE;

if(msgTextLineAtOnce) {
    var tempSize = limit-1;
    if( string_length( ds_list_find_value(msgWaitingText,0)) <tempSize ) tempSize = string_length( ds_list_find_value(msgWaitingText,0));
    
    if(tempSize == 0) exit;
    
    ds_list_replace(msgDisplayedText, lastEntry, string_copy( ds_list_find_value(msgWaitingText,0) , 1, tempSize ) );
    ds_list_replace( msgWaitingText, 0 ,string_delete( ds_list_find_value(msgWaitingText,0),1,tempSize ));
        
    msgMouthSeq=-1;
        
    if(string_length(ds_list_find_value(msgDisplayedText,lastEntry)) >= limit-1){
        scr_textbox_addNextLine();
        exit;
    }
}

if( string_length(ds_list_find_value(msgWaitingText,0))>0 ){
    ds_list_replace( msgDisplayedText, lastEntry, ds_list_find_value(msgDisplayedText,lastEntry) + string_char_at( ds_list_find_value(msgWaitingText,0) , 0 ) );
    ds_list_replace( msgWaitingText, 0 ,string_delete( ds_list_find_value(msgWaitingText,0),1,1 ) );
    
    msgMouthSeq = msgMouthSeq+1 mod 4;
    msgCursorVisible = false;
    
    if(string_length(ds_list_find_value(msgDisplayedText,lastEntry)) >= limit-1){
        scr_textbox_addNextLine();
        exit;
    }
    
}
else{
    msgMouthSeq=-1;
    msgCursorVisible = true;
}
