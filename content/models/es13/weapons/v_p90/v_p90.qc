
$modelname "es13/weapons/v_p90.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_p90-PV.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/p90"

$sequence "idle" {
	"anims\idle.smd"
	fps 30
}
$sequence "reload" {
	"anims\reload.smd"
	fps 40
}
$sequence "draw" {
	"anims\draw.smd"
	fps 30
}
$sequence "shoot1" {
	"anims\shoot1.smd"
	fps 30
	snap
}
$sequence "shoot2" {
	"anims\shoot2.smd"
	fps 30
	snap
}
$sequence "shoot3" {
	"anims\shoot3.smd"
	fps 30
	snap
}
