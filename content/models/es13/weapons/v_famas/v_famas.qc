
$modelname "es13/weapons/v_famas.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "ref.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/famas"

$sequence "idle" {
	"anims\idle.smd"
	fps 30
}
$sequence "reload" {
	"anims\reload.smd"
	fps 30
}
$sequence "draw" {
	"anims\draw.smd"
	fps 20
}
$sequence "shoot" {
	"anims\shoot.smd"
	fps 30
	snap
}

$sequence "empty_reload" {
	"anims\empty_reload.smd"
	fps 30
}