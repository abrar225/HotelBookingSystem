<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="WebApplication7.Aboutus" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8" />
    <meta name="description" content="Home - Hotel Booking System" />
    <meta name="keywords" content="Welcome To Hotel Booking System" />
    <meta name="author" content="Bilal" />
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
    <script src="velocity.js"></script>
    <script src="JavaScript.js"></script>
    <script src="java.js"></script>
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/component.css" />
    <script src="src/js/lightslider.js"></script>
    <link rel="stylesheet" href="src/css/lightslider.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        
    </style>
</head>
<body>
    <div id="effect" style="position: fixed; left: 0; right: 0; top: 0; bottom: 0; z-index: 102">
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
                        <li><a href="#">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container" style="padding-top: 30px">
        <div class="row">
            <div class="col-md-12" style="text-align: center">
                <h2>About Us
                </h2>
            </div>
        </div>
    </div>
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
