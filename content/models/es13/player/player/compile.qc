
$modelname "es13/player/player.mdl"
$scale 0.4

$bodygroup "reference"
{
	studio "reference.smd"
}

$attachment "eyes" "head" 0.00 0.00 15.00 rotate -90 -90 0

$cdmaterials "es13/models/player"

$poseparameter pp_es13_wield			0 2

$poseparameter pp_es13_look_pitch		-1 1
$poseparameter pp_es13_look_yaw		-1 1

$poseparameter pp_es13_lookch_pitch	-1 1
$poseparameter pp_es13_lookch_yaw		-1 1

$sequence "rest" {
	"anims/rest.smd"
	fadein	0.2
	fadeout	0.2
	fps		30
	loop
}

$sequence "idle" {
	"anims/idle.smd"
	fadein	0.2
	fadeout	0.2
	fps		30
	loop
}

$sequence "walk" {
	"anims/walk.smd"
	fadein	0.2
	fadeout	0.2
	fps		15		// Halve these
	loop
}

$sequence "run" {
	"anims/run.smd"
	fadein	0.2
	fadeout	0.2
	fps		20		// Halve these
	loop
}


$animation "h_rest" "anims/rest.smd" {
	fps 30
}

$animation	"o_hn"		"anims/idle.smd"			{ frames 0 0 subtract "h_rest" 0 }
$animation	"o_hr"		"anims/holding_r.smd"		{ subtract "h_rest" 0 }
$animation	"o_hl"		"anims/holding_l.smd"		{ subtract "h_rest" 0 }
$animation	"o_hb"		"anims/holding_b.smd"		{ subtract "h_rest" 0 }
$sequence "es13_holding" {
	"o_hn"
	"o_hr"
	//"o_hl"
	"o_hb"

	blend pp_es13_wield 0 2

	autoplay
	delta
	fps		30
	hidden
}

$animation	"o_hp1"		"anims/ro_headpitch.smd"		{ frames 0 0 subtract "h_rest" 0 }
$animation	"o_hp2"		"anims/ro_headpitch.smd"		{ frames 1 1 subtract "h_rest" 0 }
$animation	"o_hp3"		"anims/ro_headpitch.smd"		{ frames 2 2 subtract "h_rest" 0 }
$sequence "es13_headpitch" {
	"o_hp1"
	"o_hp2"
	"o_hp3"

	blend pp_es13_look_pitch -1 1

	autoplay
	delta
	fps		30
	hidden
}

$animation	"o_hy1"		"anims/ro_headyaw.smd"			{ frames 0 0 subtract "h_rest" 0 }
$animation	"o_hy2"		"anims/ro_headyaw.smd"			{ frames 1 1 subtract "h_rest" 0 }
$animation	"o_hy3"		"anims/ro_headyaw.smd"			{ frames 2 2 subtract "h_rest" 0 }
$sequence "es13_headyaw" {
	"o_hy1"
	"o_hy2"
	"o_hy3"

	blend pp_es13_look_yaw -1 1

	autoplay
	delta
	fps		30
	hidden
}