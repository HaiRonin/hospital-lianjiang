<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>检验报告</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<div class="c-main pb15 appoin">
    <h4>请选择就诊人：<span>*</span><span id="cardNo">（ 就诊卡号：* ）</span><span id="hiFeeNos" style="display: none"></span></h4>
    <div class="appolist" style="display:block" id="appolistInfo">
        <ul>
        </ul>
        <div id="noData" hidden="true"
             style="position: absolute;top: 50%;left: 50%;margin-top: -50px;margin-left: -76.5px;">
            <img style="width: 153px;height: 100px;" src="../images/nodata.png">
            <p style="margin-top: 10px;width: 153px;text-align: center;color: #eeeeee;">暂无记录</p>
        </div>

    </div>
</div>


<div class="addpsonpop" hidden="true">
    <div class="addpson forremind">
        <i class="sicon icon-anclose" onclick="addpsonpopclose()"></i>
        <i class="an-remind"></i>
        <div class="h50 c-999 c-f15">你还未绑定任何就诊人</div>
        <a href="../user/memberList" class="btn-anadd mt10">去绑定</a>
    </div>
    <div class="addpson-mb"></div>
</div>

<div id="user" class="card"
     style="display:none">
</div>
<script>
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        $.showPreloader('加载中...');
        firsDayOfMonth = this.fun_date(-30);
        currDay = this.fun_date(1);
        $('.selectbg').hide();
        queryPatients();
        $("i.icon-anclose").click(function(){
            $('.addpsonpop').hide();
            window.history.back();
        });
    });

    $(".appoin h4").click(function () {
        $(".selectbg").show();
    });

    $(".selectext h4 span").click(function () {
        $(".selectbg").hide();
    });

    $(".selectext ul li").click(function () {
        var selecttext = $(this).html();
        $(".appoin h4 span").html(selecttext);
        $(".selectbg").hide();
    });

    function addpsonpopclose() {
        $(".addpsonpop").hide();
    }


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
                if (result != null) {
                    if (result.resultCode === "成功") {
                        if (result.myIdList !== null) {
                            var list = result.myIdList;
                            console.log(result);
                            if (list.length > 0) {
                                $('#name').text(list[0].Name);
                               // $('#cardNo').text("(门诊ID号" + list[0].CardNo + ")");
                                $('#cardNo').text("(就诊卡号"+list[0].CardNo+",门诊号"+list[0].PatientNo+")");
                                //querypaymentrecordlist(list[0]);
                                $.each(result.myIdList, function (i, item) {
                                    var data = JSON.stringify(item);
                                    $('.appolist ul').append("<li onclick='querypaymentrecordlist(" + data + ")'>" + item.Name + "</li>")
                                });
                            }
                            return
                        }
                    }
                }
                $('.addpsonpop').show();
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }
    function querypaymentrecordlist(item) {
        window.location.href = '../registration/queryExaminationRecordList?Name=' + item.Name +"&CardNo="+item.CardNo+"&IDCardno="+item.IDCardno;
    }
</script>
</body>
</html>