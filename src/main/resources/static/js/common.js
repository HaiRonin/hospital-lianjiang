var baseUrl = "http://weixin.ljfy.com.cn:8099/wechat.asm"

var imgNum = 0;
var lastModified = 0;
var imgArr = new Array();
var lastModifiedArr = new Array();
var initImg = new Array();
function initMenu() {
    /* 	$.ajax({
            type : "POST",
            url : "${pageContext.request.contextPath}/menu/getMenu",
            contentType : "application/json",
            data : null,
            datatype : "json",
            success : function(data) {
                var info = eval("(" + data + ")");
                $("#main-menu").append(info.result);
            },
            error : function(e) {
                alert(JSON.stringify(e));
            }
        }); */
    var menu = sessionStorage.getItem("menu");
    $("#main-menu").append(menu);

}

function  getTime() {
    var html = "";
    var date = new Date(value);
    var datetime = new Date();
    datetime.setTime(date);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
    var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
    var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
    var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
    html = year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    return html
}


function timeFormate(date) {
    if (!date || typeof (date) === "string") {
        this.error("参数异常，请检查...")
    }
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    d = d < 10 ? "0" + d : d;
    return y + "-" + m + "-" + d

}

function getFirsDayOfMonth() {
    var date = new Date();
    date.setDate(1);
    return this.timeFormate(date);
}

function getCurrDay() {
    var date = new Date();
    return this.timeFormate(date)
}

function getCurrDay7() {
    var nd = new Date();
    nd = nd.valueOf();
    nd = nd + 7 * 24 * 60 * 60 * 1000;
    nd = new Date(nd);
    var y = nd.getFullYear();
    var m = nd.getMonth()+1;
    var d = nd.getDate();
    if(m <= 9) m = "0"+m;
    if(d <= 9) d = "0"+d;
    var cdate = y+"-"+m+"-"+d;
    return cdate;
}

function getCurrDay1() {
    var nd = new Date();
    nd = nd.valueOf();
    nd = nd + 1 * 24 * 60 * 60 * 1000;
    nd = new Date(nd);
    var y = nd.getFullYear();
    var m = nd.getMonth()+1;
    var d = nd.getDate();
    if(m <= 9) m = "0"+m;
    if(d <= 9) d = "0"+d;
    var cdate = y+"-"+m+"-"+d;
    return cdate;
}

function fun_date(aa){
    var date1 = new Date(), time1=date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();//time1表示当前时间
    var date2 = new Date(date1);
    date2.setDate(date1.getDate()+aa);
    var curr_date = date2.getDate();
    var curr_month = date2.getMonth() + 1;
    String(curr_month).length < 2 ? (curr_month = "0" + curr_month): curr_month;
    String(curr_date).length < 2 ? (curr_date = "0" + curr_date): curr_date;
    var time2 = date2.getFullYear()+"-"+curr_month+"-"+curr_date;
    return time2;
}


function myajax(obj, successcalllback, errorcallback) {
    var datastr = JSON.stringify(obj);
    $.ajax({
        type: "POST",
        url: "../web",
        contentType: "application/json",
        data: datastr,
        datatype: "json",// "xml", "html", "script", "json", "jsonp", "text".
        success: function (data) {
            console.log(JSON.stringify(data));
            if (data.key == 1) {
                successcalllback(data);
            } else {
                alert(data.message + "(" + data.key + ")");
            }
        },
        error: function (e) {
            if (errorcallback == "undefined") {
                alert(e);
            } else {
                errorcallback(e);
            }

        }
    });
}

function getImgUrl() {
    var imgUrl = "";
    for (var i = 0; i < initImg.length; i++) {
        if (initImg[i] != "" && initImg[i] != undefined) {
            if (imgArr.length == 0) {
                imgUrl = imgUrl + initImg[i];
            } else {
                imgUrl = imgUrl + initImg[i] + ",";
            }
        }
    }

    for (var j = 0; j < imgArr.length; j++) {
        if (imgArr[j] != "" && imgArr[j] != undefined) {
            if (j != imgArr.length - 1) {
                imgUrl = imgUrl + imgArr[j] + ",";
            } else {
                imgUrl = imgUrl + imgArr[j];
            }
        }
    }
    return imgUrl;
}

function checkRate(value) {
    var re = /^[0-9]+.?[0-9]*$/;
    if (!re.test(value)) {

        return false;
    }
    return true;
}

function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    var context = "";
    if (r != null)
        context = r[2];
    reg = null;
    r = null;
    return context == null || context == "" || context == "undefined" ? ""
        : context;
}

