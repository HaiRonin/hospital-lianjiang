<!DOCTYPE html>
<html ng-app="app">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet" href="../css/sm.min.css">
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <title>挂号列表</title>
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
                                    <img id="photoUrl" src="../images/d-male.png" width="70">
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

            <div class="list-block cards-list" style="margin: 0.5rem 0">
                <ul>
                    <li class="card">
                        <div id="am"
                             style="display: flex;flex-direction: row;height: 48px;width: 100%;line-height: 48px;">
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
                             style="display: flex;flex-direction: row;height: 48px;width: 100%;line-height: 48px;">
                            <div style="width: 35%;margin-left: 5px">下午</div>
                            <div style="width: 25%;">剩余<span id="afternoonNum" style="color: #2ac845;"></span>个号</div>
                            <div style="width: 15%;"><span id="pm_consultationFee" style="color: #ff6600;"></span>元
                            </div>
                            <span id="pm_flag" style="width: 25%;text-align: right;"></span>
                            <span class="icon icon-right" style="margin-right: 5px;"></span>
                        </div>
                    </li>

                    <li class="card" id="eveningShow">
                        <div id="even"
                             style="display: flex;flex-direction: row;height: 48px;width: 100%;line-height: 48px;">
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
    var organdoctorId = "";
    var departmentorganId = "";
    var type = "";

    var morningNum = '0';
    var afternoonNum = '0';
    var eveningNum = '0';

    var locationName = '';
    var consultationFee = "";
    var  doctorName = "";
    var sourceDate ="";

    var timestamp=null;
    var starttimeHaoMiao=null;
    var endtimeHaoMiao=null;

    $(document).ready(function () {
        organdoctorId = getQueryString("valus");
        departmentorganId = getQueryString("depId");
        type = getQueryString("type");
        $(function () {
            querydoctorbyid();
            querytoregdoctorListbydoctorid();
            var date1 = new Date();
             timestamp = (new Date()).getTime();
            var time1= date1.getFullYear()+"/"+(date1.getMonth()+1)+"/"+date1.getDate()+"/"+"17:30:00";  //time1表示当天17:30时间
             starttimeHaoMiao = (new Date(time1)).getTime();
            var time2= date1.getFullYear()+"/"+(date1.getMonth()+1)+"/"+date1.getDate()+"/"+"7:30:00";  //time1表示当天7:30时间
            endtimeHaoMiao = (new Date(time2)).getTime();
        });


        $('#am').click(function () {
            if (morningNum == '0') {
                $.toast("当前时段无号可挂!");
                return;
            }
            if(departmentorganId=="1342"){

            }else {
                if(timestamp>starttimeHaoMiao||timestamp<endtimeHaoMiao){
                    $.toast("当前时间不允许挂号!");
                    return
                }
            }
            window.location.href = '../registration/registeredInfo?locationName=' + locationName
                    +"&consultationFee="+consultationFee
                    +"&doctorName="+doctorName
                    +"&sourceDate="+sourceDate
                    +"&sourceTimeType=1"
                    +"&organdoctorId="+organdoctorId
                    +"&departmentorganId="+departmentorganId;
        });

        $('#pm').click(function () {
            if (afternoonNum == '0') {
                $.toast("当前时段无号可挂!");
                return
            }
            if(departmentorganId=="1342"){

            }else {
                if(timestamp>starttimeHaoMiao||timestamp<endtimeHaoMiao){
                    $.toast("当前时间不允许挂号!");
                    return
                }
            }
            window.location.href = '../registration/registeredInfo?locationName=' + locationName
                    +"&consultationFee="+consultationFee
                    +"&doctorName="+doctorName
                    +"&sourceTimeType=2"
                    +"&sourceDate="+sourceDate
                    +"&organdoctorId="+organdoctorId
                    +"&departmentorganId="+departmentorganId;
        });

        $('#even').click(function () {
            if (eveningNum == '0') {
                $.toast("当前时段无号可挂!");
                return
            }
            if(departmentorganId=="1342"){

            }else {
                if(timestamp>starttimeHaoMiao||timestamp<endtimeHaoMiao){
                    $.toast("当前时间不允许挂号!");
                    return
                }
            }
            window.location.href = '../registration/registeredInfo?locationName=' + locationName
                    +"&consultationFee="+consultationFee
                    +"&doctorName="+doctorName
                    +"&sourceDate="+sourceDate
                    +"&sourceTimeType=3"
                    +"&organdoctorId="+organdoctorId
                    +"&departmentorganId="+departmentorganId;
        });
    });



    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

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
                    $("#name").text(result.Doctor[0].name);
                    $("#job").text(result.Doctor[0].job);
                    $("#specialty3").text("医生简介：" + result.Doctor[0].ddesc);
                    $("#photoUrl").attr("src", result.Doctor[0].photoUrl);
                }
            },
            error: function (e) {
            }
        });
    }


    //根据医生获取挂号数据
    function querytoregdoctorListbydoctorid() {
        var json = {
            "synUserName": "",
            "synKey": "",
            "organdoctorId": organdoctorId,
            "startDate": getCurrDay(),
            "endDate": getCurrDay()
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            async: false,
            data: {
                api: "/querytoregdoctorListbydoctorid",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
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
                                 morningNum='0'
                             }
                            if(list[0].afternoonNum>0){
                                afternoonNum = list[0].afternoonNum;
                            }else {
                                afternoonNum='0';
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
                            if(eveningNum == -1){
                                $('#eveningShow').hide();
                            }
                            else{
                                $('#eveningNum').text(eveningNum);
                                $('#even_consultationFee').text(list[0].consultationFee);
                            }

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
                }
            },
            error: function (e) {
            }
        });
    }
</script>
</body>

</html>