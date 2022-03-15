
dark = false
s_light = [[
<style>
/*****************************************
*
* GLOBAL STYLES
*
******************************************/
html, body {
	padding: 0;
	margin: 0;
	height: 100%;
	color: #000000;
}
body {
	background: #fff;
    font-family: Verdana, "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 9pt;
    line-height: 1.2;
	overflow-x: hidden;
	overflow-y: scroll;
	word-wrap: break-word;
}
h1, h2, h3, h4, h5, h6 {color: #00f; font-family: Georgia, Verdana, sans-serif;}
img {
	margin: 0;
	padding: 0;
	line-height: 1;
}
img.icon {
	width: 16px;
	height: 16px;
}
a {color: #0000ff;}
a:visited {color: #ff00ff;}
a.popt {text-decoration: none;}

/*****************************************
*
* CUSTOM FONTS
*
******************************************/
@font-face { font-family: PxPlus IBM MDA; src: url('PxPlus_IBM_MDA.ttf'); }

/*****************************************
*
* OUTPUT NOT RELATED TO ACTUAL MESSAGES
*
******************************************/
#loading {
	position: fixed;
	width: 300px;
	height: 150px;
	text-align: center;
	left: 50%;
	top: 50%;
	margin: -75px 0 0 -150px;
}
#loading i {display: block; padding-bottom: 3px;}

#messages {
	font-size: 14px;
	padding: 3px;
	margin: 0;
	word-wrap: break-word;
}
#newMessages {
	position: fixed;
	display: block;
	bottom: 0;
	right: 0;
	padding: 8px;
	background: #ddd;
	text-decoration: none;
    font-variant: small-caps;
    font-size: 1.1em;
    font-weight: bold;
	color: #333;
}
#newMessages:hover {background: #ccc;}
#newMessages i {vertical-align: middle; padding-left: 3px;}
#ping {
	position: fixed;
	top: 0;
	right: 40px;
	width: 45px;
	background: #ddd;
	height: 30px;
	padding: 8px 0 2px 0;
}
#ping i {display: block; text-align: center;}
#ping .ms {
	display: block;
	text-align: center;
	font-size: 8pt;
	padding-top: 2px;
}
#options {
	position: fixed;
	top: 0;
	right: 0;
}
#options a {
	background: #ddd;
    height: 30px;
	padding: 5px 0;
	display: block;
	color: #333;
	text-decoration: none;
    line-height: 28px;
    border-top: 1px solid #b4b4b4;
}
#options a:hover {background: #ccc;}
#options .toggle {
	width: 40px;
    background: #ccc;
    border-top: 0;
    float: right;
    text-align: center;
}
#options .sub {clear: both; display: none; width: 160px;}
#options .sub.scroll {overflow-y: scroll;}
#options .sub a {padding: 5px 0 5px 8px; line-height: 30px; font-size: 0.9em; clear: both;}
#options .sub span {
	display: block;
	line-height: 30px;
	float: left;
}
#options .sub i {
	display: block;
	padding: 0 5px;
	font-size: 1.1em;
	width: 22px;
	text-align: center;
	line-height: 30px;
	float: right;
}
#options .decreaseFont {border-top: 0;}

