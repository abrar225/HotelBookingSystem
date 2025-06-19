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
var checkfill = false;
function setadmin() {
    if (!admin) {
        $(".user").show();
        $(".admin").hide();
    }
    else {
        $(".user").hide();
        $(".admin").show();
    }
    if (admin && checkfill) {
        var texttemp = $("#descp1").html();
        $("#descp1").replaceWith("<textarea id=" + '"descp1"' + ">" + texttemp + " </textarea>");
        $("#descp1").css("overflow", "hidden");
        $("#descp1").css("background", "inherit");
        $("#descp1").css("height", $("#descp1").prop("scrollHeight"));
        $(".room-specs ul li").each(function () {
            $(this).replaceWith("<p><input id= " + '"' + this.id + '"' + " class=" + '"adminfeature"' + "type=" + '"text"' + " value=" + '"' + $(this).html() + '">' + "</input><span id=" + '"delete' + this.id + '" class="deletefeature"' + "></span></p>");
        });
        $(".deletefeature").click(function () {
            var fid = this.id.substr(6);
            var featuretemp = $(this);
            if (confirm("Are you sure you want to delete this feature?")) {
                $.ajax({
                    type: "POST",
                    url: "Details.aspx/deletefeature",
                    data: JSON.stringify({ fid: fid }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert("Successfully Deleted the feature");
                        $(featuretemp).parent().fadeOut();
                        $(featuretemp).parent().remove();
                    }
                });
            }
        });
        $(".adminfeature").keyup(function (e) {
            var fid = this.id.substr(7);
            var feature = $(this).val();
            if (e.keyCode == 13) {
                if (confirm("Are you sure you want to update this feature?")) {
                    $.ajax({
                        type: "POST",
                        url: "Details.aspx/updatefeature",
                        data: JSON.stringify({ fid: fid, feature: feature }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert("Feature Successfully Updated");
                        },
                        error: function (err) {
                            alert(err.responseText);
                        }
                    });
                }
            }
        });
        $("#descp1").focusin(function () {
            $("#updateroom").fadeIn(500);
        });
        $(document).click(function (event) {
            if (event.target.id != "descp1" && event.target.id != "updateroom")
                $("#updateroom").fadeOut(500);
            if (event.target.id != "updateprice" && event.target.id != "Text1")
                $(".updateprice").fadeOut(500);
        });
        $("#Text1").focusin(function () {
            $(".updateprice").fadeIn(500);
        });
    }
}
$(document).ready(function () {
    var id;
    id = parseInt(getUrlVars()['rid']);
    if (isNaN(id)) {
        window.location.href = "Rooms.aspx";
        return;
    }
    $(window).resize(function (e) {
        $(".imagehandler").each(function (e) {
            $(this).height($(this).width());
        });
    });
    $("#switch-1").change(function () {
        var check = $(this).prop('checked');
        var available = "approved";
        if (!check)
            available = "unapproved";
        $.ajax({
            type: "POST",
            url: "Details.aspx/updateavailiability",
            data: JSON.stringify({ available: available }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                alert("Successfully Updated the Availiability");
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    })
    $("#updateroom").click(function () {
        var descp = $("#descp1").val();
        $.ajax({
            type: "POST",
            url: "Details.aspx/updatedescription",
            data: JSON.stringify({ descp: descp }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                alert("Successfully Updated the Description");
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    });
    $("#updateprice").click(function () {
        var price = $("#Text1").val();
        $.ajax({
            type: "POST",
            url: "Details.aspx/updateprice",
            data: JSON.stringify({ price: price }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                alert("Successfully Updated the Price");
            }
        });
    });
    $("#deleteroom").click(function () {
        if (confirm("Are you sure you want to delete this room? You can't undo this action.")) {
            $.ajax({
                type: "POST",
                url: "Details.aspx/deleteroom",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert("Room successfully deleted");
                    window.location.href = "Rooms.aspx";
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        }
    });
    $(document).on("click", ".rooms", function (e) {
        if (e.target.id == "view") {
            var id1 = $(this).find("#id").val();
            window.location.href = "Details.aspx?rid=" + id1;
        }
    });
    var table;
    $.ajax({
        type: "POST",
        url: "Details.aspx/singleroom",
        data: JSON.stringify({ id: id }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            var customer = customers.first();
            $("#descp1").html(customer.find("descp").text());
            var appr = customer.find("status").text();
            if (appr == "unapproved")
                $("#switch-1").prop('checked', false);
            else
                $("#switch-1").prop('checked', true);
            checkfill = true;
            if (admin) {
                $("#descp1").replaceWith("<textarea id=" + '"descp1"' + ">" + customer.find("descp").text() + " </textarea>");
                $("#descp1").css("overflow", "hidden");
                $("#descp1").css("background", "inherit");
                $("#descp1").css("height", $("#descp1").prop("scrollHeight"));
                $("#descp1").focusin(function () {
                    $("#updateroom").fadeIn(500);
                });
                $(document).click(function (event) {
                    if (event.target.id != "descp1" && event.target.id != "updateroom")
                        $("#updateroom").fadeOut(500);
                    if (event.target.id != "updateprice" && event.target.id != "Text1")
                        $(".updateprice").fadeOut(500);
                });
                $("#Text1").focusin(function () {
                    $(".updateprice").fadeIn(500);
                });
            }
            $("#price").html(customer.find("price").text());
            $("#Text1").val(customer.find("price").text());
            if (!admin) {
                $(".user").show();
                $(".admin").hide();
            }
            else {
                $(".user").hide();
                $(".admin").show();
            }
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
    $.ajax({
        type: "POST",
        url: "Details.aspx/singlefeatures",
        data: JSON.stringify({ id: id }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            customers.each(function () {
                var customer = $(this);
                var feature = null;
                if (admin)
                    feature = "<p><input id = " + '"feature' + customer.find("featureid").text() + '"' + " class=" + '"adminfeature"' + "type=" + '"text"' + " value=" + '"' + customer.find("feature").text() + '">' + "</input><span id=" + '"delete' + customer.find("featureid").text() + '" class="deletefeature"' + "></span></p>";
                else
                    feature = "<li id = " + '"feature' + customer.find("featureid").text() + '"' +">" + customer.find("feature").text() + "</li>";
                $(".room-specs ul").append(feature);
            });
            $(".deletefeature").click(function () {
                var fid = this.id.substr(6);
                var featuretemp = $(this);
                if (confirm("Are you sure you want to delete this feature?")) {
                    $.ajax({
                        type: "POST",
                        url: "Details.aspx/deletefeature",
                        data: JSON.stringify({ fid: fid }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert("Successfully Deleted the feature");
                            $(featuretemp).parent().fadeOut();
                            $(featuretemp).parent().remove();
                        }
                    });
                }
            });
            $(".adminfeature").keyup(function (e) {
                var fid = this.id.substr(7);
                var feature = $(this).val();
                if (e.keyCode == 13) {
                    if (confirm("Are you sure you want to update this feature?")) {
                        $.ajax({
                            type: "POST",
                            url: "Details.aspx/updatefeature",
                            data: JSON.stringify({ fid: fid, feature: feature }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                alert("Feature Successfully Updated");
                            },
                            error: function (err) {
                                alert(err.responseText);
                            }
                        });
                    }
                }
            });
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
    $.ajax({
        type: "POST",
        url: "Details.aspx/adjacentrooms",
        data: JSON.stringify({ id: id }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            if (table == null)
                table = $("#adjacent #tocopy").eq(0).clone(true);
            $("#adjacent #tocopy").remove();
            customers.each(function () {
                var customer = $(this);
                $("#id", table).val(customer.find("roomid").text());
                $("#addescp", table).html(customer.find("descp").text());
                $("#adprice", table).html(customer.find("price").text());
                $("#ename", table).html(customer.find("name").text());
                $("#adpic", table).attr('src', customer.find("pic").text());
                $(table).show();
                $("#adjacent").append(table);
                table = $("#adjacent #tocopy").eq(0).clone(true);
            });
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
    $("#logout").click(function () {
        if (admin) {
            var texttemp = $("#descp1").val();
            $("#descp1").replaceWith("<p id=" + '"descp1"' + ">" + texttemp + " </p>");
            $("#updateroom").hide();
            $(".room-specs ul p").each(function () {
                $(this).replaceWith("<li id=" + '"feature' + $(this).find("input").prop('id') + '"' + ">" + $(this).find("input").val() + "</li>");
            });
        }
    })
    $.ajax({
        type: "POST",
        url: "Details.aspx/singlepics",
        data: JSON.stringify({ id: id }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            customers.each(function () {
                var customer = $(this);
                var img = "<img id=" + '"imagelarge' + customer.find("picid").text() + '"' + " class=" + '"mySlides"' + " src=" + customer.find("pic").text() + " style=" + '"width:100%;height:100%;"' + " />";
                var img1 = "<div class=" + '"w3-col s4 imagehandler"' + " style=" + '"margin-bottom:20px"' + ">" + "<img id =" + '"image' + customer.find("picid").text() + '"' + " class=" + '"demo w3-opacity w3-hover-opacity-off pichandle"' + " src=" + customer.find("pic").text() + ' style="width:100%; height:100%;"'  + " /><img id=" + '"picdel' + customer.find("picid").text() + '"' + " src=" + '"delete.png"' + "style=" + '"position:relative; float:right; width:20%; margin-top:-17%; z-index:1000; display:none"' + " class=" + '"hoverupload admin deletepicture"' + " /><input type=" + '"file"' + " name=" + '"file-5"' + " id=" + '"update' + customer.find("picid").text() + '"' + " class=" + '"inputfile imageupdate inputfile - 4"' + " /><label for=" + '"update' + customer.find("picid").text() + '"' + "><img src=" + '"upload.png"' + " style=" + '"position:relative; float:right; width:20%; margin-top:-17%; z-index:1000; display:none"' + " class=" + '"hoverupload admin"' + " /></label></div>";
                $("#slider #toappbef").before(img);
                $("#toappbef").append(img1);
            });
            $(".pichandle").each(function () {
                $(this).click(function () { currentDiv($(this).parent().index() + 1) });
            });
            $(".deletepicture").click(function () {
                var pictemp = $(this);
                if (confirm("Are you sure you want to delete this picture? You can't undo this action.")) {
                    var picid = this.id.substr(6);
                    var pic = $("#imagelarge" + picid).attr('src');
                    $.ajax({
                        type: "POST",
                        url: "Details.aspx/deletepicture",
                        data: JSON.stringify({ picid: picid, pic: pic }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert("Successfully Deleted the Picture");
                            $(pictemp).parent().fadeOut();
                            $(pictemp).parent().remove();
                            $("#imagelarge" + picid).remove();
                            currentDiv(1);
                        }
                    });
                }
            });
            $(".imageupdate").on("change", function () {
                var picid = this.id.substr(6);
                if (confirm('Are you sure you want to update the image?')) {
                    var file;
                    if ((file = this.files[0])) {
                        var temp = new String(file.type);
                        var ind = new Number(temp.indexOf("/"));
                        if (temp.substring(0, ind) == "image") {
                            sendFile(file, picid);
                        }
                    }
                } else {
                    $(this).val('');
                }
            });
            showDivs(slideIndex);
            $(".imagehandler").each(function (e) {
                $(this).height($(this).width());
            });
            if (!admin) {
                $(".user").show();
                $(".admin").hide();
            }
            else {
                $(".user").hide();
                $(".admin").show();
            }
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
});
function sendFile(file, id) {
    var formData = new FormData();
    formData.append('file', file);
    $.ajax({
        type: 'post',
        url: 'Handler1.ashx',
        data: formData,
        success: function (status) {
            if (status != 'error') {
                var my_path = "MediaUploader/" + status;
                var old = $("#image" + id).attr("src");
                $("#image" + id).attr("src", my_path);
                $("#imagelarge" + id).attr("src", my_path);
                $.ajax({
                    type: "POST",
                    url: "Details.aspx/updatepicture",
                    data: JSON.stringify({ pid: id, picture: my_path, old: old }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () {
                        alert("Successfully Updated");
                    },
                    error: function(err){
                        alert(err.responseText);
                    }
                });
            }
        },
        processData: false,
        contentType: false,
        error: function () {
            alert("Whoops something went wrong!");
        }
    });
}
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
    showDivs(slideIndex += n);
}

function currentDiv(n) {
    showDivs(slideIndex = n);
}

function showDivs(n) {
    var i;
    var x = $(".mySlides");
    var dots = document.getElementsByClassName("demo");
    if (n > x.length) { slideIndex = 1 }
    if (n < 1) { slideIndex = x.length }
    if (x.eq(slideIndex - 1).is(":visible"))
        return;
    for (i = 0; i < x.length; i++) {
        x.eq(i).hide();
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
    }
    x.eq(slideIndex - 1).show().velocity({
        scale: 1.03
    }, 500).velocity({
        scale: 1
    }, 500);
    dots[slideIndex - 1].className += " w3-opacity-off";
}