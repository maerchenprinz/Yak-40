# Some functions from:
# NASAL instruments for TU-154B
# Yurik V. Nikiforoff, yurik@megasignal.com
# Novosibirsk, Russia
# jun 2007
# Some rebuild for yak-40 by Mikhail Zuev april 2010
print("Initializing instruments system");

#########################################
## FUEL
#########################################
var PumpModes = func() {
	var LevelStatus = getprop("yak-40/FuelSystem/level-switch");
	if( LevelStatus == 2.0 ) {
	setprop("yak-40/FuelSystem/Pump463L_mode-test", 0.25 );
	}
	else {
	setprop("instrumentation/adf[0]/serviceable", "false" );
	}
}
# setlistener("yak-40/FuelSystem/level-switch", PumpModes, 0, 0);

var SelPumpModes = func() {
	var AutoFuel = getprop("yak-40/FuelSystem/sw_auto-fuel-centering");
	var ManualWeakened = getprop("yak-40/FuelSystem/sw_weakened-mode");
	var LevelStatus = getprop("yak-40/FuelSystem/level-switch");
	var Pump463L_mode = getprop("yak-40/FuelSystem/Pump463L_mode");
	if ( (LevelStatus == 2.0 or ManualWeakened == 1.0) ) {
		Pump463L_mode = 0.25 ;
		}
	else if 
}
# setlistener("yak-40/FuelSystem/level-switch", SelPumpModes, 0, 0);

