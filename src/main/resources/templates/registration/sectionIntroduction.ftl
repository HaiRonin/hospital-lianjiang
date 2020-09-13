<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>科室介绍</title>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/picker.js"></script>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<div class="c-main">
    <div class="h45">
        <ul class="com-lab">
            <li class="curr"><a href="javascript:;">科室</a></li>
        </ul>
    </div>
    <div class="deptspace"></div>
    <div class="detailsInfo" id="detailsInfoList">
        <ul>
            <span style="width: 30%">科室名称：</span>
            <span id="name" style="width: 70%;text-align: right;"></span>
            <h5>科室介绍：</h5>
            <h5 id="ddesc" ></h5>
        </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        organId = getQueryString("valus");
        querydepartmentlist();
    });

    var organId="";

    //获取所有科室
    function querydepartmentlist() {
        var json = {
            "synUserName": "",
            "synKey": ""
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querydepartmentlist",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                if (result != null) {
                    console.log(result);
                    if (result.resultCode === "00") {
                        if (result.department !== null) {
                            $.each(result.department, function (i, item) {
                                if(organId==item.organId){
                                    $('#name').text(item.name);
                                    $('#ddesc').text(item.ddesc );
                                }
                            });
                        }
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return null;
    }

</script>
</body>
</html>