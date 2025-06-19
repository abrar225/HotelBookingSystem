<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="WebApplication7.Details" %>

<!DOCTYPE html>
<html>
<head>
    <title>Room Details</title>
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
    <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.3/animate.min.css'>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Room Details - Hotel Booking System" />
    <meta name="keywords" content="Room info, Pictures, Booking" />
    <meta name="author" content="Bilal" />
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3.css">
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
    <script src="JavaScript.js"></script>
    <script src="java.js"></script>
    <script src="velocity.js"></script>
    <script src="SingleRoom.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
    <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
    <style>
        .mySlides {
            display: none;
        }

        .demo {
            cursor: pointer;
        }

        a {
            outline: none;
            color: #d3394c;
            text-decoration: none;
        }

        .inner {
            padding: 30px 40px;
            background: #eee;
        }

        p {
            margin: 0 0 10px;
        }

        .room-specs ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

            .room-specs ul li:before {
                list-style: none;
                color: #EDB83A;
                content: open-quote;
                font-size: 14px;
                line-height: .1em;
                margin-right: 10px;
                font-family: FontAwesome;
                content: "\f046";
            }

        .room-single .room-specs {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .room-specs ul li {
            border-bottom: solid 1px #ddd;
            padding-bottom: 5px;
            margin-bottom: 5px;
        }

        .hoverupload {
            transition: background-color 200ms linear;
        }

            .hoverupload:hover {
                background-color: cornflowerblue;
                cursor: pointer;
            }

        body {
            font-family: "Open Sans",Arial,Helvetica,sans-serif;
            font-size: 13px;
            line-height: 1.7em;
            margin: 0;
            padding: 0;
            color: #888;
            background: #fff;
        }

        h3, h4, h5, h6 {
            color: #333;
            font-family: "Merriweather";
        }

        .btn-border {
            border: solid 1px rgba(0,0,0,.3);
            background: none;
            padding: 5px 20px;
            color: #333;
            text-decoration: none !important;
        }

            .btn-border:hover {
                color: white;
                background-color: black;
            }

        hr {
            border: none;
            height: 80px;
            background: url(../img/divider-1.png) center no-repeat;
            clear: both;
        }

        .price {
            font-size: 32px;
            color: #333;
            font-family: "Cinzel";
            margin: 30px 0;
        }

        .adminfeature {
            background: none;
            margin: 2px !important;
            margin-top: -30px !important;
            margin-left: 15% !important;
            width: 80% !important;
        }

        .room-specs ul p:before {
            list-style: none;
            color: #EDB83A;
            content: open-quote;
            font-size: 14px;
            line-height: .1em;
            margin-right: 10px;
            font-family: FontAwesome;
            content: "\f046";
        }

        label {
            display: block;
        }

        .room-specs ul p > span:before {
            cursor: pointer;
            float: right;
            margin-top: -15px;
            list-style: none;
            color: red;
            content: open-quote;
            font-size: 14px;
            line-height: .1em;
            font-weight: bolder;
            font-family: FontAwesome;
            content: "\2212";
        }

        h2 {
            font-weight: 400;
            margin: 10px 0;
            font-size: 30px;
            line-height: 1.1;
        }
        .room-specs ul p > span {
            float: right;
        }
    </style>
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
    <div id="effect" style="position: fixed; left: 0; right: 0; top: 0; bottom: 0; z-index: 90">
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
                <div style="padding-top:3px; padding-bottom:3px">
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
    <div class="mainmenu-area">
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

                        <li><a href="Rooms.aspx">Rooms</a></li>
                        <li><a href="Booking.aspx">Booking</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="menu-bottom">
        <h1>Deluxe</h1>
        <h3>Room</h3>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-12" style="background-color: white; margin-top: 3%">
                <div align="right" class="col-md-12 admin" style="display:none">
                    <span style="font-weight:bold; font-size:larger">Available: </span>
                    <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" style="width: auto;" for="switch-1">
                        <input type="checkbox" id="switch-1" class="mdl-switch__input" checked>
                        <span class="mdl-switch__label"></span>
                    </label>
                </div>
                <div class="col-md-8" style="margin-top: 10px;">
                    <div id="slider" class="w3-content" style="width: 100%; max-width: 1200px">
                        <div id="toappbef" class="w3-row-padding w3-section">
                        </div>
                    </div>
                </div>
                <div class="col-md-4 inner" style="margin-top: 10px; text-align: center!important; min-height: 600px">
                    <div class="text">
                        <h4>Overview</h4>
                        <p id="descp1"></p>
                        <a id="updateroom" href="#" onclick="return false" style="display: none" class="btn-border manager">Update</a>
                        <div class="room-specs" style="border: none">
                            <h4>Features</h4>
                            <ul>
                            </ul>
                        </div>
                    </div>
                    <div id="appr" class="price user" style="display: none">
                        <label id="price" style="font-weight: normal!important; display: inline-block">Loading..</label><span>/night</span>
                    </div>
                    <div id="unappr" class="price admin" style="display: none; padding: 3px!important; margin-bottom: 50px">
                        <input id="Text1" style="width: 40%; float: left; background-color: transparent; font-size: 25px; margin: 0!important; border-bottom-color: #edb83a; height: 25px;" type="text" /><span style="padding: 0px; float: left">/night</span>
                    </div>
                    <div style="padding-bottom: 10px; display: none" class="updateprice">
                        <a id="updateprice" href="#" onclick="return false" class="btn-border">Update Price</a>
                    </div>
                    <a id="booknow" style="display: none" href="#" onclick="return false" class="btn-border user">Book Now</a>
                    <a id="deleteroom" style="display: none" href="#" onclick="return false" class="btn-border admin">Delete Room</a>
                    <script type="text/javascript">
                        function getUrlVars() {
                            var vars = [], hash;
                            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                            for (var i = 0; i < hashes.length; i++) {
                                hash = hashes[i].split('=');
                                vars.push(hash[0]);
                                vars[hash[0]] = hash[1];
                            }
                            return vars;
                        }
                        $("#booknow").click(function (e) {
                            e.preventDefault();
                            var id = parseInt(getUrlVars()['rid']);
                            if (isNaN(id)) {
                                window.location.href = "Rooms.aspx";
                                return false;
                            }
                            window.location.replace("Booking.aspx?rid=" + id);
                        });
                    </script>
                    <a id="approm" href="#" onclick="return false" style="display: none" class="btn-border manager">Approve</a>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <form runat="server">
        <div class="container" style="margin-bottom: 80px">
            <div id="adjacent" class="row">
                <div id="tocopy" class="col-md-6 rooms" style="margin-bottom: 20px; height: 420px;">
                    <input id="id" type="hidden" />
                    <div class="room-item item">
                        <div class="overlay">
                            <a href="#">
                                <h1 id="ename">Deluxe Room</h1>
                            </a>
                            <div class="desc" style="opacity: 0;">
                                <label id="addescp" style="font-weight: normal; overflow: hidden; max-height: 50%"></label>
                                <div class="price">
                                    <label id="adprice" style="font-weight: inherit!important; font-size: inherit!important;"></label>
                                    <span style="font-weight: inherit!important; font-size: inherit!important;">/night</span>
                                </div>
                                <a id="view" href="#" onclick="return false" class="btn-border">View Details</a>
                            </div>
                        </div>
                        <img id="adpic" src="/img/pic.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </form>
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
