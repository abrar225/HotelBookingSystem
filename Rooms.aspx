<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="WebApplication7.Rooms" %>

<!DOCTYPE html>
<html>
<head>
    <title>Rooms</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8" />
    <link rel="icon" href="icon.png" />
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
    <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,200,300,700,600' rel='stylesheet' type='text/css' />
    <link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300' rel='stylesheet' type='text/css' />
    <link href='https://fonts.googleapis.com/css?family=Raleway:400,100' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
    <link rel='stylesheet prefetch' href='https://maxcdn.buootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.3/animate.min.css'>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="style.css" rel="stylesheet" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
    <script src="https://code.jquery.com/ui/1.8.21/jquery-ui.min.js"></script>
    <script src="velocity.js"></script>
    <script src="JavaScript.js"></script>
    <script src="java.js"></script>
    <meta name="description" content="Browse Rooms At Hotel Booking System. Select Check-in/out Date and browse available room within that time slot." />
    <meta name="keywords" content="Check in, Check out, Room Details" />
    <meta name="author" content="Bilal" />
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/component.css" />
    <link href="/css/jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript">
        var im;
        function sendFile(file) {
            var formData = new FormData();
            formData.append('file', file);
            $.ajax({
                type: 'post',
                url: 'Handler1.ashx',
                data: formData,
                async: false,
                success: function (status) {
                    if (status != 'error') {
                        var my_path = "MediaUploader/" + status;
                        $(im).attr("src", my_path);
                        $(im).hide();
                        $("#imgs").append(im);
                        im = $("#imgs #myUploadedImg").eq(0).clone(true);
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    alert("Whoops something went wrong!");
                }
            });
        }
        $(document).on("click", ".room-specs ul li>span", function (e) {
            if ($("#specs ul li").length == 1) {
                $("#specs").velocity({
                    scale: 0
                }, {
                        duration: 200
                    });
                setTimeout(function () {
                    $("#specs").hide();
                }, 500);
            }
            $(this).parent().velocity({
                scale: 0
            }, {
                    duration: 500
                });
            var t = $(this).parent();
            setTimeout(function () {
                t.remove();
            }, 500);
        });
        $(document).ready(function () {
            $("#specs ul").sortable({
                revert: false,
                helper: "clone",
                sort: function (event, ui) {
                    $("#specs ul li:last-child").css({
                        'top': '-=180px',
                        'left': '-=60px'
                    });
                }
            });
            $("#specs").velocity({
                scale: 0
            });
            $("#Button3").click(function () {
                var txt = $("#features").val();
                if (txt == '')
                    return;
                $("#features").val('');
                $("#features").focus();
                var toapp1 = "<li style=" + '"display:none"' + ">" + txt + "<span></span></li>";
                $("#specs ul").append(toapp1);
                if ($("#specs ul li").length > 0 && $("#specs").is(":hidden")) {
                    $("#specs").show().velocity({
                        scale: 1
                    }, 200);
                }
                $("#specs ul li:last-child").show().velocity({
                    scale: 0
                }, 0).velocity({
                    scale: 1
                }, 500);
            });
            var len = $(".imgsup").length, p = 0, inter;
            im = $("#imgs #myUploadedImg").eq(0).clone(true);
            $("#imgs #myUploadedImg").remove();
            var _URL = window.URL || window.webkitURL;
            $("#f_UploadImage").on('change', function () {
                $("#imgs #myUploadedImg").remove();
                var dlen = parseInt(this.files.length);
                if (dlen > 3)
                    dlen = 3;
                var count = 0;
                for (var i = 0; i < this.files.length && count < dlen; i++) {
                    var file;
                    if ((file = this.files[i])) {
                        var temp = new String(file.type);
                        var ind = new Number(temp.indexOf("/"));
                        if (temp.substring(0, ind) == "image") {
                            count++;
                            sendFile(file);
                        }
                    }
                }
                len = $(".imgsup").length, p = 0;
                inter = setInterval(function () {
                    if (p < len) {
                        $(".imgsup").eq(p).show().velocity({
                            scale: 1
                        }, 200);
                    }
                    else {
                        clearInterval(inter);
                    }
                    p++;
                }, 300);
            });
        });
        $(document).on("click", ".custom", function (e) {
            if (e.target.id == "view") {
                var id = $(this).find("#apid").val();
                window.location.href = "Details.aspx?rid=" + id;
            }
            if (e.target.id == "viewus") {
                var id = $(this).find("#id").val();
                window.location.href = "Details.aspx?rid=" + id;
            }
            if (e.target.id == "delete") {
                if (confirm('Are you sure you want to delete the room?')) {
                    var id = $(this).find("#id").val();
                    var roomtemp = $(this);
                    $.ajax({
                        type: "POST",
                        url: "Rooms.aspx/deleteroom",
                        data: JSON.stringify({ rid: id }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (e) {
                            $(roomtemp).fadeOut().remove();
                        },
                        error: function (err) {
                            alert(err.responseText);
                        }
                    });
                }
            }
        });
    </script>
</head>
<body>
    <script>
        function checkLoginState() {
            FB.getLoginStatus(function (response) {
                if (response.status == "connected") {
                    FB.api('/me?fields=name,picture,first_name,last_name,email', function (response) {
                        register1(response.first_name, response.last_name, response.id, response.email, "1234", "", "", 1, response.picture.data.url, 0);
                    });
                }
            });
        }
        window.fbAsyncInit = function () {
            FB.init({
                appId: '349149585595089',
                cookie: true,
                xfbml: true,
                version: 'v2.12'
            });
            FB.AppEvents.logPageView();
            FB.getLoginStatus(function (response) {
                if (response.status == "connected") {
                    FB.api('/me?fields=name,picture,first_name,last_name,email', function (response) {
                        loginuser(response.id, '1234');
                    });
                }
            });
        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) { return; }
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
    <div id="error" style="display: none; width: 100%; transform: scale(0); padding: 5px; text-align: center; color: white; background: red;">
        <a id="eclose" href="#" onclick="return false" style="color: white; font-size: 10px; opacity: 1" class="close">&#x2715;</a>
        Your Email Hasn't Been Confirmed Yet. Please Confirm Your Email To use Your Account.
            <a id="resend" href="#" onclick="return false" style="color: white;">Didn't get the Email? Click Here!</a>
    </div>
    <label id="sizeof" style="display: none" hidden="hidden">400</label>
    <label id="sizefrom" style="display: none" hidden="hidden">#toapp</label>
    <div id="effect" style="position: fixed; left: 0; right: 0; top: 0; bottom: 0; z-index: 90">
    </div>
    <div id="adddiv" class="login" style="height: auto">
        <a href="#" onclick="return false" class="close">&#x2715;</a>
        <h2>Add Room
        </h2>
        <div class="col-md-12 loginin">
            <select name="room" id="room" style="margin-bottom: 20px;" class="form-control">
                <option>Single Room</option>
                <option>Double Room</option>
                <option>Suite Room</option>
            </select>
            <input id="rname" placeholder="Name" autocomplete="on" />
            <input id="price" placeholder="Price" autocomplete="on" />
            <div id="specs" style="display: none; padding: 10px;" class="room-specs">
                <h3>Features</h3>
                <ul>
                </ul>
            </div>
            <input id="features" placeholder="Add Feature" style="float: left; height: 35px;" autocomplete="on" />
            <input id="Button3" style="display: none; width: 15%; margin-left: 0; float: right" onclick="return false" type="submit" value="Add" />
            <textarea id="TextArea1" rows="2" placeholder="Description" cols="20"></textarea>
            <input type="file" name="file-5[]" id="f_UploadImage" multiple class="inputfile inputfile-4" />
            <label for="f_UploadImage">
                <figure>
                    <svg xmlns="https://www.w3.org/2000/svg" width="20" height="17" viewbox="0 0 20 17">
                        <path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z" />
                    </svg>
                </figure>
                <span>Choose a file&hellip;</span>
            </label>
            <div id="imgs" class="col-md-12" style="margin-bottom: 30px; text-align: center">
                <img src="#" class="imgsup" style="width: 100px; height: 100px; transform: scale(0); margin-left: 5px; margin-bottom: 5px" id="myUploadedImg" alt="Photo" />
            </div>
            <input id="Button2" onclick="return false" style="margin: auto" type="submit" value="Add" />
        </div>
    </div>
    <div id="logindiv" class="login">
        <a href="#" onclick="return false" class="close">&#x2715;</a>
        <h2>Login Information
        </h2>
        <div class="col-md-12 loginin">
            <form>
                <input id="Email" placeholder="Username or Email" type="text" />
                <input id="Pass" style="margin-bottom: 10px!important" placeholder="Password" type="password" autocomplete="on" />
                <a href="Register.aspx">Don't Have an account? Signup Here!</a>
                <div style="padding-top: 3px; padding-bottom: 3px">
                    <fb:login-button
                        scope="public_profile,email"
                        onlogin="checkLoginState();">
                    </fb:login-button>
                </div>
                <input id="Button1" onclick="return false" type="submit" value="Submit" />
            </form>
        </div>
    </div>
    <div class="site-branding-area" style="height: 100px;">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <a class="logo" style="cursor: pointer; text-decoration: none" href="Home.aspx">
                        <h2 style="color: #fff; margin-top: 40px;">Hotel <span style="color: #edb83a">Booking</span> System
                        </h2>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="mainmenu-area" style="z-index: 3000">
        <div id="hoverpic" style="float: right; height: 99%; right: -5px; border: solid 1px; cursor: pointer; border-color: #e2eeeb; position: absolute; margin-right: 10%; background-color: #333; z-index: 1000; opacity: .5">
        </div>
        <div class="loginfo">
            <ul id="filters1">
                <li><a id="showprofilre" href="Profile.aspx">Profile</a></li>
                <li><a id="logout" href="#" onclick="return false">Logout</a></li>
            </ul>
        </div>
        <img style="float: right; height: 80%; margin-top: 5px; z-index: 100; margin-right: 10%; position: relative; border-radius: 5px" id="loginb" src="img/pic.jpg" alt="" />
        <div class="container">
            <div class="row">
                <div class="navbar-header">
                    <button id="show" style="float: left" type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div id="menu" class="navbar-collapse collapse" style="display: none;">
                    <ul style="margin-left: 5%" class="nav navbar-nav">
                        <li><a href="Home.aspx">Home</a></li>

                        <li><a href="#">Rooms</a></li>
                        <li><a href="Booking.aspx">Booking</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="menu-bottom">
        <h1>The Room</h1>
        <h3>Modern &amp; Spaciuos</h3>
    </div>
    <div class="container">
        <div class="col-md-12" style="margin-top: 20px; text-align: center">
            <ul id="filters">
                <li><a href="#" data-type="*" data-status="approved" onclick="return false" class="selected">Show All</a></li>
                <li><a href="#" data-type="Single Room" data-status="approved" onclick="return false" class="">Single Rooms</a></li>
                <li><a href="#" data-type="Double Room" data-status="approved" onclick="return false">Double Rooms</a></li>
                <li><a href="#" data-type="Suite Room" data-status="approved" onclick="return false">Suite Rooms</a></li>
                <li><a href="#" data-type="*" class="admin" data-status="unapproved" onclick="return false">Un-Available Rooms</a></li>
            </ul>
        </div>
    </div>
    <div id="rdates" class="col-md-12" style="padding-left: 14%; padding-right: 14%; padding-bottom: 50px; z-index: 89; height: 40px">
        <input id="from" class="rdate" style="width: 130px; float: left" placeholder="Check-In" type="text" />
        <input id="to" class="rdate" style="float: right; width: 130px" placeholder="Check-Out" type="text" />
    </div>
    <form runat="server">
        <div style="width: auto;">
            <div id="toapp" class="temp" style="height: auto; width: 100%!important; padding-left: 10%; padding-right: 10%;">
                <div id="toappafter"></div>
                <div id="appr" class="custom" data-type="approved" style="margin-bottom: 20px; display: none">
                    <asp:HiddenField ID="id" runat="server" />
                    <div class="room-item item">
                        <div class="overlay" style="overflow: hidden; height: 80px; margin-top: 20px;">
                            <a href="#" onclick="return false">
                                <h1 id="ename" style="white-space: nowrap; overflow: hidden; font-weight: bold!important">Luxury Room</h1>
                            </a>
                            <div class="desc" style="opacity: 0; overflow: hidden; height: 0; margin-top: 0;">
                                <label id="desc" style="font-weight: normal; overflow: hidden; max-height: 50%">Info About Room</label>
                                <div class="price">
                                    <label id="priceappr" style="font-weight: inherit!important; font-size: inherit!important;">$400</label>
                                    <span style="font-size: inherit!important; font-weight: inherit!important">/night</span>
                                </div>
                                <a id="viewus" href="#" onclick="return false" class="btn-border">View Details</a>
                                <a id="delete" style="display: none" href="#" onclick="return false" class="btn-border admin">Delete Room</a>
                            </div>
                        </div>
                        <img id="img" src="/img/pic.jpg" alt="">
                    </div>
                </div>
                <div id="uploaddiv" class="custom" style="margin-bottom: 20px; display: none">
                    <div class="room-item item">
                        <img id="upload" style="cursor: pointer;" src="/img/upload.png" alt="">
                    </div>
                </div>
            </div>
            <div id="navigatebuttons" style="margin-bottom: 20px; display: none" class="container">
                <div class="row">
                    <div class="col-md-12">
                        <a id="prev" href="#" onclick="return false" class="btn-border">Previous</a>
                        <a id="next" href="#" onclick="return false" style="float: right" class="btn-border">Next</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--footer-->
    <a href="#" onclick="return false" id="toTop" style="display: none;"><span id="toTopHover" style="opacity: .7;"></span>To Top</a>
    <div class="footer-top-area">
        <div class="zigzag-bottom"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="footer-about-us">
                        <h3>About Us</h3>
                        <p>This Section will Cover info about hotel itself</p>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6">
                    <div class="footer-menu">
                        <h3 class="footer-wid-title">User Navigation </h3>
                        <ul>
                            <li><a href="#">Front page</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6">
                    <div class="footer-menu">
                        <h3 class="footer-wid-title">Our Address</h3>
                        <address>
                            <span>352 Faisal Town, Lahore</span>
                            <span><strong>Phone:</strong>(92) 123 4567</span>
                            <span><strong>Fax:</strong>(92) 123 4567</span>
                            <span><strong>Email:</strong><a href="mailto:contact@example.com">contact@example.com</a></span>
                            <span><strong>Web:</strong><a href="#test">https://example.com</a></span>
                        </address>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
