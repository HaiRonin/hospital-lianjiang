<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>押金补缴</title>
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
    <div class="appolist">
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
<div class="c-conf-screen" hidden="true">
    <div class="c-conf-box">
        <div class="confcontent">是否确定要缴费？</div>
        <div class="c-confbtn"><a href="javascript:;" class="c-twobtn cancel" id="popcanclebtn">取消</a><a href="javascript:;" class="c-twobtn comfirm" id="popsurebtn">确定</a></div>
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
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        $.showPreloader('加载中...');
        firsDayOfMonth = this.fun_date(-15);
        currDay = this.fun_date(7);
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
                            console.log(result);
                            var list = result.myIdList
                            if (list.length > 0) {
                                $('#name').text(list[list.length-1].Name);
                                $('#cardNo').text("(住院号" + list[list.length-1].inHosNo + ")");
                                querypaymentrecordlist(list[list.length-1]);
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

    function addpsonpopclose() {
        $(".addpsonpop").hide();
    }

    function addInHosNoclose() {
        $(".addInHosNo").hide();
    }

    var inHosNo = null;
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
            "bankCardNumber": item.inHosNo,
            "synUserName": "",
            "synKey": "",
            "patientNo": "",
            "cardNo": item.IDCardno,
            "visitCardNo": item.CardNo,
            "socialsecurityNO": ""
        };
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
                $('.list-block ul').hide();
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.inHosList !== null) {
                            var inHosList = result.inHosList;

                            console.log(inHosList);
                            $.each(result.inHosList, function (i, item1) {
                                inHosNo = item1.inHosNo;
                                var json1 = {
                                    "inHosNo": item1.inHosNo,
                                    "synUserName": "",
                                    "synKey": "",
                                    "bedNo": item1.bedNo,
                                    "departmentorganId": item1.departmentorganId
                                };
                                $.ajax({
                                    url: "../his/request",
                                    method: "POST",
                                    dataType: 'json',
                                    data: {
                                        api: "/queryarrears",
                                        dataParam: JSON.stringify(json1)
                                    },
                                    success: function (result1) {
                                        if (result1 != null) {
                                            if (result1.resultCode === "00") {
                                                $('#noData').hide();
                                                if (result1.payList !== null) {
                                                    console.log(result1);
                                                    $.each(result1.payList, function (i, item) {
                                                        var data = JSON.stringify(item);
                                                        $('.appolist ul').append("<li>\n" +
                                                                "                <h5>患者姓名："+item.patientName+"</h5>\n" +
                                                                "                <cite>科室名称:"+item.departmentName+"</cite>\n" +
                                                                "                <cite>床号:"+item.bedNo+"</cite>\n" +
                                                                "                <cite>押金余额:"+item.depositMoney+"元</cite>\n" +
                                                                "                <cite>补缴上限:"+item.uppeLimit+"元</cite>\n" +
                                                                "                <cite>补缴下限:"+item.lowerLimit+"元</cite>\n" +
                                                                "                <i\n" +
                                                                "id='" + item.bedNo + "' onclick='delPatient("+data+")' class=\"defaubq\">缴费</i></div>\n" +
                                                                "                <span>待缴费</span>\n" +
                                                                "            </li>")

                                                    });
                                                    return;
                                                }
                                            }
                                        }
                                        $.toast(result1);
                                        $('#noData').show();
                                    },
                                    error: function (e) {
                                        $.toast("病人不存在记录");
                                    }
                                });
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

    function delPatient(data) {
        var depositMoney = data.depositMoney;
        $('.c-conf-screen').show();

        $(".cancel").click(function () {
            $('.c-conf-screen').hide();
        });
        $('.comfirm').click(function () {
            $.ajax({
                url: "../DBList/payment",
                method: "POST",
                dataType: 'json',
                data: {
                    "payMoney": data.depositMoney,
                    "bedNo": data.bedNo,
                    "inHosNo": inHosNo
                },
                success: function (result) {
                    if (result != null) {
                        if (result.code === "SUCCESS") {
                           var outTradeNo=result.orderNo;
                            $.ajax({
                                url: "../his/jsPay",
                                method: "POST",
                                dataType: 'json',
                                data: {
                                    payAount:depositMoney,
                                   // payAount: "0.01",
                                    openId: window.localStorage.getItem("openId"),
                                    //openId:"oKuwuv3YYG5Cfmf2DIasC2ZMkydU",
                                    outTradeNo:outTradeNo
                                },
                                success: function (result) {
                                    if (result != null) {
                                        if (result.code == '0') {
                                            var data = JSON.stringify(result.data);
                                            toPay(data);
                                            return;
                                        }
                                    }
                                },
                                error: function (e) {
                                    $.toast("获取失败，请稍后再试!");
                                }
                            });
                        }
                    }
                },
                error: function (e) {
                    $.toast("获取失败，请稍后再试!");
                }
            });
        });
    }

    function toPay(result) {
        var jsonData = JSON.parse(result);
        var prepay_id = "prepay_id=" + jsonData.prepayid;

        WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId": jsonData.appid,     //公众号名称，由商户传入
                    "timeStamp": jsonData.timestamp,         //时间戳，自1970年以来的秒数
                    "nonceStr": jsonData.noncestr, //随机串
                    "package": prepay_id,
                    "signType": "MD5",         //微信签名方式：
                    "paySign": jsonData.sign//微信签名
                },
                function (res) {
                    if (res.err_msg == "get_brand_wcpay_request:ok") {
                        $.toast("缴费成功！");
                        window.location.href = '../hosp/hospitalizationExpenses'
                        // 使用以上方式判断前端返回,微信团队郑重提示：
                        //res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
                    }
                });
    }


</script>
</body>
</html>