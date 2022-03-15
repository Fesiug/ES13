// Created by Crowbar 0.71

$modelname "es13/weapons/v_usp_r.mdl"
$cdmaterials "es13/weapons/usp_r"
$scale 1.0

$bodygroup "reference"
{
	studio "reference.smd"
}

$attachment 0 "slide" 0 0 0
$attachment 1 "slide" -3.7 -0.2 0

$sequence "idle" {
	"anims\idle.smd"
	fps 16
}
$sequence "shoot1" {
	"anims\shoot1.smd"
	fps 36
	snap
}
$sequence "shoot2" {
	"anims\shoot2.smd"
	fps 36
	snap
}
$sequence "shoot_empty" {
	"anims\shoot_empty.smd"
	fps 36
	snap
}
$sequence "reload" {
	"anims\reload.smd"
	fps 30
}
$sequence "draw" {
	"anims\draw.smd"
	fps 30
}