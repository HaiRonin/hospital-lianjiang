<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>住院清单</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
<div class="c-main pb15 appoin">
    <h4>就诊人：<span id="name"></span><span id="cardNo"></span>
        </h4>

    <div class="list-block" style="margin: 0;font-size: 14px;">
        <ul>
            <li class="item-content" style="padding-left: 0;min-height: auto;height: 35px;line-height: 35px">
                <div class="item-media"><i class="icon icon-f7"></i></div>
                <div class="item-inner">
                    <div class="item-title">总费用：</span></div>
                    <div id="totalMoney" class="item-after"></div>
                </div>
            </li>
        </ul>
    </div>

    <div class="appolist" style="overflow-y:auto;">
        <ul>
        </ul>
        <div id="noData" hidden="true"
             style="position: absolute;top: 50%;left: 50%;margin-top: -50px;margin-left: -76.5px;">
            <img style="width: 153px;height: 100px;" src="../images/nodata.png">
            <p style="margin-top: 10px;width: 153px;text-align: center;color: #eeeeee;">暂无记录</p>
        </div>
    </div>
</div>

<div class="selectbg">
    <div class="selectextbg">
        <div class="selectext">
            <h4><span>取消</span>选择就诊人</h4>
            <ul>
            </ul>
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
<div class="addInHosNo" hidden="true">
    <div class="addpson forremind">
        <i class="sicon icon-anclose" onclick="addInHosNoclose()"></i>
        <i class="an-remind"></i>
        <div class="h50 c-999 c-f15">你还未绑定住院号</div>
        <a href="../user/memberList" class="btn-anadd mt10">去绑定</a>
    </div>
    <div class="addpson-mb"></div>
</div>


<script>
    $().ready(function(){
        var height = ($(window).height()-110) + "px";
        $(".appolist").css("height",height);
    });
    $.showPreloader('加载中...');
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        firsDayOfMonth = this.fun_date(-30);
        currDay = this.fun_date(1);
        $('.selectbg').hide();
        queryPatients();
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

    function addInHosNoclose() {
        $(".addInHosNo").hide();
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
                            if (list.length > 0) {
                                $('#name').text(list[list.length - 1].Name);
                                querypaymentrecordlist(list[list.length - 1]);
                            }
                            $.each(result.myIdList, function (i, item) {
                                var data = JSON.stringify(item);
                                $('.selectext ul').append("<li onclick='querypaymentrecordlist(" + data + ")'>" + item.Name + "</li>")
                            });
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

        $('.appolist ul').html("");
        console.log(item)
        $(".selectbg").hide();
        $(".noData").hide();
        $('#name').text(item.Name);
        $('#cardNo').text("(住院号" + item.inHosNo + ")");
        if(item.inHosNo==null || item.inHosNo==''){
            $.toast("无住院信息");
            $('#noData').show();
            $('.addInHosNo').show();
            return
        }
        var json = {
            "cardNo": item.IDCardno,
            "synUserName": "",
            "synKey": "",
            "visitCardNo":item.CardNo,
            "socialsecurityNO":"",
            "bankCardNumber":item.inHosNo
        };
        $('.appolist ul').empty();
        $('#totalMoney').text("0.00元");
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querypatientinhosinfo",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                console.log(result);
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.inHosList !== null) {
                            $.each(result.inHosList, function (i, item) {
                                var inHosDate = item.inHosDate;
                                 inHosDate =inHosDate.substring(0,10)
                                $(".selectbg").hide();
                                var date1 = new Date();
                                var time1= date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();
                                var json1 = {
                                    "inHosNo": item.inHosNo,
                                    "synUserName": "",
                                    "synKey": "",
                                    "patientNo":"",
                                    "startDate":inHosDate,
                                    "endDate":time1
                                };
                                $('.appolist ul').empty();
                                $('#totalMoney').text("0.00元");
                                $.ajax({
                                    url: "../his/request",
                                    method: "POST",
                                    dataType: 'json',
                                    data: {
                                        api: "/inhosdetail",
                                        dataParam: JSON.stringify(json1)
                                    },
                                    success: function (result) {
                                        console.log(result);
                                        if (result != null) {
                                            if (result.resultCode === "00") {
                                                $('#noData').hide();
                                                if (result.inHosList !== null) {
                                                    $('#totalMoney').text(result.totalMoney + "元");
                                                    $.each(result.inHosList, function (i, item) {
                                                        $('.appolist ul').append("<li>\n" +
                                                                "                <h5>项目名称：" + item.projectName + "</h5>\n" +
                                                                "                <h5>项目编号：" + item.projectCode + "</h5>\n" +
                                                                "                <h5>药品分类：" + item.drugType + "</h5>\n" +
                                                                "                 <cite>规格：" + item.feeItemStandard + "</cite>\n" +
                                                                "                 <cite><p>单价：" + item.feeItemAmount + "元</p><p>总价:" + item.feeItemAllAmount + "元</p></cite>\n" +
                                                                "                 <cite>比例：" + item.chargeDate +"%"+ "</cite>\n" +
                                                                "                <em>扣费时间：" + item.payDate + "</em>\n" +
                                                                "                 <cite>纯自付金额：" + item.payMoney + "</cite>\n" +
                                                                "                <span>" + item.feeItemNum + "" + item.feeItemUnit + "</span>" +
                                                                "            </li>")
                                                    });
                                                    $('#totalMoney').text(result.resultMsg + "元");
                                                    return;
                                                }
                                                $('#noData').show();
                                            }
                                        }
                                        $('#noData').show();
                                    },
                                    error: function (e) {
                                        $.toast("获取失败，请稍后再试!");
                                    }
                                });
                            });

                        }
                    }
                    $('#noData').show();
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