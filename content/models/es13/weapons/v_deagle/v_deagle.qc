
$modelname "es13/weapons/v_deagle.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_deagle-PV"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/deagle"

$sequence "idle" {
	"anims\idle"
	fps 16
	loop
}
$sequence "empty_idle" {
	"anims\empty_idle"
	fps 16
	loop
}
$sequence "shoot" {
	"anims\shoot"
	fps 40
	snap
}
$sequence "empty_shoot" {
	"anims\empty_shoot"
	fps 40
	snap
}
$sequence "reload" {
	"anims\reload"
	fps 30
}
$sequence "empty_reload" {
	"anims\empty_reload"
	fps 30
}
$sequence "draw" {
	"anims\draw"
	fps 30
}
