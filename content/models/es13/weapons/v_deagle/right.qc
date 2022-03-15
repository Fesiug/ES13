
$modelname "es13/weapons/v_deagle_r.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_deagle-PV"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/deagle"

$sequence "idle" {
	"anims_r\idle"
	fps 16
	loop
}
$sequence "empty_idle" {
	"anims_r\empty_idle"
	fps 16
	loop
}
$sequence "shoot" {
	"anims_r\shoot"
	fps 40
	snap
}
$sequence "empty_shoot" {
	"anims_r\empty_shoot"
	fps 40
	snap
}
$sequence "reload" {
	"anims_r\reload"
	fps 30
}
$sequence "empty_reload" {
	"anims_r\empty_reload"
	fps 30
}
$sequence "draw" {
	"anims_r\draw"
	fps 30
}
