/*
-------- Configuration of the Light System
---- Here is defined values for the global variables used by the system.
*/

/*
Defines the alpha for the dark areas.
- Value is 0 to 1.
*/
_ls_lightmap_brightness = 0.7;

/*
Turns lightmap update on, refresing the light and shadows.
- Value is true or false.
*/
_ls_use_lightmap_update = true;

/*
How much the lightmap recalculates everything by second
- The value must be equal or less than room_speed
*/
_ls_lightmap_update_by_second = 10;

/*
If lightblockers will be used. Light stops when hit a lightblocker.
- Value is true or false.
*/
_ls_use_lightblockers = false;

/*
If flickering will be used by the system.
- Value is true or false.
*/
_ls_shadow_flickering = false;

/*
How much flickering do happens by the second.
- Value cannot be higher than room_speed
*/
_ls_flickerings_by_second = 10;

/*
Whitout that, lightblockers will be dark inside.
- Value is true or false.
*/
_ls_use_extralight = false;

/*
Alpha for extra light.
- Value from 0 to 1.
*/
_ls_extralight_bright = 0;

/*
Optimize the system to use views. Every calculation will be limited to the view area.
- Value is true or false.
*/
_ls_use_views = true;
