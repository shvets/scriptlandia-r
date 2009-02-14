HAI
MUST HAS STDIO
VISIBLE "HAI WORLD!"
VISIBLE "<h2><a href=\"http://www.tetraboy.com/lolcode/\">Tetraboy's LOL code interpreter!</a></h2>"
VISIBLE "<br>"
VISIBLE "<h3><a href=\"index.lol\">Check out the source!</a></h3>"

I HAS COLOR1
I HAS COLOR2 IZ GREEN
COLOR1 IZ RED
VISIBLE "<h2>LOL CODE IS TEH COOL</h2><h3>Colors</h3><ul><li>&COLOR1&</li><li>&COLOR2&</li></ul>"
BTW THIS IS A COMMENT
BTW THIS FUNC IS NAMED UPPING
SO IM LIKE UPPING WITH VAR VAR2=0
    VAR UPUP!
    I FOUND MAH VAR
KTHX
VISIBLE "FOUR UP? ITZA ".UPPING(4)
VISIBLE "<br />"
IVAR IZ 1
IVAR UPUP!
IVAR UPUP!
IZ &IVAR& == 1
    BTW IF
    VISIBLE "YEAH RLY"
    VISIBLE "<br />"
ORLY &IVAR& == 2
    BTW ELSEIF
    VISIBLE "ORLY"
    VISIBLE "<br />"
NOWAI
    BTW ELSE
    VISIBLE "NOWAI"
    VISIBLE "<br />"
KTHX
ALWAYZ SKY IZ BLUE
VISIBLE __SKY__
NEWVAR IZ UPPING(3)
VISIBLE "<br />What is 2+2? &NEWVAR&<br />"
ARRAY IZ BUCKET
    0 FISH "zero" !!
    1 FISH "one" !!
    two FISH "two" !!
    three FISH IZ BAG
        !! FISH "three" !!
    BAG
BUCKET
BTW!
array (0=>'zero',1=>'one','two'=>'two','three'=>array('three'))
!BTW
VISIBLE "How many fish in bag three?<br/>"
VISIBLE &ARRAY#three,0&
VISIBLE "<br />"
THEVAR IZ GOLD
VARNAME IZ THEVAR
VISIBLE &&VARNAME&&
VISIBLE "<br />"

CAN HAS SQL?
DBASE IZ GETDB('lolz.db')
FUNNAHS IZ DBUCKET(&DBASE&,"CAN I PLZ GET joke ALL UP IN funnahs")
IM IN UR FUNNAHS ITZA JOKE
    VISIBLE "<P>".NL2BR(&JOKE#joke&)."</P>"
KTHX
    

VISIBLE "ROFLROFL KTHXBYE"

BTW Diz iz commentz code
VISIBLE "<hr width=100% size=10>"
VISIBLE "<HL /> Comments: (script written in LOLCODE) <BR /><br>"


I HAS PAGE IZ $_GET["page"]
IZ !&PAGE& 
	PAGE IZ 'index'
KTHX
I HAS TABLE IZ "lol_".&PAGE&
I HAS COMMENT IZ $_POST["commentz"]
I HAS USER IZ $_POST["omguser"]
I HAS SPAM IZ $_POST["maps"]
I HAS COMMENTTEXT IZ "COMMENT HURR, REMEMBR, CEILING CAT WATCHES U"
I HAS DB IZ 'comments.db'
DEEBEE IZ GETDB(&DB&)

SO IM LIKE ADDCOMMENTTODB WITH COMMENT NAME
	global &DEEBEE&;
	global &TABLE&;
	DODIZ(&DEEBEE&, "LEMME PUT INTO ".&TABLE&." (name,comment) THESE ('&NAME&','&COMMENT&')" );
KTHX	


SO IM LIKE IZVALID WITH COMMENT NAME
	I HAS TRUE IZ 1
	I HAS FALSE IZ 0
	I HAS REGEX IZ "/<\sa\s[^>]*>.*<\s\/\sa\s>/i"
	IZ preg_match(&REGEX&,&COMMENT&) or preg_match(&REGEX&,&NAME&)
		VISIBLE "<script>alert('your comment failed because it contained a link')</script>"
		VISIBLE "AKK! your comment got lolpwned"
		I FOUND MAH FALSE
	KTHX
	I FOUND MAH TRUE
KTHX

SO IM LIKE VALIDATE WITH TEXT
	&TEXT&=strip_tags(&TEXT&);
	&TEXT&=htmlspecialchars(&TEXT&);
	I FOUND MAH &TEXT&
KTHX

IZ $COMMENT AND $COMMENT != $COMMENTTEXT
	IZ $USER
		IZ !$SPAM
			IZ IZVALID(&COMMENT&,&NAME&)
				BTW VISIBLE "<BR/>YER COMMENT WAS: ".$COMMENT.", AND YER NAME IS: ".$USER
				ADDCOMMENTTODB(VALIDATE(&COMMENT&),VALIDATE(&USER&));
			KTHX
		KTHX
	KTHX
KTHX

COMMENTZ IZ DBUCKET(&DEEBEE&,"CAN I PLZ GET * ALL UP IN ".$TABLE)
IM IN UR COMMENTZ ITZA COMMENT
	VISIBLE "Name: ".&COMMENT#name&.":<BR />   ".NL2BR(&COMMENT#comment&)."<hr width=200px align=left>"
KTHX
VISIBLE "<hr width=100% size=10>"
VISIBLE "Because of a select few lolcats, no tags at all are allowed, and if your comment contains a link, it will be thrown out. sorry... really... :-\\"
VISIBLE '<form action="/index.php?id='.$PAGE.'"method=post>'
VISIBLE 'Name: <input type=text rows=1 cols=25 name="omguser">'
VISIBLE '<BR />'
VISIBLE '<TEXTAREA NAME="commentz" cols="50" rows="10">'.$COMMENTTEXT.'</TEXTAREA>'
VISIBLE '<BR />'
VISIBLE 'Antispam! (uncheck to submit): ARE YOUZ SPAM? <input type=checkbox name="maps" value="true" checked>'
VISIBLE '<input type=submit value=" Comment ">'
VISIBLE '</form>'


BTW this is counter code
I HAS COUNTER IZ 0
I HAS COUNTERDB IZ "counter.db"
I HAS CEEDEEBEE IZ GETDB(&COUNTERDB&)
I HAS COUNTERZ IZ DBUCKET(&CEEDEEBEE&,"CAN I PLZ GET * ALL UP IN COUNTER WHERE page='&TABLE&'")
COUNTER IZ &COUNTERZ&[0]['count']
VISIBLE "<hr><br>ZOMFG, MORE THAN $COUNTER PPLZ HAVE BEEN LOLCATTED<br>"
COUNTER IZ (int)&COUNTER&
COUNTER UPUP!
BTW This upups the deebee. duh.
DODIZ(&CEEDEEBEE&, "UPDATE COUNTER SET count=&COUNTER& WHERE page='&TABLE&'" );
	

KTHXBYE