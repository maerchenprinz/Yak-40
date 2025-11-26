var help_win = screen.window.new( 0, 0, 1, 3 );
help_win.fg = [0,1,1,1];

var help_winRoll = screen.window.new();
help_winRoll.fg = [1,1,1,1];
help_winRoll.x = -20 ;
help_winRoll.y = 20 ;
help_winRoll.align = "right" ;
help_winRoll.maxlines = 1 ;
help_winRoll.autoscroll = 5 ;

var help_winPitch = screen.window.new();
help_winPitch.fg = [1,1,1,1];
help_winPitch.x = -20 ;
help_winPitch.y = 36 ;
help_winPitch.align = "right" ;
help_winPitch.maxlines = 1 ;
help_winPitch.autoscroll = 5 ;

# Printing roll knob position
var KnobRollControl = func {
   var RollKnobpos = getprop("autopilot/internal/target-roll-deg");
   help_winRoll.write(sprintf("Roll Knob %.1f degrees", RollKnobpos) );
}
 setlistener( "autopilot/internal/target-roll-deg", KnobRollControl, 0, 0 );

# Printing roll knob position
var KnobPitchControl = func {
   var PitchKnobpos = getprop("autopilot/internal/target-pitch-deg");
   help_winPitch.write(sprintf("Pitch Knob %.1f degrees", PitchKnobpos) );
}
 setlistener( "autopilot/internal/target-pitch-deg", KnobPitchControl, 0, 0 );
