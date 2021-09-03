var settins = {};
var closed = true;
var closep = true;
var lastData = {};
var titlesize = 1.35;
var officersize = 1.3;
var trainspeed = 0;
var currentAction = null;
var htmlcount = 0;
var html = ``;
var insettings = false;
const wait = async () => {
        
  await new Promise(r => setTimeout(r, 5000));
  $(".active-officers").slideUp();
}
// Wrap the entire script in the .ready() to make sure everything has finished loading
$(document).ready(function () {
  $(document).on("input change", "#increase-size", function () {
    lastData.size = $(this).val();
    lastData.title = Math.abs(titlesize * $(this).val());
    lastData.titlep = Math.abs(titlesize * $(this).val());
    lastData.officer = Math.abs(officersize * $(this).val());
    $(".titlep").css("font-size", `${lastData.title}rem`);
    $(".title").css("font-size", `${lastData.titlep}rem`);
    $(".player").css("font-size", `${lastData.officer}rem`);
    $(".officer").css("font-size", `${lastData.officer}rem`);
    $(".officer me").css("font-weight", "bold");
  });

  $(document).on("input", "#wanted-level", function () {
    lastData.wantedlevel = $(this).val();
   console.log(lastData.wantedlevel)
    OOF.CallEvent("wantedlevel", lastData.wantedlevel)
  });
  $(document).on("input", "#train-speed", function () {
    lastData.trainspeed = $(this).val();
   console.log(lastData.trainspeed)
    OOF.CallEvent("trainspeed", lastData.trainspeed)
  });
  $(document).on("input", "#opacity", function () {
    lastData.opacity = $(this).val();
    ChangeBackGround($(this).val());
  });

  $(".restore-btn").on("click", function () {
    lastData = {};
    ChangeBackGround("0.1");
    $(".officer").css("font-size", `1.3rem`);
    $(".title").css("font-size", `1.35rem`);
    $(".titlep").css("font-size", `1.35rem`);
    $(".range-inputes input").val("contrast");
    $(".player").css("font-size", `1.3rem`);
  });

  $(".options-btns").on("click", ".options-btn", function () {
    currentAction = $(this).data("action");
    SetRightInput(currentAction);
  });

  $(".inputs-id").on("click", ".save-btn", function () {
    if (currentAction == null) {
      $(".inputs-id #err-text").text("Please select an action");
      return;
    } else if (currentAction == "remove") {
      if ($("#id").val() == "")
        $(".inputs-id #err-text").text("The input can not be empty!");
      else SendData(null);
    } else {
      if ($("#code").val() == "" || $("#id").val() == "")
        $(".inputs-id #err-text").text("The inputs can not be empty!");
      else SendData($("#code").val());
    }
  });

  //  $(".range-bar").prop('disabled', closed);
  SwitchPages();
  DragAble();
  Close();

  // Subscribe to the DisplayMessage event to receive the data from Lua
  OOF.Subscribe("jjmessage", (data) => {
   
    if (data.action == "open") {             // cannot read open
     
      insettings = true;
      $("#opacity").val(1);
      if (lastData.opacity) {
        $("#opacity").val(lastData.opacity);
      } else if (lastData.size) {
        $("#increase-size").val(lastData.size);
      } else if (lastData.wantedlevel) {
        $("#wanted-level").val(lastData.wantedlevel);
        OOF.CallEvent("wantedlevel", lastData.wantedlevel)
      }
      $(".warrper").show(500);
      $(".settings-container").slideDown();
      $(".active-officers").slideDown();
    } else if (data.action == "hidehud") {
      if (!validate()) {
        $(".active-hud").slideUp();
      }
      // $(".active-hud").slideDown();
    } else if (data.action == "hidenotify") {
      if (!insettings) {
        $(".active-officers").slideUp();
      }
    } else if (data.action == "notify") {
      // $(".officers-container").html("");
      if (validaten()) {
      var msg = data.data;
      console.log(msg)
      $(".titlep span").text(``);

      if (htmlcount == 5) {
        $(".officers-container").html("");
        htmlcount = 0;
      }
      htmlcount = htmlcount + 1;

      html = `<div class="officer">
            <span class="tag">-</span>${msg} <span class="tag">-</span>
        </div>`;
      $(".officers-container").append(html);

      $(".active-officers").slideDown();
      DragAble();
      $(".titlep").css("font-size", `${lastData.title}rem`);
      $(".title").css("font-size", `${lastData.titlep}rem`);
      $(".player").css("font-size", `${lastData.officer}rem`);
      $(".officer").css("font-size", `${lastData.officer}rem`);
      $(".officer me").css("font-weight", "bold");

      wait ();
   
    } else if (data.action == "notifysettings") {
      // $(".officers-container").html("");
      var msg = data.data;
      console.log(msg)
      $(".titlep span").text(``);

      if (htmlcount == 5) {
        $(".officers-container").html("");
        htmlcount = 0;
      }
      htmlcount = htmlcount + 1;

      html = `<div class="officer">
            <span class="tag">-</span>${msg} <span class="tag">-</span>
        </div>`;
      $(".officers-container").append(html);

      $(".active-officers").slideDown();
      DragAble();
      $(".titlep").css("font-size", `${lastData.title}rem`);
      $(".title").css("font-size", `${lastData.titlep}rem`);
      $(".player").css("font-size", `${lastData.officer}rem`);
      $(".officer").css("font-size", `${lastData.officer}rem`);
      $(".officer me").css("font-weight", "bold");

    }
   
    } else if (data.action == "showmehud") {
      $(".active-hud").slideDown();
    } else if (data.action == "hidemehud") {
      if (!Validate()) {
        $(".active-hud").slideUp();
      }
    } else if (data.action == "showhud") {
      $(".officers-hud").html("");

      $(".active-hud").slideDown();
    } else if (data.action == "addmstatshud") {
    //  $(".active-officers").slideDown();
    if (validate()) { $(".active-hud").slideDown();
      $(".officers-hud").html("");
      var officer = data.data[0];
    
      $(".title span").text(`JJs Cool Hud `);
      SwitchPages();
      var html;
      if (officer.visible) {
        html = `
         <div class="player">
         <span class="tag">${officer.name} </span> |💹|  ${officer.data1} | ${officer.data2} | ${officer.data3}  |  <span class="tag">${officer.data4}  </span>  
         <br> <span class="tag">  ${officer.data8} | ${officer.data7} | ${officer.data6}  | ${officer.data5}  </span>  
         <br> <span class="tag">  ${officer.data12} | ${officer.data11}     </span>  
         
         </div>`;
      } else {
        html = `
         <div class="player">
        <span class="tag"> ${officer.name}</span>    ${officer.data1} | ${officer.data2} | ${officer.data3}  | ${officer.data4}
        <br> ${officer.data8} | ${officer.data7} | ${officer.data6}  |  ${officer.data5}    </br> 
         ${officer.data12} | ${officer.data11} | ${officer.data10}   
         </div>`;
      }

      $(".officers-hud").append(html);

      DragAble();
      $(".titlep").css("font-size", `${lastData.title}rem`);
      $(".title").css("font-size", `${lastData.titlep}rem`);
      $(".player").css("font-size", `${lastData.officer}rem`);
      $(".officer").css("font-size", `${lastData.officer}rem`);
      $(".officer me").css("font-weight", "bold");
    }
    } else if (data.action == "paddme") {
      $(".officers-hud").html("");
      var officer = data.data[0];
      $(".title span").text(`JJs Cool Hud `);

      var html;
      if (officer.visible) {
        html = `
         <div class="player">
         <span class="tag">${officer.name} </span> |💹|  ❤️${officer.life} | 🛡️${officer.data10} : ${officer.data9}    
         </div>`;
      } else {
        html = `
         <div class="player">
         <span class="tag"> ${officer.name} </span> ❤️${officer.life} | 🛡️${officer.data10} : ${officer.data9}  |  <span class="tag">COOLING DOWN </span> 
         </div>`;
      }

      $(".officers-hud").append(html);

      DragAble();
      $(".titlep").css("font-size", `${lastData.title}rem`);
      $(".title").css("font-size", `${lastData.titlep}rem`);
      $(".player").css("font-size", `${lastData.officer}rem`);
      $(".officer").css("font-size", `${lastData.officer}rem`);
      $(".officer me").css("font-weight", "bold");
    } else if (data.action == "error") {
      $(".inputs-id #err-text").text(data.errorText);
    } else if (data.action == "update") {
      $(".officers-container").html("");
      var officers = data.data;
      $(".titlep span").text(`JJs CoolHud | Online: (${officers.length})`);
      for (var officer of officers) {
        var html;

        if (officer.visible) {
          html = `
            <div class="officer">
            <span class="tag">${officer.name} </span> | 💹 | ❤️ ${officer.life} | ${officer.data1} | ${officer.data3} |  <span class="tag">${officer.data4}</span> 
  </div>`;
        } else {
          html = `
            <div class="officer">
            <span class="tag"> ${officer.name} </span> ❤️ ${officer.life} | ${officer.data1} | ${officer.data3} |  <span class="tag">${officer.data4}  </span> 
        </div>`;
        }
        $(".officers-container").append(html);
      }
      DragAble();
      $(".titlep").css("font-size", `${lastData.title}rem`);
      $(".title").css("font-size", `${lastData.titlep}rem`);
      $(".player").css("font-size", `${lastData.officer}rem`);
      $(".officer").css("font-size", `${lastData.officer}rem`);
      $(".officer me").css("font-weight", "bold");
    }
  });

  function toggleplayer() {
    closep = !closep;
    $(".range-bar").prop("disabled", !closep);
    if (!insettings) {
      if (!closep) $(".active-officers").slideUp();
    }
    if (closep) $(".active-officers").slideDown();
    $.post(
      "https://jjred/ToggleOpenPlayerlist",
      JSON.stringify({ toggleplayer: true })
    );
  }
  function toggleuser() {
    closed = !closed;
    $(".range-bar").prop("disabled", !closed);

    if (!Validate()) {
      if (!closed) $(".active-hud").slideUp();
    }
    if (closed) $(".active-hud").slideDown();
    $.post(
      "https://jjred/ToggleOpenUser",
      JSON.stringify({ toggleuser: true })
    );
  }

  function SetRightInput(action) {
    if (action == "remove") {
      $("#code").hide();
    } else {
      $("#code").show();
    }
  }

  function SendData(code) {
    var data = {
      action: currentAction,
      id: $("#id").val(),
      code: code,
    };
    $(".inputs-id #err-text").text("");
    $.post("http://jjred/action", JSON.stringify({ data: data }));
  }

  function ChangeBackGround(val) {
    $(".active-officers").css("background-color", `rgba(0,0,0,${val})`);
    $(".active-hud").css("background-color", `rgba(0,0,0,${val})`);
    $(".title").css(
      "background-color",
      `rgba(0,0,0,${addbits(val + 0.02 * 0.1)})`
    );
    $(".titlep").css(
      "background-color",
      `rgba(0,0,0,${addbits(val + 0.02 * 0.1)})`
    );
  }

  function addbits(s) {
    var total = 0,
      s = s.match(/[+\-]*(\.\d+|\d+(\.\d+)?)/g) || [];

    while (s.length) {
      total += parseFloat(s.shift());
    }
    return total;
  }

  function DragAble() {
    $(".active-officers").draggable({
      appendTo: "body",
      containment: "window",
      scroll: true,
    });
    $(".active-hud").draggable({
      appendTo: "body",
      containment: "window",
      scroll: false,
    });
  }

  function SwitchPages() {
    $(".slide-btnRight").on("click", function () {
      $(".page-1").fadeIn(200);
      $(".inputs-id").fadeOut(250);
      $(".settings-container-header span").text("Personal Settings");
    });
  }

  $(document).keyup(function (e) {
    if (e.keyCode == 27) {
   
      insettings = false;
      currentAction = null;
      var datac = makedata();
      $("input").val("");
      $(".warrper").hide();
      $(".settings-container").slideUp();

      $.post("https://jjred/closedata", JSON.stringify(datac));
      closed = false;
      closep = false;
      insettings = false;
    }
  });
  function Close() {
    $("#close-del").on("click", function () {
      insettings = false;
      currentAction = null;
      var datac = makedata();
      $("input").val("");
      $(".warrper").hide();
      $(".settings-container").slideUp();
     
      if ( !validate()){ $(".active-hud").slideUp();}
      if ( !insettings){ $(".active-officers").slideUp();}
      OOF.CallEvent("closedata", datac)
      $.post("https://jjred/closedata", JSON.stringify(datac));
      closed = false;
      closep = false;
      insettings = false;
    });
  }

  function Closer() {
    $("#close-del").on("click", function () {
      insettings = false;
      currentAction = null;
      $("input").val("");
      $(".warrper").hide();
      $(".settings-container").slideUp();
 
      $.post("https://jjred/close", JSON.stringify({}));
      closed = false;
      closep = false;
    });
  }

  function makedata() {
    var checkboxes = document.getElementsByName("statbox");
    var numberOfCheckedItems = 0;
    for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked) {
        settins[checkboxes[i].title] = true;
      } else {
        settins[checkboxes[i].title] = false;
      }
    }
    return settins;
  }
  function validaten() {
  
    var remember = document.getElementById("popups");
    if (remember.checked) {
      return true;
    } else {
      return false;
    }
  }
  function validate() {
    var pstamina = document.getElementById("pstamina");
    if (pstamina.checked) {
   //   $.post("https://jjred/pstaminaon", JSON.stringify({}));
      OOF.CallEvent("pstamina", true)
    } else {
  //    $.post("https://jjred/pstaminaoff", JSON.stringify({}));
      OOF.CallEvent("pstamina", false)
    }
    var jsump = document.getElementById("sjumpcbox");
    if (jsump.checked) {
   //   $.post("https://jjred/sjumpon", JSON.stringify({}));
      OOF.CallEvent("sjump", true)
    } else {
      OOF.CallEvent("sjump", false)
  //    $.post("https://jjred/sjumpoff", JSON.stringify({}));
    }

    var remember = document.getElementById("phudcbox");
    if (remember.checked) {
      return true;
    } else {
      return false;
    }
  }

  // Subscribe to the DisplayMessage event to receive the data from Lua
  OOF.Subscribe("DisplayMessage", (data) => {
    // Use jQuery to set the text of our welcome message
    $("div.welcome-message").text(data.message);
  });

  // Call the Ready event at the bottom of the script after everything has loaded
  // This tells Lua that this UI is ready to be used
  OOF.CallEvent("Ready");
});
