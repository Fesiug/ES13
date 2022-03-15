
$modelname "es13/weapons/v_usp_l.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_usp-FLIPPED.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/usp"

$sequence "idle" {
	"anims_l\idle.smd"
	fps 16
	loop
}
$sequence "shoot" {
	"anims_l\shoot.smd"
	fps 30
	snap
}
$sequence "empty_shoot" {
	"anims_l\empty_shoot.smd"
	fps 32
	snap
}
$sequence "reload" {
	"anims_l\reload.smd"
	fps 37
}
$sequence "empty_reload" {
	"anims_l\empty_reload.smd"
	fps 37
}
$sequence "draw" {
	"anims_l\draw.smd"
	fps 48
}