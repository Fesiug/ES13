
$modelname "es13/weapons/v_usp_r.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_usp-PV.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/usp"

$sequence "idle" {
	"anims_r\idle.smd"
	fps 16
	loop
}
$sequence "shoot" {
	"anims_r\shoot.smd"
	fps 30
	snap
}
$sequence "empty_shoot" {
	"anims_r\empty_shoot.smd"
	fps 32
	snap
}
$sequence "reload" {
	"anims_r\reload.smd"
	fps 37
}
$sequence "empty_reload" {
	"anims_r\empty_reload.smd"
	fps 37
}
$sequence "draw" {
	"anims_r\draw.smd"
	fps 48
}