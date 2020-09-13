<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>我的门诊</title>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
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
    <div class="depthold c-border-tb">
        <h4 class="dh-title">滑动选择门诊科室</h4>
        <div class="dept-box">
            <div class="dept">
                <ul>
                </ul>
            </div>
        </div>
        <span style="font-size:15px;color:#d70f18">温馨提示：</span>
        <p style="font-size:14px;margin-top: 2px; color: #d70f18">尊敬的用户，为了不占用号源，预约服务只接受24小时以内预约就诊服务，如非24小时以内就诊的请勿预约，谢谢合作。</p>
    </div>
</div>
<script>
    var type="";
    $(document).ready(function () {
        var url = window.location.search;
        type = url.split("=")[1];
        $(function () {
            querydepartmentlist();
        });
    });


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
                    if (result.resultCode == "00") {
                        if (result.department !== null) {
                            $.each(result.department, function (i, item) {
                                if(item.name!=="儿科一区门诊"){
                                    if(item.name!=="放射科"){
                                        $('.dept ul').append("<li class=\"curr\">" +
                                                "<a href='../registration/departmentDoctorList?valus="+item.organId+"&type="+type+"&name="+item.name+"'>"+item.name+"</a></li>")
                                    }
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
</script>
</body>
</html>