


var data
var book = document.getElementsByClassName("flipbook")[0]
var frontimage = document.getElementById("frontimage")
var midimage = document.getElementById("midimage")
var backimage = document.getElementById("backimage")
var inited = false
var editable = false
var currentEditingPageIndex
var _editor
var settings
var onClose
var bookIsOpen = false

document.getElementById("closesettingsbutton").onclick = function() {
    SetClass("w_settings","off")
}

function StartBook(args, data2) {

   
    if( args == null ) { return false }
    if( args.data == null ) {return false}
    d = args.data
   
    edit = !!args.edit
    onClose = args.onClose


    SetClass("w_book","off",false)
    SetClass("w_content","off",false)

    if( !inited ) {
        inited = true
        $('.flipbook').turn({
            width:922*1.5,
            height:600*1.5,
            elevation: 50,
            gradients: true,
            autoCenter: true
        });
    }


    editable = edit
    data = d
    data.pages=data2.pages
    frontimage.value = data.frontImage || ""; frontimage.onchange = function() { data.frontImage = frontimage.value }
    midimage.value = data.midImage || ""; midimage.onchange = function() { data.midimage = midimage.value }
    backimage.value = data.backImage || ""; backimage.onchange = function() { data.backimage = backimage.value }

    if( data == null || data == "" || data.pages == null || data.pages.length == 0 ) {
        $(".flipbook").turn("addPage", CreatePageElement(editable))
        $(".flipbook").turn("addPage", CreatePageElement(editable))
        $(".flipbook").turn("addPage", CreatePageElement(editable))
    } else {
        BuildPages()
        $(".flipbook").turn("page",1);
    }
    $(".flipbook").bind("turned", function(event, page, view) {
        document.getElementsByClassName("w_flip")[0].classList.toggle("off",true)
    });

}
function StopBook() {
    SetClass("w_book","off",true)
    SetClass("w_content","off",true)
}
function BuildPages() {
    var pageCount = $(".flipbook").turn("pages")
    for( var i = pageCount; i > 0; i--) {
        if($(".flipbook").turn("hasPage",i) == false ) { continue}
        $(".flipbook").turn("removePage", i);
    }
    for( var i = 0; i < data.pages.length; i++ ) {
        $(".flipbook").turn("addPage", CreatePageElement(editable,data.pages[i]))
    }
}
function CreatePageElement(editable,data) {

    var element = document.createElement("div")
    element.classList.add("w_bookpage")
    element.id = "bookpage" + ($(".flipbook").turn("pages")+1)

    if( data != null && data.background != null ) {
        element.style.backgroundImage = "url('"+data.background+"')"
    }
    if( data != null && data.backgroundColor != null ) {
        element.style.backgroundColor = data.backgroundColor
    }
    if( data != null && data.color != null ) {
        element.style.color = data.color
    }

    var cont = document.createElement("div")
    cont.id = "pagecontent" + ($(".flipbook").turn("pages")+1)
    cont.classList.add("w_pagecontent")
    //cont.classList.add("markdown-body")
    cont.setAttribute("pageIndex",$(".flipbook").turn("pages")+1)
    cont.innerHTML = data.content || ""
    element.appendChild(cont)


    return element
}



function SetClass(className,otherClassName,enable) {
    if(document.getElementsByClassName(className).length == 1 ) {
        document.getElementsByClassName(className)[0].classList.toggle(otherClassName,enable)
    } else {
        document.getElementById(className).classList.toggle(otherClassName,enable)
    }
}


function index(page) {
    $(".flipbook").turn("page",page);
}

window.addEventListener('message', function(event) {

    if (event.data.type == "OpenBookGui2") {
        if (event.data.value == true) {
            //DebugInit(true)
            var url = new URL(window.location.href);

            StartBook({data:{pages:[
               
            ]
            },
            edit: (url.searchParams.get("edit") != null),
            }, event.data)
                    bookIsOpen = true

        } else if (event.data.value === false) {
            if (bookIsOpen) {
                StopBook()
            }
        }
    }
})


