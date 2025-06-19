<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="WebApplication7.Booking" %>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Room</title>
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
    <link href="/css/jquery-ui.css" rel="stylesheet" />
    <script src="JavaScript.js"></script>
    <script src="velocity.js"></script>
    <script src="booking.js"></script>
    <meta name="description" content="Book Room At Hotel Booking System. Check in, Check out and Enjoy Your Stay!" />
    <meta name="keywords" content="Check in, Check out and Enjoy Your Stay!" />
    <meta name="author" content="Bilal" />
    <script src="java.js"></script>
    <style>
        .special span {
            color: red !important;
        }

        a {
            outline: none;
            color: #d3394c;
            text-decoration: none;
        }

        .not-special span {
            color: green !important;
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
                        <li><a href="#">Booking</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="menu-bottom">
        <h1>Booking</h1>
        <h3>Make Reservations</h3>
    </div>
    <div id="content" style="padding: 100px; width: 100%;">
        <div>
            <div class="row">
                <div class="col-md-8">
                    <div class="contact_form_holder">
                        <form name="contactForm" id="booking_form" method="post" action="reservation.php">
                            <div class="col-md-4">
                                <input type="text" name="name" id="name" placeholder="Your Name">
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="email" id="email" placeholder="Your Email">
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="phone" id="phone" placeholder="Phone">
                            </div>
                            <div class="col-md-4">
                                <input type="text" class="dates" id="checkin" placeholder="Check In Date">
                            </div>
                            <div class="col-md-4">
                                <input type="text" class="dates" id="checkout" placeholder="Check Out Date">
                            </div>
                            <div class="col-md-4">
                                <input type="text" style="background-color: transparent;" name="room" disabled="disabled" id="room" placeholder="Room">
                            </div>
                            <div id="done" class="col-md-12">
                                <textarea id="details" style="margin-bottom: 10px!important" cols="10" rows="8" name="message" class="form-control" placeholder="Any Messages?"></textarea>
                                <div id="success" class="col-md-12" style="background-color: lightgreen; display: none; cursor: pointer; text-align: center; color: black; margin-bottom: 10px; padding: 5px;">
                                    Success!
                                </div>
                                <p id="btnsubmit" style="text-align: center">
                                    <input type="submit" id="send" onclick="return false" style="margin: auto" value="Book" class="btn btn-custom">
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
                <div id="sidebar" class="col-md-4" style="text-align: center">
                    <div class="widget widget-text">
                        <h3>Our Address</h3>
                        <div class="map-small">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3402.5670733750744!2d74.30119921515589!3d31.481093281382698!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391903f08ebc7e8b%3A0x47e934f4cd34790!2sFAST+NUCES+Lahore!5e0!3m2!1sen!2sus!4v1475086663746" frameborder="0" style="border: 0; width: 90%;" allowfullscreen></iframe>
                        </div>
                        <address>
                            <label>FAST NUCES Lahore</label>
                            <span>FAST NUCES Lahore</span>
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

