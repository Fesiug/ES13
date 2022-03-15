
$modelname "es13/weapons/v_radio_r.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_radio-PV.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/radio"

$sequence "idle" {
	"anims\idle.smd"
	fps 15
}
$sequence "draw" {
	"anims\draw.smd"
	fps 30
}
$sequence "holster" {
	"anims\holster.smd"
	fps 30
}
$sequence "use" {
	"anims\use.smd"
	fps 45
}
