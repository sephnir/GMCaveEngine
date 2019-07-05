ds_list_add(msgDisplayedText, "");

//Clears the oldest line if there are more than 3
if( ds_list_size(msgDisplayedText) > 3 && !msgTextLineAtOnce ) msgTextScroll = true;

if(ds_list_size(msgDisplayedText)> 3 && msgTextLineAtOnce )
    ds_list_delete(msgDisplayedText,0);
