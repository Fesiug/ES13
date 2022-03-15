
$modelname "es13/weapons/v_usp.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_usp-PV.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/usp"

$sequence "idle" {
	"anims\idle.smd"
	fps 16
	loop
}
$sequence "shoot" {
	"anims\shoot.smd"
	fps 30
	snap
}
$sequence "empty_shoot" {
	"anims\empty_shoot.smd"
	fps 32
	snap
}
$sequence "reload" {
	"anims\reload.smd"
	fps 37
}
$sequence "empty_reload" {
	"anims\empty_reload.smd"
	fps 37
}
$sequence "draw" {
	"anims\draw.smd"
	fps 48
}