/* POPUPS */
.popup {
	position: fixed;
	top: 50%;
	left: 50%;
	background: #ddd;
}
.popup .close {
	position: absolute;
	background: #aaa;
	top: 0;
	right: 0;
	color: #333;
	text-decoration: none;
	z-index: 2;
	padding: 0 10px;
	height: 30px;
	line-height: 30px;
}
.popup .close:hover {background: #999;}
.popup .head {
	background: #999;
	color: #ddd;
	padding: 0 10px;
	height: 30px;
	line-height: 30px;
	text-transform: uppercase;
	font-size: 0.9em;
	font-weight: bold;
	border-bottom: 2px solid green;
}
.popup input {border: 1px solid #999; background: #fff; margin: 0; padding: 5px; outline: none; color: #333;}
.popup input[type=text]:hover, .popup input[type=text]:active, .popup input[type=text]:focus {border-color: green;}
.popup input[type=submit] {padding: 5px 10px; background: #999; color: #ddd; text-transform: uppercase; font-size: 0.9em; font-weight: bold;}
.popup input[type=submit]:hover, .popup input[type=submit]:focus, .popup input[type=submit]:active {background: #aaa; cursor: pointer;}

.changeFont {padding: 10px;}
.changeFont a {display: block; text-decoration: none; padding: 3px; color: #333;}
.changeFont a:hover {background: #ccc;}

.highlightPopup {padding: 10px; text-align: center;}
.highlightPopup input[type=text] {display: block; width: 215px; text-align: left; margin-top: 5px;}
.highlightPopup input.highlightColor {background-color: #FFFF00;}
.highlightPopup input.highlightTermSubmit {margin-top: 5px;}

/* ADMIN CONTEXT MENU */
.contextMenu {
	background-color: #ddd;
	position: fixed;
	margin: 2px;
	width: 150px;
}
.contextMenu a {
	display: block;
	padding: 2px 5px;
	text-decoration: none;
	color: #333;
}

.contextMenu a:hover {
	background-color: #ccc;
}

/* ADMIN FILTER MESSAGES MENU */
.filterMessages {padding: 5px;}
.filterMessages div {padding: 2px 0;}
.filterMessages input {}
.filterMessages label {}

.icon-stack {height: 1em; line-height: 1em; width: 1em; vertical-align: middle; margin-top: -2px;}


/*****************************************
*
* OUTPUT ACTUALLY RELATED TO MESSAGES
*
******************************************/

/* MOTD */
.motd {color: #638500;}
.motd h1, .motd h2, .motd h3, .motd h4, .motd h5, .motd h6 {color: #638500; text-decoration: underline;}
.motd a, .motd a:link, .motd a:visited, .motd a:active, .motd a:hover {color: #638500;}

/* ADD HERE FOR BOLD */
.bold, .name, .prefix, .ooc, .looc, .adminooc, .adminlooc, .admin, .gfartooc, .gfartlooc, .gfartadmin, .mentorooc, .mentorlooc, .medal {font-weight: bold;}

/* ADD HERE FOR ITALIC */
.italic, .ghostdronesay.broadcast {font-style: italic;}

/* BADGE */
.repeatBadge {
    display: inline-block;
    min-width: 0.5em;
    font-size: 0.7em;
    padding: 0.2em 0.3em;
    line-height: 1;
    color: white;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    background-color: crimson;
    border-radius: 10px;
}

/* OUTPUT COLORS */
.highlight {background: yellow;}
h1, h2, h3, h4, h5, h6	{color: #0000ff;font-family: Georgia, Verdana, sans-serif;}
em						{font-style: normal;	font-weight: bold;}
.motd					{color: #638500;	font-family: Verdana, sans-serif;}
.motd h1, .motd h2, .motd h3, .motd h4, .motd h5, .motd h6
						{color: #638500;	text-decoration: underline;}
.motd a, .motd a:link, .motd a:visited, .motd a:active, .motd a:hover
						{color: #638500;}
.darkmblue 				{color: #0000ff;}
.prefix					{					font-weight: bold;}
.ooc					{					font-weight: bold;}
.looc					{color: #6699CC;}
.adminobserverooc		{color: #0099cc;	font-weight: bold;}
.adminooc				{color: #b82e00;	font-weight: bold;}
.adminobserver			{color: #996600;	font-weight: bold;}
.admin					{color: #386aff;	font-weight: bold;}
.adminsay				{color: #9611D4;	font-weight: bold;}
.mentorhelp				{color: #0077bb;	font-weight: bold;}
.adminhelp				{color: #aa0000;	font-weight: bold;}
.playerreply			{color: #8800bb;	font-weight: bold;}
.pmsend					{color: #0000ff;}
.name					{					font-weight: bold;}
.say					{}
.yell					{					font-weight: bold;}
.siliconsay				{font-family: 'Courier New', Courier, monospace;}
.deadsay				{color: #5c00e6;}
.radio					{color: #408010;}
.deptradio				{color: #993399;}
.comradio				{color: #204090;}
.syndradio				{color: #6D3F40;}
.dsquadradio				{color: #686868;}
.resteamradio				{color: #18BC46;}
.airadio				{color: #FF00FF;}
.centradio				{color: #5C5C7C;}
.secradio				{color: #A30000;}
.engradio				{color: #A66300;}
.medradio				{color: #009190;}
.sciradio				{color: #993399;}
.supradio				{color: #7F6539;}
.srvradio				{color: #80A000;}
.proradio				{color: #E3027A;}
.admin_channel			{color: #9A04D1;	font-weight: bold;}
.mentor_channel			{color: #775BFF;	font-weight: bold;}
.mentor_channel_admin      {color: #A35CFF;	font-weight: bold;}
.djradio				{color: #663300;}
.binaryradio				{color: #0B0050;	font-family: 'Courier New', Courier, monospace;}
.mommiradio				{color: navy;}
.alert					{color: #ff0000;}
h1.alert, h2.alert			{color: #000000;}
.ghostalert				{color: #5c00e6;	font-style: italic; font-weight: bold;}
.emote					{					font-style: italic;}
.selecteddna				{color: #FFFFFF; 	background-color: #001B1B}

.attack					{color: #ff0000;}
.moderate				{color: #CC0000;}
.disarm					{color: #990000;}
.passive				{color: #660000;}

.warning				{color: #ff0000;	font-style: italic;}
.boldwarning				{color: #ff0000;	font-style: italic;	font-weight: bold}
.danger					{color: #ff0000;	font-weight: bold;}
.userdanger				{color: #ff0000;	font-weight: bold;	font-size: 120%;}
.biggerdanger				{color: #ff0000;	font-weight: bold; font-size: 150%;}

.info					{color: #0000CC;}
.notice					{color: #000099;}
.boldnotice				{color: #000099;	font-weight: bold;}
.suicide				{color: #ff5050;	font-style: italic;}
.green					{color: #03bb39;}
.announce 				{color: #228b22;	font-weight: bold;}
.boldannounce				{color: #ff0000;	font-weight: bold;}
.greenannounce				{color: #00ff00;	font-weight: bold;}

.alien					{color: #543354;}
.noticealien				{color: #00c000;}
.alertalien				{color: #00c000; font-weight: bold;}
.terrorspider				{color: #320E32;}


.sinister				{color: #800080;	font-weight: bold;	font-style: italic;} /* /vg/ */
.blob					{color: #006221;	font-weight: bold;	font-style: italic;}
.confirm				{color: #00af3b;}
.rose					{color: #ff5050;}
.sans					{font-family: 'Comic Sans MS', cursive, sans-serif;}
.wingdings				{font-family: Wingdings, Webdings;}
.robot					{font-family: 'PxPlus IBM MDA'; font-size: 1.15em;}
.ancient				{color: #008B8B;	font-style: italic;}
.newscaster				{color: #800000;}
.mod					{color: #735638;	font-weight: bold;}
.modooc					{color: #184880;	font-weight: bold;}
.adminmod				{color: #402A14;	font-weight: bold;}
.tajaran				{color: #803B56;}
.skrell					{color: #00CED1;}
.solcom					{color: #22228B;}
.com_srus				{color: #7c4848;}
.zombie					{color: #ff0000;}
.soghun					{color: #228B22;}
.changeling				{color: #800080;}
.vox					{color: #AA00AA;}
.diona					{color:	#804000;	font-weight: bold;}
.trinary				{color: #727272;}
.kidan					{color: #664205;}
.slime					{color: #0077AA;}
.drask					{color: #a3d4eb; font-family: "Arial Black";}
.clown					{color: #ff0000;}
.shadowling				{color: #3b2769;}
.vulpkanin				{color: #B97A57;}
.abductor				{color: #800080; font-style: italic;}
.mind_control				{color: #A00D6F; font-size: 3; font-weight: bold; font-style: italic;}
.rough					{font-family: 'Trebuchet MS', cursive, sans-serif;}
.say_quote				{font-family: Georgia, Verdana, sans-serif;}
.cult					{color: #800080; font-weight: bold; font-style: italic;}
.cultspeech				{color: #7F0000; font-style: italic;}
.cultitalic				{color: #960000; font-style: italic;}
.cultlarge				{color: #960000; font-weight: bold; font-size: 120%;}
.narsie					{color: #960000; font-weight: bold; font-size: 300%;}
.narsiesmall			{color: #960000; font-weight: bold; font-size: 200%;}
.interface				{color: #330033;}
.big					{font-size: 150%;}
.reallybig				{font-size: 175%;}
.greentext				{color: #00FF00;	font-size: 150%;}
.redtext				{color: #FF0000;	font-size: 150%;}
.bold					{font-weight: bold;}
.center					{text-align: center;}
.red					{color: #FF0000;}
.purple					{color: #5e2d79;}
.skeleton				{color: #585858; font-weight: bold; font-style: italic;}
.gutter					{color: #7092BE; font-family: "Trebuchet MS", cursive, sans-serif;}
.orange					{color: #ffa500;}
.orangei				{color: #ffa500; font-style: italic;}
.orangeb				{color: #ffa500; font-weight: bold;}
.resonate				{color: #298F85;}

.revennotice				{color: #1d2953;}
.revenboldnotice			{color: #1d2953;	font-weight: bold;}
.revenbignotice				{color: #1d2953;	font-weight: bold; font-size: 120%;}
.revenminor				{color: #823abb}
.revenwarning				{color: #760fbb;	font-style: italic;}
.revendanger				{color: #760fbb;	font-weight: bold; font-size: 120%;}

.specialnoticebold				{color: #36525e; 	font-weight: bold; font-size: 120%;}

.specialnotice				{color: #36525e;  font-size: 120%;}

/* /vg/ */
.good					{color: green;}
.average				{color: #FF8000;}
.bad					{color: #FF0000;}
/* /vg/ Saycode Rewrite */
.italics, .talkinto		{font-style:italic;}
.whisper				{font-style:italic;color:#333333;}
/* Recruiting stuff */
.recruit 				{color: #5c00e6; font-weight: bold; font-style: italic;}

.memo					{color: #638500;	text-align: center;}
.memoedit				{text-align: center;	font-size: 75%;}

.connectionClosed, .fatalError {background: red; color: white; padding: 5px;}
.connectionClosed.restored {background: green;}
.internal.boldnshit {color: blue; font-weight: bold;}

.rebooting {background: #2979AF; color: white; padding: 5px;}
.rebooting a {color: white !important; text-decoration-color: white !important;}
#reconnectTimer {font-weight: bold;}

/* HELPER CLASSES */
.text-normal {font-weight: normal; font-style: normal;}
.hidden {display: none; visibility: hidden;}

/* MEGAFAUNA */
.colossus				{color: #7F282A; font-size: 175%;}
.hierophant				{color: #660099; font-weight: bold; font-style: italic;}
.hierophant_warning		{color: #660099; font-style: italic;}

/* EMOJI STUFF */
.emoji {max-height: 16px; max-width: 16px}

/* ADMIN TICKETS */

.adminticket {color: #3e7336; font-weight: bold}

.adminticketalt {color: #014c8a; font-weight: bold}

/* Syndicate codewords */
span.body .codephrases {color: #0000FF;}
span.body .coderesponses {color: #FF0000;}
</style>
]]
s_dark = [[
<style>
/*****************************************
*
* GLOBAL STYLES
*
******************************************/
html, body {
	padding: 0;
	margin: 0;
	height: 100%;
	color: #fff;
}
body {
	background: #151515;
    font-family: Verdana, "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 9pt;
    line-height: 1.2;
	overflow-x: hidden;
	overflow-y: scroll;
	word-wrap: break-word;
}
h1, h2, h3, h4, h5, h6 {color: #06f; font-family: Georgia, Verdana, sans-serif;}

img {
	margin: 0;
	padding: 0;
	line-height: 1;
}
img.icon {
	width: 16px;
	height: 16px;
}
a {color: #06f;}
a:visited {color: #ff00ff;}
a.popt {text-decoration: none;}

/*****************************************
*
* CUSTOM FONTS
*
******************************************/
@font-face { font-family: PxPlus IBM MDA; src: url('PxPlus_IBM_MDA.ttf'); }

/*****************************************
*
* OUTPUT NOT RELATED TO ACTUAL MESSAGES
*
******************************************/
#loading {
	position: fixed;
	width: 300px;
	height: 150px;
	text-align: center;
	left: 50%;
	top: 50%;
	margin: -75px 0 0 -150px;
}
#loading i {display: block; padding-bottom: 3px;}

#messages {
	font-size: 14px;
	padding: 3px;
	margin: 0;
	word-wrap: break-word;
}
#newMessages {
	position: fixed;
	display: block;
	bottom: 0;
	right: 0;
	padding: 8px;
	background: #ddd;
	text-decoration: none;
    font-variant: small-caps;
    font-size: 1.1em;
    font-weight: bold;
	color: #333;
}
#newMessages:hover {background: #ccc;}
#newMessages i {vertical-align: middle; padding-left: 3px;}
#ping {
	position: fixed;
	top: 0;
	right: 40px;
	width: 45px;
	background: #ddd;
	color: #000;
	height: 30px;
	padding: 8px 0 2px 0;
}
#ping i {display: block; text-align: center;}
#ping .ms {
	display: block;
	text-align: center;
	font-size: 8pt;
	color: #000;
	padding-top: 2px;
}
#options {
	position: fixed;
	top: 0;
	right: 0;
}
#options a {
	background: #ddd;
    height: 30px;
	padding: 5px 0;
	display: block;
	color: #333;
	text-decoration: none;
    line-height: 28px;
    border-top: 1px solid #b4b4b4;
}
#options a:hover {background: #ccc;}
#options .toggle {
	width: 40px;
    background: #ccc;
    border-top: 0;
    float: right;
    text-align: center;
}
#options .sub {clear: both; display: none; width: 160px;}
#options .sub.scroll {overflow-y: scroll;}
#options .sub a {padding: 5px 0 5px 8px; line-height: 30px; font-size: 0.9em; clear: both;}
#options .sub span {
	display: block;
	line-height: 30px;
	float: left;
}
#options .sub i {
	display: block;
	padding: 0 5px;
	font-size: 1.1em;
	width: 22px;
	text-align: center;
	line-height: 30px;
	float: right;
}
#options .decreaseFont {border-top: 0;}

/* POPUPS */
.popup {
	position: fixed;
	top: 50%;
	left: 50%;
	background: #ddd;
}
.popup .close {
	position: absolute;
	background: #aaa;
	top: 0;
	right: 0;
	color: #333;
	text-decoration: none;
	z-index: 2;
	padding: 0 10px;
	height: 30px;
	line-height: 30px;
}
.popup .close:hover {background: #999;}
.popup .head {
	background: #999;
	color: #ddd;
	padding: 0 10px;
	height: 30px;
	line-height: 30px;
	text-transform: uppercase;
	font-size: 0.9em;
	font-weight: bold;
	border-bottom: 2px solid green;
}
.popup input {border: 1px solid #999; background: #fff; margin: 0; padding: 5px; outline: none; color: #333;}
.popup input[type=text]:hover, .popup input[type=text]:active, .popup input[type=text]:focus {border-color: green;}
.popup input[type=submit] {padding: 5px 10px; background: #999; color: #ddd; text-transform: uppercase; font-size: 0.9em; font-weight: bold;}
.popup input[type=submit]:hover, .popup input[type=submit]:focus, .popup input[type=submit]:active {background: #aaa; cursor: pointer;}

.changeFont {padding: 10px;}
.changeFont a {display: block; text-decoration: none; padding: 3px; color: #333;}
.changeFont a:hover {background: #ccc;}

.highlightPopup {padding: 10px; text-align: center;}
.highlightPopup input[type=text] {display: block; width: 215px; text-align: left; margin-top: 5px;}
.highlightPopup input.highlightColor {background-color: #FFFF00;}
.highlightPopup input.highlightTermSubmit {margin-top: 5px;}

/* ADMIN CONTEXT MENU */
.contextMenu {
	background-color: #ddd;
	position: fixed;
	margin: 2px;
	width: 150px;
}
.contextMenu a {
	display: block;
	padding: 2px 5px;
	text-decoration: none;
	color: #333;
}

.contextMenu a:hover {
	background-color: #ccc;
}

/* ADMIN FILTER MESSAGES MENU */
.filterMessages {padding: 5px;}
.filterMessages div {padding: 2px 0;}
.filterMessages input {}
.filterMessages label {}

.icon-stack {height: 1em; line-height: 1em; width: 1em; vertical-align: middle; margin-top: -2px;}


/*****************************************
*
* OUTPUT ACTUALLY RELATED TO MESSAGES
*
******************************************/

/* MOTD */
.motd {color: #638500;}
.motd h1, .motd h2, .motd h3, .motd h4, .motd h5, .motd h6 {color: #638500; text-decoration: underline;}
.motd a, .motd a:link, .motd a:visited, .motd a:active, .motd a:hover {color: #638500;}

/* ADD HERE FOR BOLD */
.bold, .name, .prefix, .ooc, .looc, .adminooc, .adminlooc, .admin, .gfartooc, .gfartlooc, .gfartadmin, .mentorooc, .mentorlooc, .medal {font-weight: bold;}

/* ADD HERE FOR ITALIC */
.italic, .ghostdronesay.broadcast {font-style: italic;}

/* BADGE */
.repeatBadge {
    display: inline-block;
    min-width: 0.5em;
    font-size: 0.7em;
    padding: 0.2em 0.3em;
    line-height: 1;
    color: white;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    background-color: crimson;
    border-radius: 10px;
}

/* OUTPUT COLORS */
.highlight {background: yellow;}
h1, h2, h3, h4, h5, h6	{color: #06f;font-family: Georgia, Verdana, sans-serif;}
em						{font-style: normal;	font-weight: bold;}
.motd					{color: #638500;	font-family: Verdana, sans-serif;}
.motd h1, .motd h2, .motd h3, .motd h4, .motd h5, .motd h6
						{color: #638500;	text-decoration: underline;}
.motd a, .motd a:link, .motd a:visited, .motd a:active, .motd a:hover
						{color: #638500;}
.darkmblue 				{color: #6685f5;}
.prefix					{					font-weight: bold;}
.ooc					{					font-weight: bold;}
.looc					{color: #6699CC;}
.adminobserverooc		{color: #0099cc;	font-weight: bold;}
.adminooc				{color: #b82e00;	font-weight: bold;}
.adminobserver			{color: #996600;	font-weight: bold;}
.admin					{color: #386aff;	font-weight: bold;}
.adminsay				{color: #9611D4;	font-weight: bold;}
.mentorhelp				{color: #0077bb;	font-weight: bold;}
.adminhelp				{color: #aa0000;	font-weight: bold;}
.playerreply			{color: #8800bb;	font-weight: bold;}
.pmsend					{color: #6685f5;}
.name					{					font-weight: bold;}
.say					{}
.yell					{					font-weight: bold;}
.siliconsay				{font-family: 'Courier New', Courier, monospace;}
.deadsay				{color: #B800B1;}
.radio					{color: #408010;}
.deptradio				{color: #993399;}
.comradio				{color: #526aff;}
.syndradio				{color: #993F40;}
.dsquadradio				{color: #998599;}
.resteamradio				{color: #18BC46;}
.airadio				{color: #FF94FF;}
.centradio				{color: #78789B;}
.secradio				{color: #CF0000;}
.engradio				{color: #A66300;}
.medradio				{color: #009190;}
.sciradio				{color: #993399;}
.supradio				{color: #9F8545;}
.srvradio				{color: #80A000;}
.proradio				{color: #F70285;}
.admin_channel			{color: #fcba03;	font-weight: bold;}
.mentor_channel			{color: #775BFF;	font-weight: bold;}
.mentor_channel_admin      {color: #A35CFF;	font-weight: bold;}
.djradio				{color: #996600;}
.binaryradio				{color: #1B00FB;	font-family: 'Courier New', Courier, monospace;}
.mommiradio				{color: #6685f5;}
.alert					{color: #ff0000;}
h1.alert, h2.alert			{color: #FFF;}
.ghostalert				{color: #cc00c6;	font-style: italic; font-weight: bold;}
.emote					{					font-style: italic;}
.selecteddna				{color: #FFFFFF; 	background-color: #001B1B}

.attack					{color: #ff0000;}
.moderate				{color: #CC0000;}
.disarm					{color: #990000;}
.passive				{color: #660000;}

.warning				{color: #ff0000;	font-style: italic;}
.boldwarning				{color: #ff0000;	font-style: italic;	font-weight: bold}
.danger					{color: #ff0000;	font-weight: bold;}
.userdanger				{color: #ff0000;	font-weight: bold;	font-size: 120%;}
.biggerdanger				{color: #ff0000;	font-weight: bold; font-size: 150%;}

.info					{color: #6685f5;}
.notice					{color: #6685f5;}
.boldnotice				{color: #6685f5;	font-weight: bold;}
.suicide				{color: #ff5050;	font-style: italic;}
.green					{color: #03bb39;}
.announce 				{color: #228b22;	font-weight: bold;}
.boldannounce				{color: #ff0000;	font-weight: bold;}
.greenannounce				{color: #00ff00;	font-weight: bold;}

.alien					{color: #C433C4;}
.noticealien				{color: #00c000;}
.alertalien				{color: #00c000; font-weight: bold;}
.terrorspider				{color: #CF52FA;}


.sinister				{color: #800080;	font-weight: bold;	font-style: italic;} /* /vg/ */
.blob					{color: #006221;	font-weight: bold;	font-style: italic;}
.confirm				{color: #00af3b;}
.rose					{color: #ff5050;}
.sans					{font-family: 'Comic Sans MS', cursive, sans-serif;}
.wingdings				{font-family: Wingdings, Webdings;}
.robot					{font-family: 'PxPlus IBM MDA'; font-size: 1.15em;}
.ancient				{color: #008B8B;	font-style: italic;}
.newscaster				{color: #CC0000;}
.mod					{color: #735638;	font-weight: bold;}
.modooc					{color: #184880;	font-weight: bold;}
.adminmod				{color: #F0AA14;	font-weight: bold;}
.tajaran				{color: #803B56;}
.skrell					{color: #00CED1;}
.solcom					{color: #8282FB;}
.com_srus				{color: #7c4848;}
.zombie					{color: #ff0000;}
.soghun					{color: #228B22;}
.changeling				{color: #800080;}
.vox					{color: #AA00AA;}
.diona					{color:	#804000;	font-weight: bold;}
.trinary				{color: #727272;}
.kidan					{color: #C64C05;}
.slime					{color: #0077AA;}
.drask					{color: #a3d4eb; font-family: "Arial Black";}
.clown					{color: #ff0000;}
.shadowling				{color: #Cb2799;}
.vulpkanin				{color: #B97A57;}
.abductor				{color: #800080; font-style: italic;}
.mind_control				{color: #A00D6F; font-size: 3; font-weight: bold; font-style: italic;}
.rough					{font-family: 'Trebuchet MS', cursive, sans-serif;}
.say_quote				{font-family: Georgia, Verdana, sans-serif;}
.cult					{color: #800080; font-weight: bold; font-style: italic;}
.cultspeech				{color: #AF0000; font-style: italic;}
.cultitalic				{color: #A60000; font-style: italic;}
.cultlarge				{color: #A60000; font-weight: bold; font-size: 120%;}
.narsie					{color: #A60000; font-weight: bold; font-size: 300%;}
.narsiesmall			{color: #A60000; font-weight: bold; font-size: 200%;}
.interface				{color: #9031C4;}
.big					{font-size: 150%;}
.reallybig				{font-size: 175%;}
.greentext				{color: #00FF00;	font-size: 150%;}
.redtext				{color: #FF0000;	font-size: 150%;}
.bold					{font-weight: bold;}
.center					{text-align: center;}
.red					{color: #FF0000;}
.purple					{color: #9031C4;}
.skeleton				{color: #C8C8C8; font-weight: bold; font-style: italic;}
.gutter					{color: #7092BE; font-family: "Trebuchet MS", cursive, sans-serif;}
.orange					{color: #ffa500;}
.orangei				{color: #ffa500; font-style: italic;}
.orangeb				{color: #ffa500; font-weight: bold;}
.resonate				{color: #298F85;}

.revennotice				{color: #6685F5;}
.revenboldnotice			{color: #6685F5;	font-weight: bold;}
.revenbignotice				{color: #6685F5;	font-weight: bold; font-size: 120%;}
.revenminor				{color: #823abb}
.revenwarning				{color: #760fbb;	font-style: italic;}
.revendanger				{color: #760fbb;	font-weight: bold; font-size: 120%;}

.specialnotice				{color: #4A6F82; 	font-weight: bold; font-size: 120%;}

/* /vg/ */
.good					{color: green;}
.average				{color: #FF8000;}
.bad					{color: #FF0000;}
/* /vg/ Saycode Rewrite */
.italics, .talkinto		{font-style:italic;}
.whisper				{font-style:italic;color:#CCCCCC;}
/* Recruiting stuff */
.recruit 				{color: #5c00e6; font-weight: bold; font-style: italic;}

.memo					{color: #638500;	text-align: center;}
.memoedit				{text-align: center;	font-size: 75%;}

.connectionClosed, .fatalError {background: red; color: white; padding: 5px;}
.connectionClosed.restored {background: green;}
.internal.boldnshit {color: #6685f5; font-weight: bold;}

.rebooting {background: #2979AF; color: white; padding: 5px;}
.rebooting a {color: white !important; text-decoration-color: white !important;}
#reconnectTimer {font-weight: bold;}

/* HELPER CLASSES */
.text-normal {font-weight: normal; font-style: normal;}
.hidden {display: none; visibility: hidden;}

/* MEGAFAUNA */
.colossus				{color: #7F282A; font-size: 175%;}
.hierophant				{color: #660099; font-weight: bold; font-style: italic;}
.hierophant_warning		{color: #660099; font-style: italic;}

/* EMOJI STUFF */
.emoji {max-height: 16px; max-width: 16px}

/* ADMIN TICKETS */

.adminticket {color: #3daf21; font-weight: bold}

.adminticketalt {color: #ccb847; font-weight: bold}

/* Syndicate codewords */
span.body .codephrases {color: #5555FF;}
span.body .coderesponses {color: #FF3333;}

</style>
]]