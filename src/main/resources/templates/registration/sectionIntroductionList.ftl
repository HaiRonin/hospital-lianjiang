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
    <div class="depthold c-border-tb">
        <div class="dept-box">
            <div class="dept" style="display: block" id="appolistInfo">
                <ul>
                </ul>
            </div>
        </div>
    </div>
    <div class="detailsInfo" id="detailsInfoList" style="display: none">
        <ul>

        </ul>
    </div>
</div>
<script>
        $(function () {
            querydepartmentlist();
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
                    if (result.resultCode === "00") {
                        if (result.department !== null) {
                            $.each(result.department, function (i, item) {
                                $('.dept ul').append("<li class=\"curr\">" +
                                        "<a href='../registration/sectionIntroduction?valus="+item.organId +"'>"+item.name+"</a></li>")
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