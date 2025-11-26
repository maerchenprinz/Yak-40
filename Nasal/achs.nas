#  Stopwatch
var stopwatch = maketimer(1, func(){
	var speedup = getprop("/sim/speed-up");
	var sw_time = getprop("yak-40/AChS/stopwatch");
	var sw_time = sw_time + speedup ;
	setprop("yak-40/AChS/stopwatch", int(sw_time));
});

# Flighttime
var flitetimer = maketimer(1, func(){
	var speedup = getprop("/sim/speed-up");
	var fl_time = getprop("yak-40/AChS/flighttime");
	var fl_time = fl_time + speedup ;
	setprop("yak-40/AChS/flighttime", int(fl_time));
});

# Wind-up/freeze mechanism; "running" 0 means not winded up, "serviceable" 0 clock frozen (not heated, not implemented yet)
var wtimer = maketimer(10, func(){
	var speedup = getprop("/sim/speed-up");
	var windup = getprop("yak-40/AChS/wind_up");
	if ( getprop("yak-40/AChS/wind_up") > 0 and getprop("/instrumentation/clock/serviceable") == 1 ) {
	var windup = windup - speedup ;
	setprop("yak-40/AChS/wind_up", int(windup));
	setprop("yak-40/AChS/running", 1 );
	}
	else {
	setprop("yak-40/AChS/running", 0 );
	wtimer.stop();
	stopwatch.stop();
	flitetimer.stop();
	}
});
wtimer.start();