$(document).keydown(function(e){

    var previous = 37, next = 39, close = 27, close2 = 8;

    switch (e.keyCode) {
        case previous:

        $('.flipbook').turn('previous');
        break;

        case next:

        $('.flipbook').turn('next');            
        break;
        
        case close:
            Post('http://JJz/close')
        break;

        case close2:
            Post('http://JJz/close')
        break;
    }

});

function SPAWNit(weapon,isammo) {
    var d = {}
    d.weapon = weapon;
    if (isammo == null) {
        d.isammo = 0
    } else {
        d.isammo = isammo;
    }
    Post('http://JJz/Spawnit',d)
}

function Buy(weapon,isammo) {
    var d = {}
    d.weapon = weapon;
    if (isammo == null) {
        d.isammo = 0
    } else {
        d.isammo = isammo;
    }
    Post('http://JJz/purchaseweapon',d)
}

Post = function(url,data) {
    var d = (data ? data : {});
    $.post(url,JSON.stringify(d));
  };

  function toggleDisplay(elem, disp) {
	if (elem.style.display == disp) {
		elem.style.display = 'none';
	} else {
		elem.style.display = disp;
	}
}

function toggleScoreboard() {
	toggleDisplay(document.querySelector('#scoreboard'), 'block');
	toggleDisplay(document.querySelector('#counts'), 'block');

}

function updatecount(ps,zs,php) {
	
	var scoreboard = document.querySelector('#counts');

	scoreboard.innerHTML = '';

		var div = document.createElement('div');
		div.className = 'player-count';
		var playerDiv1 = document.createElement('div');
		playerDiv1.className = 'ped1';
		playerDiv1.innerHTML = "Peds::";
		var playerDiv = document.createElement('div');
		playerDiv.className = 'ped';
		playerDiv.innerHTML = ps;
		var scoreDiv1 = document.createElement('div');
		scoreDiv1.className = 'zs1';
		scoreDiv1.innerHTML = "--|||-- Zombies::";

		var scoreDiv = document.createElement('div');
		scoreDiv.className = 'zs';
		scoreDiv.innerHTML = zs;

		div.appendChild(playerDiv1);
		
		div.appendChild(playerDiv);
		div.appendChild(scoreDiv1);
		div.appendChild(scoreDiv);
		scoreboard.appendChild(div);
	
}

function updateScoreboard(scores,php) {
	var scoreData = JSON.parse(scores);
	var scoreboard = document.querySelector('#player-scores');

	scoreboard.innerHTML = '';

	for (var i = 0; i < scoreData.length; ++i) {
		var div = document.createElement('div');
		div.className = 'player-score';

		var playerDiv = document.createElement('div');
		playerDiv.className = 'player';
		playerDiv.innerHTML = scoreData[i].name;

	
		var scoreDiv = document.createElement('div');
		scoreDiv.className = 'score';
		scoreDiv.innerHTML = scoreData[i].killed;


        var divhp = document.createElement('div');
        
        divhp.className = 'php';
		divhp.innerHTML = php;


        div.appendChild(divhp);
		div.appendChild(playerDiv);
	
		div.appendChild(scoreDiv);
	
		
		scoreboard.appendChild(div);
	}
}

function updatehp(total) {
	document.querySelector('#player-health').innerHTML = total;
}
function updatezkills(total) {
	document.querySelector('#total-kills').innerHTML = total;
}
function updatemurders(total) {
	document.querySelector('#total-murders').innerHTML = total;
}
function updatemissed(total) {
	document.querySelector('#total-missed').innerHTML = total;
}
window.addEventListener('message', function(event) {
	switch (event.data.type) {
		case 'toggleScoreboard':
			toggleScoreboard();
			break;
		case 'updateScoreboard':
			updateScoreboard(event.data.scores,event.data.php);
			break;
		case 'updatecount':
			updatecount(event.data.ps,event.data.zs);
			break;			
		case 'updatemurders':
			updatemurders(event.data.ps);
			break;			
            case 'updatehp':
                updatehp(event.data.php);
                break;		
		case 'updatemissed':
			updatemissed(event.data.ps);
			break;
			case 'updatezkills':
				updatezkills(event.data.ps);
				break;
	//	case 'updateTotalUndeadKilled':
	//		updateTotalUndeadKilled(event.data.total);
	//		break;
	}
});
