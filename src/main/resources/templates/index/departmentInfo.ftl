<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>科室选择</title>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css"
          type="text/css"/>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/base.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
<div class="c-main">
    <div class="h45">
        <ul class="doc-filter">
            <li id="filter-dept">科室</li>
        </ul>
    </div>
    <div class="deptspace"></div>
    <div class="depthold c-border-tb">
        <div class="dept-box">
            <div class="dept"></div>
        </div>
        <div class="info-office-title">
            <h2>科室位置：</h2>
        </div>
        <div class="info-office-title" id='deptaddr'></div></br>
        <div class="info-office-title">
            <h2>科室简介：</h2>
        </div>
        <div class="info-office-list" id='dept'>
        </div>
    </div>
</div>
<script>
    var departmentorganId = "";
    $(document).ready(function () {
        departmentorganId = getQueryString("valus");
        $(function () {
            querydepartmentbyid();
        });
       /* var url = window.location.search;
        organdoctorId = url.split("&")[0].split("=")[1];
        departmentorganId = url.split("&")[1].split("=")[1];
        $(function () {
            querydoctorbyid();
            querytoregdoctorListbydoctorid();
        });*/
    });
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    //获取医生的详细信息
    function querydepartmentbyid() {
        var json = {
            "synUserName": "",
            "synKey": "",
            "organId": departmentorganId
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querydepartmentbyid",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.department !== null) {
                            var list = result.department;
                            if (list.length > 0) {
                                $("#deptaddr").text(list[0].departAddr);
                                $("#dept").text(list[0].department.ddesc);
                            }else{
                                $("#deptaddr").text("暂无信息");
                                $("#dept").text("暂无信息");
                            }
                        }else{
                            $("#deptaddr").text("暂无信息");
                            $("#dept").text("暂无信息");
                        }
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }
</script>
</body>
</html>