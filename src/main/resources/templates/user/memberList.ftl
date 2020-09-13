<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>就诊人列表</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
    <style>
        .c-main {
            overflow-y: auto;
        }
        input::-webkit-input-placeholder{
            color: #0093ff;
        }
    </style>
</head>

<body>
<div class="c-main pb15">
    <div class="">
        <h4 class="jzr-title">温馨提示：最多可添加<span class="c-ffac0b">6位</span>就诊人，请谨慎添加</h4>
        <ul class="jzr-list">
        </ul>
    </div>
    <div class="mt20 plr15">
        <a href="../user/toBindInfo" class="c-btn c-btn-blue">添加就诊人</a>
    </div>
    <div style="text-align:center;margin : 40px 0px 0px 0px;">
        <p style="font-size:15px;margin-top: 2px; ">无诊疗卡？</p>
    </div>
    <div style="text-align:center;margin : 10px 0px 0px 0px;">
        <input type="text" placeholder="在线建卡" id="onLineCardBuilding" style="font-weight:bold;width:38%;font-size:16px;padding-top:3px;line-height:35px;height:40px;border-radius:20px;text-align:center;border:0.5px solid #349EDF;">
    </div>
</div>
<div class="addpsonpop" style="display:none">
    <div class="addpson forremind">
        <i class="sicon icon-anclose"></i>
        <i class="an-remind"></i>
        <div class="h50 c-999 c-f15">最多可添加6位就诊人</div>
        <a id="" href="javascript:;" class="btn-anadd mt10">我知道了</a>
    </div>
    <div class="addpson-mb"></div>
</div>

<div class="c-conf-screen" hidden="true">
    <div class="c-conf-box">
        <div class="confcontent">是否要解除绑定？</div>
        <div class="c-confbtn"><a href="javascript:;" class="c-twobtn cancel" id="popcanclebtn">取消</a><a href="javascript:;" class="c-twobtn comfirm" id="popsurebtn">确定</a></div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("a.mt10").click(function () {
            $('.addpsonpop').hide();
        });
        $("i.icon-anclose").click(function () {
            $('.addpsonpop').hide();
        });

        $(function () {
            queryPatients();
        })
    });

    //获取就诊人列表
    function queryPatients() {
        var json = {
            "id": window.localStorage.getItem("openId"),
            "synUserName": "",
            "synKey": ""
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/queryPatients",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                console.log(result);
                if (result != null) {
                    if (result.resultCode === "成功") {
                        if (result.myIdList !== null) {
                            if (result.myIdList.length >= 6) {
                                $("div.plr15").hide();
                                return;
                            }
                            $.each(result.myIdList, function (i, item) {
                                var data = JSON.stringify(item);
                                var CardNo = item.CardNo;
                                var inHosNo = item.inHosNo == '' ? "<span style='color:dodgerblue' onclick='goUpdate("+CardNo+")'><u>去绑定</u></span>" : item.inHosNo;
                                $('ul.jzr-list').append("<li><a class=\"c-arrow-r\"><h4><i class=\"sicon icon-jzr\"></i>" + item.Name + "<span style=\"float:right \">"+"门诊号："+ item.PatientNo+"</span>\n" +
                                        "</h4>\n" +
                                        "<div class=\"jzr-card c-pack\"><span>就诊卡:" + item.CardNo + "</span>" +
                                        "<span>&nbsp;&nbsp;&nbsp;&nbsp;住院号:"+inHosNo+"</span><i\n" +
                                        "id='" + item.CardNo + "' onclick='delPatient("+data+")' class=\"defaubq\">删除</i></div>\n" +
                                        "</a>\n" +
                                        "</li>")
                            });
                        }
                    }
                }
            },
            error: function (e) {
                $.toast("绑定失败，请稍后再试");
            }
        });
    }

    $("#onLineCardBuilding").click(function(){
        window.location.href = "../user/toBindInfoline";
    });
    
    
    function goUpdate(CardNo) {
        window.location.href = "../user/toBindInfo?CardNo="+CardNo;
    }

    //删除就诊人
    function delPatient(data) {
        $('.c-conf-screen').show();

        $(".cancel").click(function () {
            $('.c-conf-screen').hide();
        });
        $('.comfirm').click(function () {
            var json = {
                "inHosNo": data.inHosNo,
                "CardNo": data.CardNo,
                "synUserName": "",
                "synKey": "",
                "id": window.localStorage.getItem("openId")
            };
            $.ajax({
                url: "../his/request",
                method: "POST",
                dataType: 'json',
                data: {
                    api: "/deletePatients",
                    dataParam: JSON.stringify(json)
                },
                success: function (result) {
                    console.log(result);
                    if (result != null) {
                        if (result.resultCode === "00") {
                            $.toast("删除成功!");
                            location.reload();
                            return
                        }
                    }
                    $.toast("删除失败!");
                },
                error: function (e) {
                    $.toast("删除成功!");
                }
            });
        });

    }

</script>
</body>
</html>
