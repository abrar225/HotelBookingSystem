<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication7.Register" %>

<!DOCTYPE html>

<html>
<head>
    <title>Register</title>
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
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3.css">
    <link rel="stylesheet" href="css/style.css">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
    <script src="https://code.jquery.com/ui/1.8.21/jquery-ui.min.js"></script>
    <script src="JavaScript.js"></script>
    <script src="java.js"></script>
    <meta name="description" content="Create Account At Hotel Booking System" />
    <meta name="keywords" content="Enter Credentials, Username, Upload Picture" />
    <meta name="author" content="Bilal" />
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/component.css" />
    <link href="style.css" rel="stylesheet" />
    <script src="velocity.js"></script>
    <script type="text/javascript">
        function sendFile(file) {
            var formData = new FormData();
            formData.append('file', $('#f_UploadImage')[0].files[0]);
            $.ajax({
                type: 'post',
                url: 'Handler1.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error') {
                        var my_path = "MediaUploader/" + status;
                        $("#myUploadedImg").attr("src", my_path).velocity({
                            scale: 0
                        }, 0);
                        setTimeout(function () {
                            $("#myUploadedImg").show().velocity({
                                scale: 1
                            }, 250);
                        }, 300);
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    alert("Whoops something went wrong!");
                }
            });
        }
        $(document).ready(function () {
            var _URL = window.URL || window.webkitURL;
            $("#f_UploadImage").on('change', function () {
                var file, img;
                if ((file = this.files[0])) {
                    img = new Image();
                    img.onload = function () {
                        sendFile(file);
                    };
                    img.onerror = function () {
                        alert("Not a valid file:" + file.type);
                    };
                    img.src = _URL.createObjectURL(file);
                }
            });
            $("#fileUpload").on('change', function () {
                //Get count of selected files
                var countFiles = $(this)[0].files.length;
                var imgPath = $(this)[0].value;
                var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
                var image_holder = $("#image-holder");
                image_holder.empty();
                if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
                    if (typeof (FileReader) != "undefined") {
                        //loop for each file selected for uploaded.
                        for (var i = 0; i < countFiles; i++) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                $("<img />", {
                                    "src": e.target.result,
                                    "class": "thumb-image"
                                }).appendTo(image_holder);
                            }
                            image_holder.show();
                            reader.readAsDataURL($(this)[0].files[i]);
                        }
                    } else {
                        alert("This browser does not support FileReader.");
                    }
                } else {
                    alert("Pls select only images");
                }
            });
        });
    </script>
    <style>
        .thumb-image {
            float: left;
            width: 100px;
            position: relative;
            padding: 5px;
        }

        input[type=file] {
            display: none;
        }

        .inputfile-4 + label {
            color: black;
        }

        a {
            outline: none;
            color: #d3394c;
            text-decoration: none;
        }

        .inputfile + label {
            max-width: 80%;
            font-size: initial;
            font-weight: 700;
            text-overflow: ellipsis;
            white-space: nowrap;
            cursor: pointer;
            display: inline-block;
            overflow: hidden;
            padding: 0.625rem 1.25rem;
        }

        .inputfile-4 + label figure {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: black;
            display: block;
            padding: 11px;
            margin: 0 auto 10px;
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
                        <li><a href="Booking.aspx">Booking</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="menu-bottom">
        <h1>Register</h1>
        <h3></h3>
    </div>
    <div class="container">
        <div class="col-md-12" style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
            <h2>User Information
            </h2>
        </div>
        <div class="row" style="margin-bottom: 20px;">
            <div class="col-md-6">
                <input id="fname" required="required" placeholder="First Name" style="margin-left: 20%; width: 60%" type="text" />
            </div>
            <div class="col-md-6">
                <input id="lname" required="required" placeholder="Last Name" style="margin-left: 20%; width: 60%" type="text" />
            </div>
        </div>
        <div class="row" style="margin-bottom: 20px;">
            <div class="col-md-6">
                <input id="uname" required="required" placeholder="Username" style="margin-left: 20%; width: 60%" type="text" />
            </div>
            <div class="col-md-6">
                <input id="email" required="required" placeholder="Email" style="margin-left: 20%; width: 60%" type="email" />
            </div>
        </div>
        <div class="row" style="margin-bottom: 20px;">
            <div class="col-md-6">
                <input id="dob" required="required" onfocus="(this.type='date')" onfocusout="(this.type='text')" placeholder="Date Of Birth" style="margin-left: 20%; width: 60%" type="text" min="1950-01-01" max="2200-12-31" />
            </div>
            <div class="col-md-6">
                <input id="cno" required="required" placeholder="Phone No" style="margin-left: 20%; width: 60%" type="text" />
            </div>
        </div>
        <div class="row" style="margin-bottom: 20px;">
            <div class="col-md-6">
                <input id="pass" required="required" placeholder="Password" style="margin-left: 20%; width: 60%" type="password" />
            </div>
            <div class="col-md-6">
                <input id="cpass" required="required" placeholder="Confirm Password" style="margin-left: 20%; width: 60%" type="password" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-6" style="text-align: center">
                <input type="file" name="file-5[]" id="f_UploadImage" class="inputfile inputfile-4" />
                <label for="f_UploadImage">
                    <figure>
                        <svg xmlns="https://www.w3.org/2000/svg" width="20" height="17" viewbox="0 0 20 17">
                                <path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z" />
                            </svg>
                    </figure>
                    <span>Choose a file&hellip;</span></label>
            </div>
            <div class="col-md-6" style="margin-bottom: 30px; text-align: center">
                <img src="#" style="width: 100px; height: 100px; display: none; transform: scale(0)" id="myUploadedImg" alt="Photo" />
            </div>
        </div>
        <div class="col-md-12" style="text-align: center">
            <input id="Submit1" style="margin: auto" type="submit" value="Register" />
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
    <script src="js/custom-file-input.js"></script>
</body>
</html>