function reqrefresh(url) {
    window.history.replaceState("", "", window.location.href.split('?')[0]
        + "?" + url);
    var newurl = "../web?" + url;
    $('#table').bootstrapTable('refresh', {
        url: newurl,
    });
};

function rsphandler(res) {
    $("#mypage").html(res.pagehtml);
    return res.list;
};

function tostringify(data) {
    var datastr = JSON.stringify(data);
    return datastr;
}

function toeval(data) {
    var datastr = eval("(" + data + ")");
    return datastr;
}

function tourlparams(obj) {
    var str = "";
    for (var prop in obj) {
        // alert(prop+" : "+obj[prop]);
        if (str != "") {
            str += "&";
        }
        str += prop + "=" + obj[prop];
    }
    return str;
}

// 通用加载表格
function loadcommondata(obj) {
    myajax(obj, function (rsdata) {
        $('#table').bootstrapTable({
            data: rsdata.list
            /**/
        });
        $("#mypage").html(rsdata.pagehtml);
    });
}

// 格式化时间
function FormatDate(nS) {
    // return new Date(parseInt(nS) *
    // 1000).toLocaleString().toLocaleString().replace(/:\d{1,2}$/,' ');
    var now = new Date(parseInt(nS) * 1000);
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
    return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":"
        + second;
}

function geturlparams(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = decodeURI(window.location.search).substr(1).match(reg);
    if (r != null)
        return unescape(r[2]);
    return null;
}

function FormatImages(v) {
    // http://112.74.219.38:8080/imgs/other/source/20160613094303_5073.jpg
    // imagehost
    var sb = "";
    var imgs = v.split(",");
    for (var i = 0; i < imgs.length; i++) {
        var tmp = imgs[i].split("/");
        if (tmp.length >= 2) {
            var imgsrc = imagehost + tmp[0] + "/thumbnail/" + tmp[1];
            sb += "<img src=" + imgsrc
                + " style=width:150px;height;150px;padding-right:12px;>";
        }
    }
    return [sb,].join('');
}

function FormatVideo(v) {
    var sb = "";
    var imgs = v.split(",");
    for (var i = 0; i < imgs.length; i++) {
        if (sb != "") {
            sb += ",";
        }
        sb += "<video src='"
            + imgs
            + "' controls='controls'  style=width:150px;height;150px;padding-right:12px; ></video>";
    }

    return [sb,].join('');
}

function FormatAudio(v) {
    var sb = "";
    var imgs = v.split(",");
    for (var i = 0; i < imgs.length; i++) {
        if (sb != "") {
            sb += ",<br/>";
        }
        sb += "<audio src='" + imgs[i]
            + "' controls='controls' style=padding-right:12px;></audio>";
    }

    return [sb,].join('');
}

function checkisnull(v) {
    if (v == "" || v == undefined) {
        return true;
    }
    return false;
}

function myback() {
    history.back();
}

Date.prototype.pattern = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, // 月份
        "d+": this.getDate(), // 日
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, // 小时
        "H+": this.getHours(), // 小时
        "m+": this.getMinutes(), // 分
        "s+": this.getSeconds(), // 秒
        "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
        "S": this.getMilliseconds()
        // 毫秒
    };
    var week = {
        "0": "\u65e5",
        "1": "\u4e00",
        "2": "\u4e8c",
        "3": "\u4e09",
        "4": "\u56db",
        "5": "\u4e94",
        "6": "\u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt
            .replace(
                RegExp.$1,
                ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f"
                    : "\u5468")
                    : "")
                + week[this.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
                : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}

function get_unix_time(dateStr) {
    var newstr = dateStr.replace(/-/g, '/');
    var date = new Date(newstr);
    var time_str = date.getTime().toString();
    return time_str.substr(0, 10);
}

function circleClass() {

    $.ajax({
        type: "POST",
        url: "../json",
        data: {
            "rcode": 30000
        },
        // 返回数据的格式
        datatype: "json",// "xml", "html", "script", "json", "jsonp", "text".
        success: function (data) {

            $.each(data, function (key, value) {
                console.log(value);
                $("#keyword").append(
                    "<option value='" + value.id + "'>" + value.name
                    + "</option>");
            });
            load();
        },
        error: function (e) {
            alert("error");
        }
    });

}

timeStamp2String = function (time) {
    var datetime = new Date();
    datetime.setTime(time);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
    var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
    var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
    var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
    return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
}


