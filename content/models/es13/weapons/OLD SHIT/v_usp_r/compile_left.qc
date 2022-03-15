// Created by Crowbar 0.71

$modelname "es13/weapons/v_usp_l.mdl"
$cdmaterials "es13/weapons/usp_r"
$scale 1.0

$bodygroup "reference"
{
	studio "reference_left.smd"
}

$attachment 0 "slide" 0 0 0
$attachment 1 "slide" -3.7 -0.2 0

$sequence "idle" {
	"anims_left\idle.smd"
	fps 16
}
$sequence "shoot1" {
	"anims_left\shoot1.smd"
	fps 36
	snap
}
$sequence "shoot2" {
	"anims_left\shoot2.smd"
	fps 36
	snap
}
$sequence "shoot_empty" {
	"anims_left\shoot_empty.smd"
	fps 36
	snap
}
$sequence "reload" {
	"anims_left\reload.smd"
	fps 30
}
$sequence "draw" {
	"anims_left\draw.smd"
	fps 30
}