#########################################
## ARK-9
#########################################
var ARK9power1 = func() {
	if( getprop("yak-40/AZS/l0201" ) == 1.0 and getprop("yak-40/ARK-9/kn_mode-1" ) > 0 ) {
	setprop("instrumentation/adf[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/adf[0]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/l0201", ARK9power1, 0, 0);
 setlistener("yak-40/ARK-9/kn_mode-1", ARK9power1, 0, 0);

var ARK9power2 = func() {
	if( getprop("yak-40/AZS/r0201" ) == 1.0 and getprop("yak-40/ARK-9/kn_mode-2" ) > 0 ) {
	setprop("instrumentation/adf[1]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/adf[1]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/r0201", ARK9power2, 0, 0);
 setlistener("yak-40/ARK-9/kn_mode-2", ARK9power2, 0, 0);

# VOLUME
var ARK9volume1 = func() {
	if( getprop("instrumentation/adf[0]/serviceable" ) == 1 ) {
	setprop("instrumentation/adf[0]/volume-norm", getprop("yak-40/ARK-9/kn_volume-1" ) );
	}
	else {
	interpolate("instrumentation/adf[0]/volume-norm", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/adf[0]/serviceable", ARK9volume1, 0, 0);
 setlistener("yak-40/ARK-9/kn_volume-1", ARK9volume1, 0, 0);

# FREQUENCIES
var ARK9freq1 = func() {
	var main1orrsrv1freq = getprop("yak-40/ARK-9/sw_freq_main1-rsrv1");
	if ( main1orrsrv1freq == 1.0 ) {
		var ark1freq100 = getprop("yak-40/ARK-9/main1Freq_100");
		var ark1freq10 = getprop("yak-40/ARK-9/main1Freq_10");
		var ark1freq1 = getprop("yak-40/ARK-9/main1Freq_1");
	}
	else {
		var ark1freq100 = getprop("yak-40/ARK-9/rsrv1Freq_100");
		var ark1freq10 = getprop("yak-40/ARK-9/rsrv1Freq_10");
		var ark1freq1 = getprop("yak-40/ARK-9/rsrv1Freq_1");
	}
	var ark1freqout = ark1freq100 + ark1freq10 + ark1freq1 ;

	setprop("instrumentation/adf[0]/frequencies/selected-khz", ark1freqout);
}

 setlistener("/sim/signals/fdm-initialized", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/sw_freq_main1-rsrv1", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/main1Freq_100", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/main1Freq_10", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/main1Freq_1", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/rsrv1Freq_100", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/rsrv1Freq_10", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/rsrv1Freq_1", ARK9freq1, 0, 0);


var ARK9freq2 = func() {
	var main2orrsrv2freq = getprop("yak-40/ARK-9/sw_freq_main2-rsrv2");
	if ( main2orrsrv2freq == 1.0 ) {
		var ark2freq100 = getprop("yak-40/ARK-9/main2Freq_100");
		var ark2freq10 = getprop("yak-40/ARK-9/main2Freq_10");
		var ark2freq1 = getprop("yak-40/ARK-9/main2Freq_1");
	}
	else {
		var ark2freq100 = getprop("yak-40/ARK-9/rsrv2Freq_100");
		var ark2freq10 = getprop("yak-40/ARK-9/rsrv2Freq_10");
		var ark2freq1 = getprop("yak-40/ARK-9/rsrv2Freq_1");
	}
	var ark2freqout = ark2freq100 + ark2freq10 + ark2freq1 ;

	setprop("instrumentation/adf[1]/frequencies/selected-khz", ark2freqout);
}

 setlistener("/sim/signals/fdm-initialized", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/sw_freq_main2-rsrv2", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/main2Freq_100", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/main2Freq_10", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/main2Freq_1", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/rsrv2Freq_100", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/rsrv2Freq_10", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/rsrv2Freq_1", ARK9freq2, 0, 0);

init_instruments = func {	
  setprop("/instrumentation/airspeed-indicator/serviceable", 1);
	setprop("/instrumentation/altimeter/serviceable", 1);
	setprop("/instrumentation/inst-vertical-speed-indicator/serviceable", 1);
	setprop("/instrumentation/vertical-speed-indicator/serviceable", 1);
	setprop("yak-40/instrumentation/vph/serviceable", 1);
	setprop("yak-40/instrumentation/msrp/serviceable", 1);
	setprop("/instrumentation/ite2t_1/fail",0);
	setprop("/instrumentation/ite2t_2/fail",0);
	setprop("/instrumentation/ite2t_3/fail",0);
	setprop("yak-40/instrumentation/npp/left/zpu", 0.0);
	setprop("yak-40/instrumentation/npp/left/mode", 1);
	setprop("yak-40/instrumentation/altimeter[1]/powered", 1);
	}

setlistener("sim/signals/fdm-initialized", init_instruments);

############################################################################
# IKU support
############################################################################
iku_handler = func {
settimer( iku_handler, 0.1 );

#Captain panel
# yellow needle1
var sel_yellow = getprop("yak-40/instrumentation/iku/l-mode");
if( sel_yellow == nil ) sel_yellow = 0.0;
var param_yellow = getprop("instrumentation/nav[0]/radials/reciprocal-radial-deg");
if( param_yellow == nil ) param_yellow = 0.0;
var compass = getprop("/orientation/heading-magnetic-deg");
if( compass == nil ) compass = 0.0;
if( sel_yellow == 0.0 ) # ADF
	param_yellow = getprop("instrumentation/adf[0]/indicated-bearing-deg");
else param_yellow -= compass;
if( param_yellow == nil ) param_yellow = 0.0;
setprop("yak-40/instrumentation/iku/indicated-heading-l", param_yellow );
# White needle
var sel_white = getprop("yak-40/instrumentation/iku/r-mode");
if( sel_white == nil ) sel_white = 0.0;
var param_white = getprop("instrumentation/nav[1]/radials/reciprocal-radial-deg");
if( param_white == nil ) param_white = 0.0;
if( sel_white == 0.0 ) # ADF
	param_white = getprop("instrumentation/adf[1]/indicated-bearing-deg");
else param_white -= compass;
if( param_white == nil ) param_white = 0.0;
setprop("yak-40/instrumentation/iku/indicated-heading-r", param_white );
}
 iku_handler();

# Heading (yellow index, left handle)
compass_adjust_hdg = func {
var prop = "yak-40/instrumentation/iku/heading-deg";
if( arg[0] == 1 ) prop = "yak-40/instrumentation/iku/heading-deg";

var delta = arg[1];
var heading = getprop( prop );
if( heading == nil ) return;

heading = heading + delta;
if( heading >= 360.0 ) heading = heading - 360.0;
if( 0 > heading ) heading = heading + 360.0; 
setprop( prop, heading );
# proceed delayed property for smooth digit wheel animation
prop = sprintf("%s-delayed", prop);
interpolate( prop, heading, 0.2 );
}

# "Plane" (white needle2, right handle with plane symbol)
compass_adjust_plane = func {
var prop = "yak-40/instrumentation/iku/plane-deg";
if( arg[0] == 1 ) prop = "yak-40/instrumentation/iku/plane-deg";

var delta = arg[1];
# proceed delayed property for smooth digit wheel animation
var delayed_prop = sprintf("%s-delayed", prop);
var local_prop = sprintf("%s-local", prop);

var heading = getprop( local_prop );
if( heading == nil ) return;
heading = heading + delta;
if( heading >= 360.0 ) heading = heading - 360.0;
if( 0 > heading ) heading = heading + 360.0; 

setprop( local_prop, heading );
interpolate( delayed_prop, heading, 0.2 );
# proceed white needle

  setprop( "yak-40/instrumentation/iku/plane-deg", heading );
  setprop( "yak-40/instrumentation/iku/plane-deg", heading );
}

#########################################
## GMK-1
#########################################
# GA-6:Creating random magnetic heading indications on start-up;
var GA6_1_init = func {
	var gyro1_init_heading = geo.normdeg(360*rand());
#	var ID3_heading = getprop("orientation/heading-magnetic-deg");
	setprop("yak-40/GMK-1/GA-6-1_heading", gyro1_init_heading);
#	setprop("yak-40/GMK-1/GA-6-1_delta-heading", gyro1_init_heading-);
}
GA6_1_init();
# setlistener("sim/signals/fdm-initialized", GA6_1_init );
# setprop("yak-40/GMK-1/GA-6-1_heading", 0.0 );

var GA6_2_init = func {
	var gyro2_init_heading = geo.normdeg180(360*rand());
#	var ID3_heading = getprop("orientation/heading-magnetic-deg");
	setprop("yak-40/GMK-1/GA-6-2_heading", gyro2_init_heading);

#	setprop("yak-40/GMK-1/GA-6-1_delta-heading", gyro1_init_heading - ;
}
GA6_2_init();
# setlistener("sim/signals/fdm-initialized", GA6_1_init );
# setprop("yak-40/GMK-1/GA-6-2_delta-heading", 0.0 );

# Set latitude on PU-27 to current latitude
props.globals.initNode("yak-40/GMK-1/PU-27_kn_latitude", int(getprop("position/latitude-deg")));
var PU27_lat_init = func {
	var pu27_lat_set = int(getprop("position/latitude-deg"));
	props.globals.initNode("yak-40/GMK-1/PU-27_kn_latitude", int(getprop("position/latitude-deg")));
	if ( pu27_lat_set <= 0 ) {
	props.globals.initNode("yak-40/GMK-1/PU-27_sw_hemisphere", -1.0 );
	}
	else {
	props.globals.initNode("yak-40/GMK-1/PU-27_sw_hemisphere", 1.0 );
	}
}
PU27_lat_init();

# after system has power, it  autom. aligns GA-6s to ID-3 for 1 min
settimer(func { setprop("yak-40/GMK-1/GMK_first-init", 0) }, 60);
var GMK_mode = func {
	if ( getprop("yak-40/GMK-1/PU-27_sw_gmk_mode") != 0.0 or getprop("yak-40/GMK-1/GMK_first-init") == 1 ) {
	setprop("yak-40/GMK-1/mode_MK", 1 );
	setprop("yak-40/GMK-1/mode_GPK", 0 );
	}
	else {
	setprop("yak-40/GMK-1/mode_MK", 0 );
	setprop("yak-40/GMK-1/mode_GPK", 1 );
	}
}
 setlistener("yak-40/GMK-1/PU-27_sw_gmk_mode", GMK_mode, 1, 0);
 setlistener("yak-40/GMK-1/GMK_first-init", GMK_mode, 1, 0);

#########################################
## Kurs MP-70
#########################################
var kurs_mp1power = func() {
	if( getprop("yak-40/AZS/l0101" ) == 1.0 ) {
	setprop("instrumentation/nav[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/nav[0]/serviceable", "false" );
	}
}
# setlistener("yak-40/AZS/l0101", kurs_mp1power, 0, 0);

# FREQUENCIES
var kurs_mp1freq = func() {
	var kurs_mp1freq1 = getprop("yak-40/Kurs-MP-70/kn_pu1-freq1");
	var kurs_mp1freq2 = getprop("yak-40/Kurs-MP-70/kn_pu1-freq2");
	var kurs_mp1freqout = kurs_mp1freq1 + kurs_mp1freq2 ;
	setprop("instrumentation/nav[0]/frequencies/selected-mhz", kurs_mp1freqout);
}
 setlistener("sim/signals/fdm-initialized", kurs_mp1freq, 0, 0);
 setlistener("yak-40/Kurs-MP-70/kn_pu1-freq1", kurs_mp1freq, 0, 0);
 setlistener("yak-40/Kurs-MP-70/kn_pu1-freq2", kurs_mp1freq, 0, 0);

# VOLUME
var kurs_mp1vol = func() {
#	if( getprop("instrumentation/comm[0]/serviceable" ) == 1 ) {
	setprop("instrumentation/nav[0]/volume-norm", getprop("yak-40/Landysh/kn_volume-1" ) );
#	}
#	else {
#	interpolate("instrumentation/comm[0]/volume-norm", 0.0, 0.5 );
#	}
}
# setlistener("instrumentation/nav[0]/serviceable", kurs_mp1vol, 0, 0);
 setlistener("yak-40/Landysh/kn_volume-1", kurs_mp1vol, 0, 0);

#########################################
## Landysh
#########################################
var landysh1power = func() {
	if( getprop("yak-40/AZS/l0101" ) == 1.0 ) {
	setprop("instrumentation/comm[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/comm[0]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/l0101", landysh1power, 0, 0);

var landysh2power = func() {
	if( getprop("yak-40/AZS/r0101" ) == 1.0 ) {
	setprop("instrumentation/comm[1]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/comm[1]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/r0101", landysh2power, 0, 0);

# FREQUENCIES
var landysh1freq = func() {
	var landysh1freq1 = getprop("yak-40/Landysh/freq1-1");
	var landysh1freq2 = getprop("yak-40/Landysh/freq2-1");
	var landysh1freqout = landysh1freq1 + landysh1freq2 ;
	setprop("instrumentation/comm[0]/frequencies/selected-mhz", landysh1freqout);
}
 setlistener("sim/signals/fdm-initialized", landysh1freq, 0, 0);
 setlistener("yak-40/Landysh/freq1-1", landysh1freq, 0, 0);
 setlistener("yak-40/Landysh/freq2-1", landysh1freq, 0, 0);

var landysh2freq = func() {
	var landysh2freq1 = getprop("yak-40/Landysh/freq1-2");
	var landysh2freq2 = getprop("yak-40/Landysh/freq2-2");
	var landysh2freqout = landysh2freq1 + landysh2freq2 ;

	setprop("instrumentation/comm[1]/frequencies/selected-mhz", landysh2freqout);
}
 setlistener("sim/signals/fdm-initialized", landysh2freq, 0, 0);
 setlistener("yak-40/Landysh/freq1-2", landysh2freq, 0, 0);
 setlistener("yak-40/Landysh/freq2-2", landysh2freq, 0, 0);

# VOLUME
var landysh1vol = func() {
	if( getprop("instrumentation/comm[0]/serviceable" ) == 1 ) {
	interpolate("instrumentation/comm[0]/volume", getprop("yak-40/Landysh/kn_volume-1" ), 0.5 );
	}
	else {
	interpolate("instrumentation/comm[0]/volume", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/comm[0]/serviceable", landysh1vol, 0, 0);
 setlistener("yak-40/Landysh/kn_volume-1", landysh1vol, 0, 0);

var landysh2vol = func() {
	if( getprop("instrumentation/comm[1]/serviceable" ) == 1 ) {
	interpolate("instrumentation/comm[1]/volume", getprop("yak-40/Landysh/kn_volume-2" ), 0.5 );
	}
	else {
	interpolate("instrumentation/comm[1]/volume", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/comm[1]/serviceable", landysh2vol, 0, 0);
 setlistener("yak-40/Landysh/kn_volume-2", landysh2vol, 0, 0);

#########################################
## SD-75
#########################################
var sd75power = func() {
	if( getprop("yak-40/SD-75/kn_sd-vol" ) > 0.0 ) {
	setprop("instrumentation/dme[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/dme[0]/serviceable", "false" );
	}
}
 setlistener("yak-40/SD-75/kn_sd-vol", sd75power, 0, 0);

# VOLUME
var sd75vol = func() {
	if( getprop("instrumentation/dme[0]/serviceable" ) == 1 ) {
	interpolate("instrumentation/dme[0]/volume", getprop("yak-40/SD-75/kn_sd-vol" ), 0.1 );
	}
	else {
	interpolate("instrumentation/dme[0]/volume", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/dme[0]/serviceable", sd75vol, 0, 0);
 setlistener("yak-40/SD-75/kn_sd-vol", sd75vol, 0, 0);

#########################################
## SPU-like thingy
#########################################
var spu_to_headset = func {
	var viewnr = getprop("sim/current-view/view-number-raw");
	var source = getprop("yak-40/Landysh/source_viewnr" ~ viewnr ~ "");
# Landysh No.1 "UKV-1"
	if ( source == 0 ) {
	interpolate("instrumentation/comm[0]/volume", getprop("yak-40/Landysh/kn_volume-1"), 0.2 );
#	setprop("controls/radios/comm-radio-selected", 1 );
	}
	else {
	interpolate("instrumentation/comm[0]/volume", 0.0, 0.2 );
	}
# Landysh No.2 "UKV-2"
	if ( source == 1 ) {
	interpolate("instrumentation/comm[1]/volume", getprop("yak-40/Landysh/kn_volume-2"), 0.2 );
#	setprop("controls/radios/comm-radio-selected", 2 );
	}
	else {
	interpolate("instrumentation/comm[1]/volume", 0.0, 0.2 );
	}
# ARK-9 No.1 "RK-1"
	if ( source == 3 ) {
	interpolate("instrumentation/adf[0]/volume-norm", getprop("yak-40/ARK-9/kn_volume-1"), 0.2 );
#	setprop("controls/radios/comm-radio-selected", 2 );
	}
	else {
	interpolate("instrumentation/adf[0]/volume-norm", 0.0, 0.2 );
	}
# ARK-9 No.2 "RK-2"
	if ( source == 3 ) {
	interpolate("instrumentation/adf[1]/volume-norm", getprop("yak-40/ARK-9/kn_volume-2"), 0.2 );
#	setprop("controls/radios/comm-radio-selected", 2 );
	}
	else {
	interpolate("instrumentation/adf[1]/volume-norm", 0.0, 0.2 );
	}
}
 setlistener("sim/current-view/view-number-raw", spu_to_headset, 0, 0 );
 setlistener("yak-40/Landysh/source_viewnr0", spu_to_headset, 0, 0 );
 setlistener("yak-40/Landysh/source_viewnr101", spu_to_headset, 0, 0 );
# Landysh
 setlistener("yak-40/Landysh/kn_volume-1", spu_to_headset, 0, 0 );
 setlistener("yak-40/Landysh/kn_volume-2", spu_to_headset, 0, 0 );
# ARK-9 /Kurs-MP
 setlistener("yak-40/ARK-9/kn_volume-1", spu_to_headset, 0, 0 );
 setlistener("yak-40/ARK-9/kn_volume-2", spu_to_headset, 0, 0 );

