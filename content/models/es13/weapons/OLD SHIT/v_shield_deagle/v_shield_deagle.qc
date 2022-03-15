// Created by Crowbar 0.71

$modelname "es13/weapons/v_deagle.mdl"
$cdmaterials "es13/weapons/deagle"
$scale 1.0

$bodygroup "hands"
{
	studio "shield_ref_rhand.smd"
}
$bodygroup "weapon"
{
	studio "shield_ref_de.smd"
}

$attachment 0 "slide" 0 0 0
$attachment 1 "slide" -4.7 0 0

$sequence "idle1" {
	"v_shield_deagle_anims\idle1.smd"
	fps 16
}
$sequence "shoot1" {
	"v_shield_deagle_anims\shoot1.smd"
	fps 36
}
$sequence "shoot2" {
	"v_shield_deagle_anims\shoot2.smd"
	fps 36
}
$sequence "shoot_empty" {
	"v_shield_deagle_anims\shoot_empty.smd"
	fps 36
}
$sequence "reload" {
	"v_shield_deagle_anims\reload.smd"
	fps 30
}
$sequence "draw" {
	"v_shield_deagle_anims\draw.smd"
	fps 30
}