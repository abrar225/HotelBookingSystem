var temp;
var temp1 = true;
var logged = false;
var table;
var table2;
var start = 1;
var end = 6;
var count = 0;
var email;
var he;
var status1, type1;
var rfrom, rto;
var prid;
var shown = false;
var admin = false;
function readjust() {
    if ($("#sizeof").length && $("#sizefrom").length) {
        var sfrm = $("#sizefrom").html().toString();
        if (sfrm == 'window')
            sfrm = window;
        var wid = $("#sizeof").html();
        var widt = parseInt(wid);
        var tom = Math.round($(sfrm).width() / (widt + (($(sfrm).width() / widt))));
        if (tom == 0)
            tom = 1;
        var tom1 = $(sfrm).width() / tom;
        var final = tom1;
        $(".custom").stop();
        $(".custom img").stop();
        $("#slider .temp").stop();
        $(".custom").animate({
            width: final
        }, 400);
        $(".custom img").animate({
            height: final - 40
        }, 400);
        $("#slider .temp").animate({
            height: final,
            left: 0
        }, 400);
    }
}
Number.prototype.roundTo = function (nTo) {
    nTo = nTo || 10;
    return Math.round(this * (1 / nTo)) * nTo;
}
$(function () {
    var slides = $('#slider .temp').children().length;
    var slideWidth = $('#slider .custom').width() + 30;
    var min = 0;
    var tom = Math.round($(window).width() / ($("#slider .custom").width() + 30));
    if (tom == 0)
        tom = 1;
    var max = -((slides - tom - 1) * slideWidth);
    var perc = (slides * (slideWidth + 30));
    var check = false;
    $("#slider .temp").css({
        width: perc
    });
    $("#slider .temp").draggable({
        axis: 'x',
        drag: function (event, ui) {
            $('html,body').css('cursor', 'all-scroll');
            slides = $('#slider .temp').children().length;
            slideWidth = $('#slider .custom').width() + 30;
            min = 0;
            tom = Math.round($(window).width() / ($("#slider .custom").width() + 30));
            if (tom == 0)
                tom = 1;
            max = -((slides - tom - 1) * slideWidth);
            if (ui.position.left > min) {
                check = true;
            }
            if (ui.position.left < max) {
                ui.position.left += Math.abs(Math.abs(max) - Math.abs(ui.position.left)) * .8;
            }
            if (check)
                ui.position.left *= .15;
        },
        stop: function (event, ui) {
            check = false;
            if (ui.position.left > min) {
                ui.position.left = min;
            }
            if (ui.position.left < max) {
                ui.position.left = max;
            }
            if (slides <= 4)
                ui.position.left = min;
            $('html,body').css('cursor', 'default');
            $(this).animate({ 'left': (ui.position.left).roundTo(slideWidth) })
        }
    });
});
function autosize() {
    if ($("#sizeof").length && $("#sizefrom").length) {
        var sfrm = $("#sizefrom").html().toString();
        if (sfrm == 'window')
            sfrm = window;
        var wid = $("#sizeof").html();
        var widt = parseInt(wid);
        var tom = Math.round($(sfrm).width() / (widt + (($(sfrm).width() / widt))));
        if (tom == 0)
            tom = 1;
        var tom1 = $(sfrm).width() / tom;
        var final = tom1;
        he = final;
        $(".custom").animate({
            width: final
        }, 400);
        $(".custom img").animate({
            height: final - 40
        }, 400);
        $(".custom img").attr('min-height', final - 40);
        $("#slider .temp").animate({
            height: final,
            left: 0
        }, 400);
    }
}
function register(fname, lname, uname, email, pass, dob, cellno, type, status, picture, accid) {
    var domain = document.domain;
    $.ajax({
        type: "POST",
        url: "Register.aspx/register",
        data: JSON.stringify({ firstname: fname, lastname: lname, username: uname, email: email, pass: pass, dob: dob, cellno: cellno, type: type, status: status, picture: picture, accid: accid, domain: domain }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (e) {
            if (e.d == 0 && accid == 0) {
                alert("Username Or Email Already Exist");
                return;
            }
            alert("Success");
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
}
function register1(fname, lname, uname, email, pass, dob, cellno, status, picture, accid) {
    var domain = document.domain;
    $.ajax({
        type: "POST",
        url: "Register.aspx/register",
        data: JSON.stringify({ firstname: fname, lastname: lname, username: uname, email: email, pass: pass, dob: dob, cellno: cellno, type: "User", status: status, picture: picture, accid: accid, domain: domain }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (e) {
            loginuser(uname, '1234');
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
}
function accountcheck() {
    $.ajax({
        type: "POST",
        url: "Home.aspx/getsessionid",
        data: JSON.stringify({}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (e) {
            var id = parseInt(e.d);
            prid = id;
            if (id == -1) {
                loadrooms();
                $("#uploaddiv").remove();
                $(".admin").hide();
                admin = false;
                $(".user").show();
                $("#loginb").attr('src', "img/pic.jpg");
                $("#fname").val("");
                $("#name").val("");
                $("#lname").val("");
                $("#uname").val("");
                $("#email").val("");
                $("#dob").val("");
                $("#cno").val("");
                $("#myUploadedImg").attr("src", "img/pic.jpg");
                return;
            }
            $.ajax({
                type: "POST",
                url: "Home.aspx/getaccounts",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (response) {
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    var customer = customers.first();
                    if (customer.find("status").text() == "1") {
                        logged = true;
                        $("#Email").val("");
                        $("#Pass").val("");
                        $("#fname").val(customer.find("firstname").text());
                        $("#lname").val(customer.find("lastname").text());
                        $("#uname").val(customer.find("username").text());
                        $("#email").val(customer.find("email").text());
                        $("#dob").val(customer.find("dob").text());
                        $("#cno").val(customer.find("cellno").text());
                        $("#name").val(customer.find("firstname").text() + " " + customer.find("lastname").text());
                        $("#phone").val(customer.find("cellno").text());
                        $("#myUploadedImg").attr("src", customer.find("picture").text());
                        if ($("#logindiv").is(":visible")) {
                            $("#logindiv").velocity({
                                scale: 0
                            }, 200);
                            shown = false;
                            $("#effect").hide();
                            $('html, body').css({
                                overflow: 'auto',
                                height: 'auto'
                            });
                        }
                        if (customer.find("type").text() == "Admin") {
                            admin = true;
                            var path = window.location.pathname;
                            var page = path.split("/").pop();
                            if (page == "Details.aspx")
                                setadmin();
                            $(".admin").show();
                            $(table).show();
                            $("img", table).css({
                                'height': he
                            });
                            $("#toapp").children().last().after(table);
                            table = $("#uploaddiv").clone(true);
                        }
                        else {
                            admin = false;
                            $(".user").show();
                        }
                        $("#loginb").attr('src', customer.find("picture").text());
                        $("#loginb").load(function () {
                            $("#hoverpic").width($("#loginb").width() + 10);
                        });
                        setTimeout(readjust, 200);
                    }
                },
                error: function (err) {
                    alert(err.responseText);
                }
            });
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
}
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
var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;
    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split(/=(.+)/);
        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};
jQuery.extend(jQuery.expr[':'], {
    invalid: function (elem, index, match) {
        var invalids = document.querySelectorAll(':invalid'),
            result = false,
            len = invalids.length;

        if (len) {
            for (var i = 0; i < len; i++) {
                if (elem === invalids[i]) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
});
jQuery.extend(jQuery.expr[':'], {
    focus: "a == document.activeElement"
});
$(document).on("click", "#Button2", function () {
    var price = $("#price").val();
    var descp = $("#TextArea1").val();
    var type = $("#room :selected").html();
    var rname = $("#rname").val();
    $.ajax({
        type: "POST",
        url: "Home.aspx/addroom",
        data: JSON.stringify({ price: price, descp: descp, type: type, name: rname }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (e) {
            var id = parseInt(e.d);
            if (id == -1) {
                alert("Nice Try.");
                return;
            }
            $("#specs ul li").each(function () {
                var features = $(this).html().toString();
                var ind = features.indexOf("<");
                var adjust = features.substring(0, ind);
                features = adjust;
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "Home.aspx/addfeatures",
                    data: JSON.stringify({ features: features, id: id }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () {

                    },
                    error: function (err) {
                        alert(err.responseText);
                    }
                });
            });
            $(".imgsup").each(function () {
                var pics = $(this).attr('src');
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "Home.aspx/addpics",
                    data: JSON.stringify({ pics: pics, id: id }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () {

                    },
                    error: function (err) {
                        alert(err.responseText);
                    }
                });
            });
            $("#f_UploadImage").val('');
            $("#name").val('');
            $("#price").val('');
            $("#name").val('');
            $("#features").val('');
            $("#TextArea1").val('');
            $(".imgsup").remove();
            $("#specs ul li").remove();
            $("#adddiv").velocity({
                scale: 0
            }, 200);
            $("#effect").fadeOut();
            loadrooms();
            loadhomerooms();
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
});
function loadrooms() {
    $.ajax({
        type: "POST",
        url: "Rooms.aspx/getrooms",
        data: JSON.stringify({
            status: status1, start: start, end: end, type: type1, checkin: rfrom, checkout: rto
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            if (response.d == "0") {
                alert("Nice Try.");
                return;
            }
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            if (table2 == null)
                table2 = $("#toapp #appr").eq(0).clone(true);
            $("#toapp #appr").remove();
            count = 0;
            customers.each(function () {
                var customer = $(this);
                count = parseInt(customer.find("count").text());
                $("#id", table2).val(customer.find("roomid").text());
                $("#ename", table2).html(customer.find("name").text());
                if (customer.find("descp").text().length > 270)
                    $("#desc", table2).html(customer.find("descp").text().substr(0, 270) + "...");
                else
                    $("#desc", table2).html(customer.find("descp").text());
                $("#priceappr", table2).html(customer.find("price").text());
                $("#img", table2).attr('src', customer.find("pic").text());
                $("#img", table2).css({ 'height': he });
                $(table2).show();
                $("#toapp #toappafter").after(table2);
                table2 = $("#toapp #appr").eq(0).clone(true);
                if (admin)
                    $(".admin").show();
                else
                    $(".admin").hide();
            });
            if (end >= count)
                $("#next").hide();
            else
                $("#next").show();
            if (start == 1)
                $("#prev").hide();
            else
                $("#prev").show();
            if (count == 0) {
                $("#rdates").fadeOut();
            }
            else {
                $("#navigatebuttons").show();
                $("#rdates").fadeIn();
            }
            setTimeout(readjust, 200);
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
}
function loginuser(username, pass) {
    $.ajax({
        type: "POST",
        url: "Home.aspx/loginto",
        data: JSON.stringify({ username: username, pass: pass }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (e) {
            var result = parseInt(e.d);
            if (result == 1)
                accountcheck();
            else if (isNaN(result)) {
                email = e.d.toString();
                if ($("#logindiv").is(":visible")) {
                    $("#logindiv").hide("slide", { direction: 'left' });
                    $("#Email").val("");
                    $("#Pass").val("");
                    $("#effect").hide();
                }
                $("#error").show();
                setTimeout(function () {
                    $("#error").velocity({
                        scale: 1
                    }, 200);
                }, 200);
            }
            else {
                alert("Invalid Username Or Password");
            }
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
}
function verifyemail() {
    var id = getUrlParameter("id");
    if (id != undefined) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/updateaccstatus",
            data: JSON.stringify({ id: id }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function () {
                $("#success").show();
                setTimeout(function () {
                    $("#success").velocity({
                        scale: 1
                    }, 200);
                }, 200);
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    }
}
$(document).ready(function () {
    verifyemail();
    $("#eclose").click(function () {
        $("#error").velocity({
            scale: 0
        }, 200);
        setTimeout(function () {
            $("#error").hide();
        }, 200);
    });
    $("#eclose").click(function () {
        $("#error").velocity({
            scale: 0
        }, 200);
        setTimeout(function () {
            $("#error").hide();
        }, 200);
    });
    $("#sclose").click(function () {
        $("#success").velocity({
            scale: 0
        }, 200);
        setTimeout(function () {
            $("#success").hide();
        }, 200);
    });
    accountcheck();
    $("#next").click(function () {
        start += 6;
        end += 6;
        loadrooms();
    });
    $("#prev").click(function () {
        start -= 6;
        end -= 6;
        loadrooms();
    });
    $(window).resize(function (e) {
        readjust();
    });
    $("#Submit1").click(function (e) {
        var firstname = $("#fname").val();
        var lastname = $("#lname").val();
        var username = $("#uname").val();
        var email = $("#email").val();
        var pass = $("#pass").val();
        var dob = $("#dob").val();
        var cellno = $("#cno").val();
        var type = "User";
        var status = 0;
        var picture = $("#myUploadedImg").attr("src");
        var accid = 0;
        if (firstname != '' && lastname != '' && username != '' && email != '' && pass != '' && dob != '' && cellno != '') {
            e.preventDefault();
            register(firstname, lastname, username, email, pass, dob, cellno, type, status, picture, accid);
        }
    });
    $("#Updateprofile").click(function (e) {
        var firstname = $("#fname").val();
        var lastname = $("#lname").val();
        var username = $("#uname").val();
        var email = $("#email").val();
        var pass = 0;
        var dob = $("#dob").val();
        var cellno = $("#cno").val();
        var type = "User";
        var status = 0;
        var picture = $("#myUploadedImg").attr("src");
        var accid = prid;
        if (firstname != '' && lastname != '' && username != '' && email != '' && dob != '' && cellno != '') {
            e.preventDefault();
            register(firstname, lastname, username, email, pass, dob, cellno, type, status, picture, accid);
        }
    });
    $("#updatepass").click(function (e) {
        e.preventDefault();
        var accid = prid;
        var pass = $("#Text2").val();
        $.ajax({
            type: "POST",
            url: "Home.aspx/updatepass",
            data: JSON.stringify({ id: accid, pass: pass }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function () {
                alert("Success");
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    });
    $("input").on("change keyup", function () {
        if ($(this).val() != '' && $(this).is(":invalid")) {
            $(this).css({
                'border-bottom-color': 'red'
            });
        }
        else if ($(this).val() != '' && !($(this).is(":invalid"))) {
            $(this).css({
                'border-bottom-color': 'green'
            });
        }
        else {
            if ($(this).is(":focus")) {
                $(this).css({
                    'border-bottom-color': '#00a1ff'
                });
            }
        }
    });
    $("input").focusout(function () {
        if ($(this).val() == '') {
            $(this).css({
                'border-bottom-color': 'red'
            });
            return;
        }
        if ($(this).is(":invalid")) {
            $(this).css({
                'border-bottom-color': 'red'
            });
        }
        else {
            $(this).css({
                'border-bottom-color': 'green'
            });
        }
    });
    $("input").focus(function () {
        if ($(this).val() == '') {
            $(this).css({
                'border-bottom-color': '#00a1ff'
            });
            return;
        }
        if ($(this).is(":invalid")) {
            $(this).css({
                'border-bottom-color': 'red'
            });
        }
        else {
            $(this).css({
                'border-bottom-color': 'green'
            });
        }
    });
    $("#features").focus(function () {
        $(this).css({
            'width': '80%',
            'float': 'left'
        });
        if ($("#Button3").is(":hidden")) {
            $("#Button3").velocity({
                scale: 0
            }, 0);
            if ($("#specs ul li").length > 0 && $("#specs").is(":hidden")) {
                $("#specs").show().velocity({
                    scale: 1
                }, 20);
            }
            setTimeout(function () {
                $("#Button3").show().velocity({
                    scale: 1.5
                }, 20).velocity({
                    scale: 1
                }, 50);
            }, 300);
        }

    });
    status1 = "approved";
    type1 = "*";
    var k = new Date();
    var date = k.getFullYear() + "-";
    if ((k.getMonth() + 1) < 10) {
        date += "0" + (k.getMonth() + 1) + "-";
    }
    else
        date += (k.getMonth() + 1) + "-";
    if (k.getDate() < 10)
        date += "0" + k.getDate();
    else
        date += k.getDate();
    rfrom = date;
    rto = date;
    $("#from").val(jQuery.datepicker.formatDate('mm/dd/yy', new Date(date)));
    $("#to").val(jQuery.datepicker.formatDate('mm/dd/yy', new Date(date)));
    $("#from").datepicker({
        minDate: jQuery.datepicker.formatDate('mm/dd/yy', new Date(date))
    });
    $("#to").datepicker({
        minDate: jQuery.datepicker.formatDate('mm/dd/yy', new Date(date))
    });
    $(".rdate").change(function () {
        var from = $("#from").val();
        var to = $("#to").val();
        var minDateArr = from.split('/')
        var minDate = new Date(minDateArr[2], minDateArr[0] - 1, minDateArr[1]);
        var minDateArr1 = to.split('/')
        var minDate1 = new Date(minDateArr1[2], minDateArr1[0] - 1, minDateArr1[1]);
        if (minDate > minDate1)
            $("#to").val(from);
        $("#to").datepicker("destroy");
        $("#to").datepicker({
            minDate: from
        });
        rfrom = from;
        rto = to;
        loadrooms();
    });
    loadrooms();
    $("input,textarea").focus(function (e) {
        if (e.target.id != 'features' && e.target.id != 'Button3') {
            $("#features").css({
                'width': '100%'
            });
            $("#specs").velocity({
                scale: 0
            }, 200);
            setTimeout(function () {
                $("#specs").hide();
            }, 500);
            $("#Button3").hide();
        }
    });
    $("#filters li a").click(function () {
        $("#filters li a").each(function () {
            $(this).removeClass("selected");
        });
        $(this).addClass("selected");
        var type = $(this).data("type");
        var status = $(this).data("status");
        if (type == undefined)
            return;
        type1 = type;
        status1 = status;
        loadrooms();
    });
    autosize();
    table = $("#uploaddiv").eq(0).clone(true);
    $("#uploaddiv").remove();
    $("#loginb").load(function () {
        $("#hoverpic").width($("#loginb").width() + 10);
    });
    $("#logout").click(function () {
        FB.logout(function (response) {
            // user is now logged out
        });
        $.ajax({
            type: "POST",
            url: "Home.aspx/clearsession",
            data: JSON.stringify({}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function () {
                if (location.pathname.split('/').slice(-1)[0].toLowerCase() == "profile.aspx")
                    window.location.replace("Home.aspx");
                logged = false;
                $(".loginfo").fadeOut();
                $(".login").velocity({
                    scale: 0
                }, 200);
                $("#effect").fadeOut(200);
                accountcheck();
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    });
    $("#resend").click(function () {
        var domain = document.domain;
        $.ajax({
            type: "POST",
            url: "Home.aspx/sendemail",
            data: JSON.stringify({ email: email, domain: domain }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (e) {

            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    });
    $("#hoverpic").click(function (e) {
        if (!logged) {
            $("#menu").slideUp();
            if (!shown) {
                $('html, body').animate({
                    scrollTop: 0
                }, 500);
                $("#logindiv").show().velocity({
                    scale: 1
                }, 200);
                $("#Email").focus();
                $('html, body').css({
                    overflow: 'hidden',
                    height: '100%'
                });
            }
            else {
                $("#logindiv").velocity({
                    scale: 0
                }, 200);
                $('html, body').css({
                    overflow: 'auto',
                    height: 'auto'
                });
            }
            $("#effect").fadeToggle();
            shown = !shown;
        }
        else {
            $(".loginfo").slideToggle();
        }
    });
    //$("#Email").keypress(function (e) {
    //    if (e.which == 13) {
    //        var username = $("#Email").val();
    //        var pass = $("#Pass").val();
    //        loginuser(username, pass);
    //    }
    //});
    //$("#Pass").keypress(function (e) {
    //    if (e.which == 13) {
    //        var username = $("#Email").val();
    //        var pass = $("#Pass").val();
    //        loginuser(username, pass);
    //    }
    //});
    $("#Button1").click(function () {
        var username = $("#Email").val();
        var pass = $("#Pass").val();
        loginuser(username, pass);
    });
    $(document).on("click", "#upload", function () {
        $("#menu").slideUp();
        $("#adddiv").velocity({
            scale: 1
        }, 200);
        $("#effect").fadeToggle();
        $('html, body').animate({
            scrollTop: 0
        }, 500);
    });
    $(".close").click(function () {
        $(this).parent().velocity({
            scale: 0
        }, 200);
        shown = false;
        $("#effect").fadeOut(200);
        $('html, body').css({
            overflow: 'auto',
            height: 'auto'
        });
    });
    $("#toTop").click(function () {
        $('html, body').animate({
            scrollTop: 0
        }, 500);
    });
    $(".icon-box").mouseenter(function () {
        if ($(this).find(".fa").is(":animated"))
            $(this).find(".fa").stop();
        $(this).find(".fa").animate({
            'color': '#edb83a',
            'background-color': 'lightyellow'
        }, 300);
    }).mouseleave(function () {
        if ($(this).find(".fa").is(":animated"))
            $(this).find(".fa").stop();
        $(this).find(".fa").animate({
            'color': '#fff',
            'background-color': '#404040;'
        }, 300);
    });
    temp = $(".mainmenu-area").offset().top;
    $("#menu").hide();
    $("#show").click(function () {
        $("#menu").slideToggle();
    });
    var check = false;
    $(".item").click(function () {
        check = true;
        $(this).find(".overlay").velocity("stop");
        $(this).find(".overlay").velocity({
            height: '100%',
        }, 700).find(".desc").css({
            opacity: 1,
            'margin-top': 20,
            height: '100%'
        });
    }).mouseleave(function () {
        if (check) {
            check = false;
            $(this).find(".overlay").velocity("stop");
            $(this).find(".overlay").velocity({
                height: '80',
            }, 700).find(".desc").css({
                opacity: 0,
                'margin-top': 0,
                height: 0
            });
        }
    });
});
$(document).click(function (e) {
    if (e.target.id.toString() != "showprofilre" && e.target.id.toString() != "logout" && e.target.id.toString() != "hoverpic") {
        $(".loginfo").slideUp();
    }
});
$(document).scroll(function () {
    if (Math.ceil($(document).scrollTop()) >= 100) {
        $("#toTop").fadeIn(200);
    }
    else {
        $("#toTop").fadeOut(200);
    }
    if (Math.ceil($(document).scrollTop()) >= temp + 50) {
        if (temp1) {
            $(".mainmenu-area").css({ position: 'fixed', top: -50 }).animate({
                top: '0'
            }, 300);
            $(".loginfo").css({ position: 'fixed' });
            temp1 = false;
        }
    }
    else {
        $(".mainmenu-area").css({ position: 'relative' });
        $(".loginfo").css({ position: 'absolute' });
        temp1 = true;
    }
});