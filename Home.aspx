<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication7.Home" %>

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
    <style>
        .checked {
            color: orange;
        }

        .checked1 {
            color: orange;
        }

        #rate .fa {
            cursor: pointer;
        }

        @media only screen and (max-width: 500px) {
            .past {
                font-size: small !important;
                font-weight: bold;
            }
        }
    </style>


    <script>
        $(document).ready(function () {
            $("#content-slider").lightSlider({
                loop: true,
                keyPress: true
            });
            $('#image-gallery').lightSlider({
                gallery: true,
                item: 1,
                thumbItem: 9,
                slideMargin: 0,
                speed: 500,
                auto: true,
                loop: true,
                onSliderLoad: function () {
                    $('#image-gallery').removeClass('cS-hidden');
                }
            });
        });
    </script>
    <script type="text/javascript">
        var stars = $(".checked").length;
        var table4;
        function loadhomerooms() {
            $.ajax({
                type: "POST",
                url: "Home.aspx/gethomerooms",
                data: JSON.stringify({}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    if (table4 == null)
                        table4 = $("#toapp #homerooms").eq(0).clone(true);
                    $("#toapp #homerooms").remove();
                    $("#toapp").width((parseInt(customers.length) + 2) * 400);
                    customers.each(function () {
                        var customer = $(this);
                        $("#ename", table4).html(customer.find("name").text());
                        $("#id", table4).val(customer.find("roomid").text());
                        if (customer.find("descp").text().length > 270)
                            $("#descp", table4).html(customer.find("descp").text().substr(0, 270) + "...");
                        else
                            $("#descp", table4).html(customer.find("descp").text());
                        $("#sprice", table4).html(customer.find("price").text());
                        $("#rpic", table4).attr('src', customer.find("pic").text());
                        $(table4).show();
                        $("#toapp #toappafter").before(table4);
                        table4 = $("#toapp #homerooms").eq(0).clone(true);
                    });
                    setTimeout(readjust, 200);
                },
                error: function (err) {
                    alert(err.responseText);
                }
            });
        }
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
        var reviewtable = null;
        $.date = function (orginaldate) {
            var date = new Date(orginaldate);
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (day < 10) {
                day = "0" + day;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var date = month + "/" + day + "/" + year;
            return date;
        };
        function loadreviews() {
            $.ajax({
                type: "POST",
                url: "Home.aspx/getreviews",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    if (reviewtable == null)
                        reviewtable = $(".reviews .singlereview").eq(0).clone(true);
                    $(".reviews .singlereview").remove();
                    customers.each(function () {
                        var customer = $(this);
                        $(".reviewimage", reviewtable).attr('src', customer.find("picture").text());
                        $(".reviewname", reviewtable).val(customer.find("name").text());
                        $(".reviewid", reviewtable).val(customer.find("rid").text());
                        $(".reviewcomment", reviewtable).html(customer.find("comment").text());
                        $(".userrating span", reviewtable).removeClass("checked1");
                        for (var i = 0; i <= customer.find("rating").text(); i++) {
                            $(".userrating span", reviewtable).eq(i).addClass("checked1");
                        }
                        $(".reviewtime", reviewtable).html($.date(new Date(customer.find("reviewtime").text())));
                        $(reviewtable).show();
                        $(".reviews #appendafter").after(reviewtable);
                        reviewtable = $(".reviews .singlereview").eq(0).clone(true);
                    });
                    averagerating();
                }
            });
        }
        function averagerating() {
            $.ajax({
                type: "POST",
                url: "Home.aspx/averagerating",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var arate = response.d;
                    $(".averagerating span").removeClass("checked1");
                    for (var i = 0; i <= arate; i++) {
                        $(".averagerating span").eq(i + 1).addClass("checked1");
                    }
                },
                error: function (err) {
                    alert(err.responseText);
                }
            });
        }
        $(document).ready(function () {
            $(".singlereview").click(function (e) {
                var rid = $(this).find(".reviewid").val();
                var clickclass = $(e.target).attr('class').substr(6);
                if (clickclass == "deletereview") {
                    if (confirm("Are you sure you want to delete this review? You can't undo this action")) {
                        $.ajax({
                            type: "POST",
                            url: "Home.aspx/deletereview",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ rid: rid }),
                            dataType: "json",
                            success: function (response) {
                                alert("Review Successfully Deleted.");
                                loadreviews();
                            },
                            error: function (err) {
                                alert(err.responseText);
                            }
                        });
                    }
                }
            });
            loadreviews();
            $("#rate .fa").click(function () {
                var curr = $(this).index();
                $("#rate .fa").removeClass("checked");
                $("#rate .fa").each(function () {
                    if ($(this).index() <= curr)
                        $(this).addClass("checked");
                });
                stars = curr;
            });
            $("#rate .fa").mouseenter(function () {
                var curr = $(this).index();
                $("#rate .fa").removeClass("checked");
                $("#rate .fa").each(function () {
                    if ($(this).index() <= curr)
                        $(this).addClass("checked");
                });
            }).mouseleave(function () {
                $("#rate .fa").removeClass("checked");
                $("#rate .fa").each(function () {
                    if ($(this).index() <= stars)
                        $(this).addClass("checked");
                });
            });
            $("#addreview").click(function () {
                var name = $("#name").val();
                var email = $("#email").val();
                var cno = $("#cno").val();
                var email = $("#email").val();
                var comment = $("#comment").val();
                var rating = stars;
                $.ajax({
                    type: "POST",
                    url: "Home.aspx/addreview",
                    data: JSON.stringify({
                        name: name, email: email, cno: cno, comment: comment, rating: rating
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == 0) {
                            alert("You've already submitted the Review")
                            return;
                        }
                        loadreviews();
                    },
                    error: function (err) {
                        alert(err.responseText);
                    }
                });
            });
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
            $(document).on("click", ".custom", function (e) {
                if (e.target.id == "view") {
                    var id = $(this).find("#id").val();
                    window.location.href = "Details.aspx?rid=" + id;
                }
            });
            loadhomerooms();
            $("#specs").velocity({
                scale: 0
            });
            $("#Button3").click(function () {
                var txt = $("#features").val();
                if (txt == '')
                    return;
                $("#features").val('');
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
    <div id="success" style="display: none; width: 100%; transform: scale(0); padding: 5px; text-align: center; color: white; background: green;">
        <a id="sclose" href="#" onclick="return false" style="color: white; font-size: 10px; opacity: 1" class="close">&#x2715;</a>
        Success! Thanks For Confirming Your Email.
    </div>
    <div id="error" style="display: none; width: 100%; transform: scale(0); padding: 5px; text-align: center; color: white; background: red;">
        <a id="eclose" href="#" onclick="return false" style="color: white; font-size: 10px; opacity: 1" class="close">&#x2715;</a>
        Your Email Hasn't Been Confirmed Yet. Please Confirm Your Email To use Your Account.
            <a id="resend" href="#" onclick="return false" style="color: white;">Didn't get the Email? Click Here!</a>
    </div>
    <label id="sizeof" hidden="hidden" style="display: none">400</label>
    <label id="sizefrom" hidden="hidden" style="display: none">window</label>
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
                <ul style="overflow: auto">
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
                        <li><a href="#">Home</a></li>
                        <li><a href="Rooms.aspx">Rooms</a></li>
                        <li><a href="Booking.aspx">Booking</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="carousel-example-generic" style="background-color: black; border-top: solid 1px #292929;" class="carousel slide carousel-fade carousel-animate carousel-bg" data-ride="carousel">
        <!-- Indicators -->
        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item active" style="background-image: url(/1.jpg)">
                <div style="position: absolute; width: 100%; height: 100%; background-color: black; opacity: .5; z-index: 100">
                </div>
                <div class="carousel-caption" style="opacity: 1; z-index: 101">
                    <div class="hero">
                        <hgroup class="zoomInDown animated">
                            <h3 class="fadeInLeft animated"><span style="color: #edb83a">Welcome</span> To Hotel <span style="color: #edb83a">Booking</span> System</h3>
                            <h5 class="slideInRight animated">Select <span style="color: #edb83a">Book</span> Enjoy!</h5>
                        </hgroup>
                    </div>
                </div>
            </div>
            <div class="item" style="background-image: url(/2.jpg);">
                <div style="position: absolute; width: 100%; height: 100%; background-color: black; opacity: .5; z-index: 100">
                </div>
                <div class="carousel-caption" style="opacity: 1; z-index: 101">
                    <div class="hero fadeInUp animated">
                        <hgroup>
                            <h3>Various <span style="color: #edb83a">Room</span> Types</h3>
                            <h5>We've Got Your <span style="color: #edb83a">Taste</span> Covered</h5>
                        </hgroup>
                    </div>
                </div>
            </div>
            <div class="item" style="background-image: url(/3.jpeg);">
                <div style="position: absolute; width: 100%; height: 100%; background-color: black; opacity: .5; z-index: 100">
                </div>
                <div class="carousel-caption" style="opacity: 1; z-index: 101">
                    <div class="hero rollIn animated">
                        <hgroup class="rotateInDownRight animated">
                            <h3><span style="color: #edb83a">Elegant</span> Open <span style="color: #edb83a">Enviroment</span></h3>
                            <h5>Nothing <span style="color: #edb83a">Beats</span> Nature!</h5>
                        </hgroup>
                    </div>
                </div>
            </div>
        </div>
        <!-- Controls -->
        <a class="left carousel-control" style="z-index: 101" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" style="z-index: 101" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <form runat="server">
        <div id="slider" style="padding: 15px; overflow: hidden">
            <div id="toapp" class="row temp content-slider" style="height: 450px!important; width: auto">
                <div id="homerooms" class="custom" style="margin-bottom: 20px; display: none">
                    <input id="id" type="hidden" />
                    <div class="room-item item">
                        <div class="overlay" style="overflow: hidden; height: 80px; margin-top: 20px;">
                            <a href="#" onclick="return false">
                                <h1 id="ename" style="white-space: nowrap; overflow: hidden; font-weight: bold!important">Luxury Room</h1>
                            </a>
                            <div class="desc" style="opacity: 0; overflow: hidden; height: 0; margin-top: 0;">
                                <label id="descp" style="font-weight: normal!important; overflow: hidden; max-height: 50%"></label>
                                <div class="price">
                                    <label id="sprice" style="font-weight: inherit!important; font-size: inherit!important"></label>
                                    <span style="font-weight: inherit!important; font-size: inherit!important">/night</span>
                                </div>
                                <a id="view" href="#" onclick="return false" class="btn-border">View Details</a>
                            </div>
                        </div>
                        <img id="rpic" src="/img/pic.jpg" alt="">
                    </div>
                </div>
                <div id="toappafter"></div>
                <div id="uploaddiv" class="custom" style="margin-bottom: 20px; display: none">
                    <div class="room-item item">
                        <img id="upload" style="cursor: pointer" src="/img/upload.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </form>
    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-6 ">
                    <div class="icon-box">
                        <i class="fa fa-bell-o"></i>
                        <div class="text">
                            <h3>Room Services</h3>
                            We care for our customers
                        </div>
                    </div>
                </div>

                <div class="col-md-6 ">
                    <div class="icon-box">
                        <i class="fa fa-coffee"></i>
                        <div class="text">
                            <h3>Free Coffee</h3>
                            Getting Sleepy? No Problem!
                        </div>
                    </div>
                </div>

                <div class="col-md-6 ">
                    <div class="icon-box">
                        <i class="fa fa-car"></i>
                        <div class="text">
                            <h3>Free Parking</h3>
                            Longer Stay made Easy!
                        </div>
                    </div>
                </div>

                <div class="col-md-6 ">
                    <div class="icon-box">
                        <i class="fa fa-dropbox"></i>
                        <div class="text">
                            <h3>Deposit Box</h3>
                            We value your opinion.
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <div class="container" style="padding-top: 30px">
        <div class="row">
            <div class="col-md-12" style="padding-bottom: 20px; border-top: 1px solid rgb(221, 221, 221);">
                <h2 style="text-align: center">Review
                </h2>
                <div class="col-md-8" style="text-align: center; padding-top: 50px;">
                    <h3 style="padding-bottom: 10px">Add a Review
                    </h3>
                    <form>
                        <div class="col-md-12" style="text-align: center; font-size: 15px">
                            <input id="name" type="text" placeholder="Name" />
                            <input id="email" type="email" placeholder="Email" />
                            <input id="cno" type="tel" placeholder="Phone Number" />
                            <textarea id="comment" placeholder="Comment"></textarea>
                            <div id="rate" style="padding-bottom: 15px">
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star"></span>
                                <span class="fa fa-star"></span>
                                <span class="fa fa-star"></span>
                                <span class="fa fa-star"></span>
                            </div>
                            <div>
                                <input type="submit" id="addreview" onclick="return false" style="margin: auto" value="Submit" class="btn btn-custom">
                            </div>
                        </div>
                    </form>
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
                <div class="col-md-12" style="padding-left: 20px; padding-right: 20px; border-top: 1px solid rgb(221, 221, 221); padding-top: 20px">
                    <span class="past" style="font-size: x-large; font-weight: bold">Past Reviews</span>
                    <div style="padding-bottom: 15px; float: right" class="averagerating">
                        <span>Average Rating: </span>
                        <span class="fa fa-star checked1"></span>
                        <span class="fa fa-star"></span>
                        <span class="fa fa-star"></span>
                        <span class="fa fa-star"></span>
                        <span class="fa fa-star"></span>
                    </div>
                    <div class="col-md-12 reviews" style="padding-top: 10px">
                        <div id="appendafter"></div>
                        <div class="singlereview" style="display: none; padding-bottom: 20px">
                            <input class="reviewid" type="hidden" />
                            <a href="#" onclick="return false" style="text-decoration: none; float: right; margin-top: -8px; font-size: large" class="admin deletereview">&#x2715;</a>
                            <img class="reviewimage" src="1.jpg" width="50" height="50" style="border-radius: 50px; float: left" />
                            <div style="padding-top: 7px; padding-left: 60px">
                                <span class="past reviewname" style="font-size: larger; font-weight: bold;">Muhammad Bilal</span>
                                <div class="userrating" style="float: right">
                                    <span class="fa fa-star checked1"></span>
                                    <span class="fa fa-star"></span>
                                    <span class="fa fa-star"></span>
                                    <span class="fa fa-star"></span>
                                    <span class="fa fa-star"></span>
                                    <div class="reviewtime" style="text-align: center">
                                        Today
                                    </div>
                                </div>
                            </div>
                            <div style="margin-left: 61px">
                                <span class="reviewcomment" style="font-size: small; width: 100%; text-overflow: clip; word-wrap: break-word">daoisdsadhsadhsaohdusahduisahdsaojdpsad psaud oisahdoisa oidh as oidhsaoih dsaoihf sudihf sudihf sduihf sudifh sudihf usdi hfuishf iusd hfhusdih fisudh usdih fisudhasdsadsadsadsadsaijdsaoidvasoidbsuavidhasvuiashdvuisahvdiusahbvdiusadvhbasiuvhbdiuasuhdviusabhdviasuhbvasuibdhiashs</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a href="#" onclick="return false" id="toTop" style="display: none;"><span id="toTopHover" style="opacity: .7;"></span>To Top</a>
    <div class="footer-before">
        <div class="first">
            <div class="foottext">
                The Hotel is the right choice for visitors who are searching for a combination of charm, peace and quiet, and a convenient position from which to explore Lahore. It is a small, comfortable hotel, situated in Lahore. The hotel is arranged on three floors, with a lift. On the ground floor, apart from the reception, there is a comfortable lounge where you can sit and drink tea, or just read.
            </div>
        </div>
        <div class="second">
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
