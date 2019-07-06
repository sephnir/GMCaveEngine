///scr_action_readScript(fileName, snippetName)
if (live_call(argument0,argument1)) return live_result;

var fileName = argument0;
var snippetName = argument1;

var state = 0;

var file = file_text_open_read(working_directory + "script/" + fileName);

while(!file_text_eof(file)){
    var line = string_split(file_text_read_string(file) ," ");
    
    if(array_length_1d(line)==0) continue;
    
    var header = line[0];
    header = string_replace_all(header, ' ', '');
    
    if(state == 0 && string_char_at(header, 1)=="#" ){
        var oriSnippetName = header;
        
        if(oriSnippetName == '#'+snippetName){
            state = 1;
            file_text_readln(file);
            continue;
        }
    }
    else if(state>0 && string_char_at(header, 1)=="#"){
        break;
    }
    
    header = string_lettersdigits(header);
        
    if(state>0){
        var msg = "";
        
        if(array_length_1d(line)>1){
            msg = line[1];
            for(i=2; i< array_length_1d(line); i++ ){
                msg += " " +line[i];
            }
        }
        
        switch(header){
            case "MSG": with(obj_controller) scr_action_add(ACTION_TYPE.MSG_LINE, msg); break;
            case "FAC": with(obj_controller) scr_action_add(ACTION_TYPE.MSG_FACE, msg); break;
            case "CON": with(obj_controller) scr_action_add(ACTION_TYPE.MSG_CONT, msg); break;
            case "CLR": with(obj_controller) scr_action_add(ACTION_TYPE.MSG_CLEAR, msg); break;
        }
    }
    
    file_text_readln(file);
}

file_text_close(file);
scr_action_notify();
