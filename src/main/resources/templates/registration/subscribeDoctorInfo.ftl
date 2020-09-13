<!DOCTYPE html>
<html ng-app="app">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet" href="../css/sm.min.css">
    <link rel="stylesheet" href="../css/kdui/min.css">
    <link rel="stylesheet" href="../css/style1.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <title>预约列表</title>
</head>

<body ng-controller="clincTimeController">
<div class="page-group">
    <div class="page">
        <header style="height: 0px;" class="bar bar-nav">
        </header>
        <div class="content" style="top: 0rem;">
            <div class="card">
                <div class="card-content">
                    <div class="list-block media-list">
                        <ul>
                            <li class="item-content">
                                <div class="item-media">
                                    <img id="photoUrl" src="../images/d-male.png"
                                         onerror="javascript:this.src='../images/d-male.png'" width="70">
                                </div>
                                <div class="item-inner">
                                    <div class="item-title-row">
                                        <div class="item-title" id="name"></div>
                                    </div>
                                    <div class="item-subtitle" id="job"></div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="card-footer">
                    <span id="specialty3"></span>
                </div>
            </div>

            <div class="card" style="padding-top: 3px;padding-bottom: 3px;">
                <ul id="textDate" style="display: flex;flex-direction: row;width: 100%;height: 25px;
                margin-block-start:0.5em;margin-block-end:0.5em;padding-left: 0px">
                </ul>
                <ul id="numDate" style="display: flex;flex-direction: row;width: 100%;height: 25px;
                margin-block-start:0.5em;margin-block-end:0.5em;padding-left: 0px">
                </ul>
            </div>

            <div class="list-block cards-list" style="margin: 0.5rem 0">
                <ul>
                    <li class="card">
                        <div id="am"
                             style="display: flex;flex-direction: row;height: 48px;width: 100%;line-height: 48px;" onclick="morningDate()">
                            <div style="width: 35%;margin-left: 5px">上午</div>
                            <div style="width: 25%;">剩余<span id="morningNum" style="color: #2ac845;"></span>个号</div>
                            <div style="width: 15%;"><span id="am_consultationFee" style="color: #ff6600;"></span>元
                            </div>
                            <span id="am_flag" style="width: 25%;text-align: right;"></span>
                            <span class="icon icon-right" style="margin-right: 5px;"></span>
                        </div>
                    </li>
                    <li class="card">
                        <div id="pm"
                             style="display: flex;flex-direction: row;height: 48px;width: 100%;line-height: 48px;"  onclick="afternoonDate()">
                            <div style="width: 35%;margin-left: 5px">下午</div>
                            <div style="width: 25%;">剩余<span id="afternoonNum" style="color: #2ac845;"></span>个号</div>
                            <div style="width: 15%;"><span id="pm_consultationFee" style="color: #ff6600;"></span>元
                            </div>
                            <span id="pm_flag" style="width: 25%;text-align: right;"></span>
                            <span class="icon icon-right" style="margin-right: 5px;"></span>
                        </div>
                    </li>

                    <li class="card">
                        <div id="even"
                             style="display: flex;flex-direction: row;height: 48px;width: 100%;line-height: 48px;"  onclick="nightDate()">
                            <div style="width: 35%;margin-left: 5px">晚上</div>
                            <div style="width: 25%;">剩余<span id="eveningNum" style="color: #2ac845;"></span>个号</div>
                            <div style="width: 15%;"><span id="even_consultationFee" style="color: #ff6600;"></span>元
                            </div>
                            <span id="even_flag" style="width: 25%;text-align: right;"></span>
                            <span class="icon icon-right" style="margin-right: 5px;"></span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    var today = new Array('日', '一', '二', '三', '四', '五', '六');
    var organdoctorId = "";
    var departmentorganId = "";
    var type = "";
    var arr = [];
    var days = [];
    var ds = [];

    var morningNum = '0';
    var afternoonNum = '0';
    var eveningNum = '0';


    var locationName = '';
    var consultationFee = "";
    var  doctorName = "";
    var sourceDate ="";
    var name = "";
    var photoUrl ="";
    var job = "";


    $(document).ready(function () {
        organdoctorId = getQueryString("valus");
        departmentorganId = getQueryString("depId");
        //photoUrl = getQueryString("photoUrl");
        photoUrl = getQueryStringInfo("photoUrl");
        job = getQueryStringInfo("job");

        name = getQueryStringInfo("name");
        console.log(photoUrl);
        $("#name").text(name);
        $("#job").text(job);

        $("#photoUrl").attr("src",photoUrl);

        querydoctorbyid();
        type = getQueryString("type");
        getReqDate();
        queryToRegDoctorTimes(0);

        $.each(days, function (i, item) {
            if (i == 0) {
                $('#numDate').append('<li class="lc"><a onclick="req(' + i + ')" id="' + i + '" class="liCard">' + item + '</a></li>')
            } else {
                $('#numDate').append('<li  class="lc"><a onclick="req(' + i + ')" id="' + i + '" class="liCard-nor">' + item + '</a></li>')
            }
        });

        $.each(ds, function (i, item) {
            $('#textDate').append('<li style="display: block;width: 14.28%;text-align: center">' + item + '</li>')
        });


        $('#am').click(function () {
            if (morningNum == '0') {
                $.toast("当前时段无号可挂!");
                return
            }
            window.location.href = '../registration/registeredInfo?locationName=' + locationName
            +"&consultationFee="+consultationFee
            +"&doctorName="+doctorName
            +"&sourceDate="+sourceDate
            +"&organdoctorId="+organdoctorId
            +"&departmentorganId="+departmentorganId
                    +"&sourceTimeType="+sourceTimeType;

        });

        $('#pm').click(function () {
            if (afternoonNum == '0') {
                $.toast("当前时段无号可挂!");
                return
            }

            window.location.href = '../registration/registeredInfo?locationName=' + locationName
                    +"&consultationFee="+consultationFee
                    +"&doctorName="+doctorName
                    +"&sourceDate="+sourceDate
                    +"&organdoctorId="+organdoctorId
                    +"&departmentorganId="+departmentorganId
                    +"&sourceTimeType="+sourceTimeType;
        });

        $('#even').click(function () {
            if (eveningNum == '0') {
                $.toast("当前时段无号可挂!");
                return
            }
            window.location.href = '../registration/registeredInfo?locationName=' + locationName
                    +"&consultationFee="+consultationFee
                    +"&doctorName="+doctorName
                    +"&sourceDate="+sourceDate
                    +"&organdoctorId="+organdoctorId
                    +"&departmentorganId="+departmentorganId
                    +"&sourceTimeType="+sourceTimeType;
        });


    });

    //获取医生的详细信息
    function querydoctorbyid() {
        $.showPreloader();
        var json = {
            "synUserName": "",
            "synKey": "",
            "departmentorganId": departmentorganId,
            "organdoctorId": organdoctorId
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            async: false,
            data: {
                api: "/querydoctorbyid",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                if (result.resultCode === "00" && result.Doctor.length > 0) {
                    $("#specialty3").text("医生简介：" + result.Doctor[0].ddesc);
                }
            },
            error: function (e) {
            }
        });
    }

    function req(id) {
        for (var i = 0; i < days.length; i++) {
            if (id == i) {
                $('#' + i).attr("class", 'liCard');
                querytoregdoctorListbydoctorid(arr[i])
            } else {
                $('#' + i).attr("class", 'liCard-nor')
            }
        }
    }

    function getQueryStringInfo(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]); return null;
    }

    function getReqDate() {
        var dd = new Date();
        for (var i = 0; i < 7; i++) {
            dd.setDate(dd.getDate() + 1);
            var m = dd.getMonth() + 1;
            var month = m < 2 ? "0" + m : m;
            var day = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
            ds.push(today[dd.getDay()]);
            days.push(day);
            arr.push(dd.getFullYear() + "-" + month + "-" + day)

        }
    }


    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    function Times(date) {
        if(date == 7 ){
            $('#am_flag').text('不可挂号');
            $('#pm_flag').text('不可挂号');
            $('#even_flag').text('不可挂号');
            $('#am').css({"background-color":"#BDBDBD"});
            $('#pm').css({"background-color":"#BDBDBD"});
            $('#even').css({"background-color":"#BDBDBD"});
            $.toast("暂无排班,谢谢");
            return
        }else {
            queryToRegDoctorTimes(date);
        }

    }



    function queryToRegDoctorTimes(date) {
        console.log(arr[date]);
        var sourceDate=arr[date];
        var json = {
            "synUserName": "",
            "synKey": "",
            "organdoctorId": organdoctorId,
            "startDate":sourceDate,
            "endDate": sourceDate
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querytoregdoctorListbydoctorid",
                dataParam: JSON.stringify(json)
            },
            async: true,
            success: function (result) {
                console.log(result);
                if (result != null) {
                    if (result.resultCode == "00") {
                        req(date);
                    } else {
                            Times(date + 1);
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }


    //根据医生获取挂号数据
    function querytoregdoctorListbydoctorid(date) {
        $("#morningNum").text("0");
        $("#am_consultationFee").empty();
        $("#afternoonNum").text("0");
        $("#pm_consultationFee").empty();
        $("#eveningNum").text("0");
        $("#even_consultationFee").empty();
        $('#am').css({"background-color":"#FFFFFF"});
        $('#pm').css({"background-color":"#FFFFFF"});
        $('#even').css({"background-color":"#FFFFFF"});
        var json = {
            "synUserName": "",
            "synKey": "",
            "organdoctorId": organdoctorId,
            "startDate": date,
            "endDate": date
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querytoregdoctorListbydoctorid",
                dataParam: JSON.stringify(json)
            },
            async: true,
            success: function (result) {
                console.log(result)
                if (result != null) {
                    if (result.resultCode === "00") {
                        var list = result.regDoctor;
                        if (list.length > 0) {
                            locationName = list[0].locationName;
                            consultationFee = list[0].consultationFee;
                            doctorName = list[0].doctorName;
                            sourceDate = list[0].sourceDate;

                            if(list[0].morningNum>0){
                                morningNum = list[0].morningNum;
                            }else {
                                morningNum ='0';
                            }

                            if(list[0].afternoonNum>0){
                                afternoonNum = list[0].afternoonNum;
                            }else {
                                afternoonNum = '0';
                            }

                            if(list[0].eveningNum>0){
                                eveningNum = list[0].eveningNum;
                            }else {
                                eveningNum='0';
                            }

                            $('#am_consultationFee').text(list[0].consultationFee);
                            $('#pm_consultationFee').text(list[0].consultationFee);
                            $('#morningNum').text(morningNum == '-1' ? '?' : morningNum);
                            $('#afternoonNum').text(afternoonNum);

                            $('#eveningNum').text(eveningNum);
                            $('#even_consultationFee').text(list[0].consultationFee);

                            if (morningNum > 0) {
                                $('#am_flag').text('可挂号');
                            } else {
                                $('#am_flag').text('不可挂号');
                                $('#am').css({"background-color":"#BDBDBD"});
                            }

                            if (afternoonNum > 0) {
                                $('#pm_flag').text('可挂号');
                            } else {
                                $('#pm_flag').text('不可挂号');
                                $('#pm').css({"background-color":"#BDBDBD"});
                            }

                            if (eveningNum > 0) {
                                $('#even_flag').text('可挂号');
                            } else {
                                $('#even_flag').text('不可挂号');
                                $('#even').css({"background-color":"#BDBDBD"});
                            }
                            return
                        }
                        $.toast("获取失败，请稍后再试!");
                    }
                    morningNum='0';
                    afternoonNum='0';
                    eveningNum='0';
                    $('#am_flag').text('不可挂号');
                    $('#pm_flag').text('不可挂号');
                    $('#even_flag').text('不可挂号');
                    $('#am').css({"background-color":"#BDBDBD"});
                    $('#pm').css({"background-color":"#BDBDBD"});
                    $('#even').css({"background-color":"#BDBDBD"});
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }
    var sourceTimeType=null;
    function morningDate(){
        sourceTimeType="1";
    }
    function afternoonDate() {
        sourceTimeType="2";
    }
    function nightDate() {
        sourceTimeType="3";
    }
</script>
</body>

</html>