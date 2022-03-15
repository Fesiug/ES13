
$modelname "es13/weapons/v_radio_l.mdl"
$scale 1.0

$bodygroup "studio"
{
	studio "v_radio-FLIPPED.smd"
}

$cdmaterials "es13/weapons/hands"
$cdmaterials "es13/weapons/radio"

$sequence "idle" {
	"anims_l\idle.smd"
	fps 15
}
$sequence "draw" {
	"anims_l\draw.smd"
	fps 30
}
$sequence "holster" {
	"anims_l\holster.smd"
	fps 30
}
$sequence "use" {
	"anims_l\use.smd"
	fps 45
}
