
$modelname "es13/weapons/v_deagle_l.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_deagle-FLIPPED"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/deagle"

$sequence "idle" {
	"anims_l\idle"
	fps 16
	loop
}
$sequence "empty_idle" {
	"anims_l\empty_idle"
	fps 16
	loop
}
$sequence "shoot" {
	"anims_l\shoot"
	fps 40
	snap
}
$sequence "empty_shoot" {
	"anims_l\empty_shoot"
	fps 40
	snap
}
$sequence "reload" {
	"anims_l\reload"
	fps 30
}
$sequence "empty_reload" {
	"anims_l\empty_reload"
	fps 30
}
$sequence "draw" {
	"anims_l\draw"
	fps 30
}
