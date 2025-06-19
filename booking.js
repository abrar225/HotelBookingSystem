var id;
var obj;
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
function getrooms() {
    id = parseInt(getUrlVars()['rid']);
    if (isNaN(id)) {
        window.location.href = "Rooms.aspx";
        return false;
    }
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
            $("#room").val(customer.find("type").text());
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
    $.ajax({
        type: "POST",
        url: "Booking.aspx/adjustdate",
        data: JSON.stringify({ roomid: id }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            obj = [];
            customers.each(function () {
                var customer = $(this);
                var k = new Date(customer.find("checkin").text());
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
                var k1 = new Date(customer.find("checkout").text());
                var date1 = k1.getFullYear() + "-";
                if ((k1.getMonth() + 1) < 10) {
                    date1 += "0" + (k1.getMonth() + 1) + "-";
                }
                else
                    date1 += (k1.getMonth() + 1) + "-";
                if (k1.getDate() < 10)
                    date1 += "0" + k1.getDate();
                else
                    date1 += k1.getDate();
                obj[obj.length] = [date, date1];
            });
            var k1 = new Date();
            var date1 = parseInt(k1.getMonth() + 1).toString() + "/" + k1.getDate() + "/" + k1.getFullYear();
            $("#checkin, #checkout").datepicker({
                minDate: date1,
                showButtonPanel: true,
                beforeShowDay: function (date) {
                    var str = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    var minDateArr = $(this).datepicker("option", "minDate").split('/')

                    var minDate = new Date(minDateArr[2], minDateArr[0] - 1, minDateArr[1]);
                    for (var i = 0; i < obj.length; i++) {
                        if (str >= obj[i][0] && str <= obj[i][1])
                            return [false, 'special'];
                    }
                    if (date < minDate) {
                        return [false, 'not-special']
                    }
                    else {
                        return [true, "special"];
                    }
                }
            });
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
    return true;
}
function getsession() {
    $.ajax({
        type: "POST",
        url: "Home.aspx/getsessionid",
        data: JSON.stringify({}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (e) {
            var uid = parseInt(e.d);
            if (uid == -1) {
                $("#name").val("");
                $("#email").val("");
                $("#phone").val("");
                return;
            }
            $.ajax({
                type: "POST",
                url: "Home.aspx/getaccounts",
                data: JSON.stringify({ id: uid }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    var customer = customers.first();
                    $("#name").val(customer.find("firstname").text() + " " + customer.find("lastname").text());
                    $("#email").val(customer.find("email").text());
                    $("#phone").val(customer.find("cellno").text());
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
$(document).ready(function () {
    $(".dates").change(function () {
        var checkin = $("#checkin").val();
        if (checkin == undefined)
            return;
        var checkout = $("#checkout").val();
        if (checkout != undefined && checkout != '') {
            var minDateArr = checkin.split('/')
            var minDate = new Date(minDateArr[2], minDateArr[0] - 1, minDateArr[1]);
            var minDateArr1 = checkout.split('/')
            var minDate1 = new Date(minDateArr1[2], minDateArr1[0] - 1, minDateArr1[1]);
            if (minDate > minDate1)
                $("#checkout").val(checkin);
        }
        var arr = checkin.split('/');
        var tdate = new Date(arr[2], arr[0] - 1, arr[1]);
        var fdate = jQuery.datepicker.formatDate('yy-mm-dd', tdate);
        var mxdate;
        for (var i = obj.length - 1; i >= 0; i--) {
            if (fdate < obj[i][0])
                mxdate = obj[i][0];
        }
        $("#checkout").datepicker("destroy");
        if (mxdate == undefined) {
            $("#checkout").datepicker({
                minDate: checkin,
                showButtonPanel: true,
                beforeShowDay: function (date) {
                    var str = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    var minDateArr = $(this).datepicker("option", "minDate").split('/')

                    var minDate = new Date(minDateArr[2], minDateArr[0] - 1, minDateArr[1]);
                    for (var i = 0; i < obj.length; i++) {
                        if (str >= obj[i][0] && str <= obj[i][1])
                            return [false, 'special'];
                    }
                    if (date < minDate) {
                        return [false, 'not-special']
                    }
                    else {
                        return [true, "special"];
                    }
                }
            });
        }
        else {
            mxdate = jQuery.datepicker.formatDate('mm/dd/yy', new Date(mxdate));
            $("#checkout").datepicker({
                minDate: checkin,
                maxDate: mxdate,
                showButtonPanel: true,
                beforeShowDay: function (date) {
                    var str = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    var minDateArr = $(this).datepicker("option", "minDate").split('/')

                    var minDate = new Date(minDateArr[2], minDateArr[0] - 1, minDateArr[1]);
                    for (var i = 0; i < obj.length; i++) {
                        if (str >= obj[i][0] && str <= obj[i][1])
                            return [false, 'special'];
                    }
                    if (date < minDate) {
                        return [false, 'not-special']
                    }
                    else {
                        return [true, "special"];
                    }
                }
            });
        }
    });
    getrooms();
    getsession();
    $("#send").click(function () {
        var name = $("#name").val();
        var email = $("#email").val();
        var checkin = $("#checkin").val();
        var checkout = $("#checkout").val();
        var phone = $("#phone").val();
        if (phone == undefined)
            phone = "";
        var comment = $("#details").val();
        $.ajax({
            type: "POST",
            url: "Booking.aspx/bookaroom",
            data: JSON.stringify({ name: name, email: email, phone: phone, checkin: checkin, checkout: checkout, comment: comment, roomid: id }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (e) {
                $("#success").slideDown();
                $("#send").velocity({
                    scale: 0
                }, 200);
                setTimeout(function () {
                    $("#send").remove();
                }, 200);
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    });
    $("#success").click(function () {
        window.location.href = "Home.aspx";
    });
    $("#logout").click(function () {
        setTimeout(getsession, 50);
    });
    $("#Button1").click(function () {
        setTimeout(getsession, 50);
    });
});