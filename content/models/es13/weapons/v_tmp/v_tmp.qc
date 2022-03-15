
$modelname "es13/weapons/v_tmp.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "ref.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/tmp"

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

$sequence "empty_idle" {
	"anims\empty_idle.smd"
	fps 30
}
$sequence "empty_reload" {
	"anims\empty_reload.smd"
	fps 30
}
$sequence "empty_draw" {
	"anims\empty_draw.smd"
	fps 20
}
$sequence "empty_shoot" {
	"anims\empty_shoot.smd"
	fps 30
	snap
}
