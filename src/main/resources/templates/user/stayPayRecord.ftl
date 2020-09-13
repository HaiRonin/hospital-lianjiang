<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>待缴费处方记录</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<div class="c-main pb15 appoin">
    <h4>就诊人：<span id="name">*</span><span id="cardNo">（ 就诊卡号：* ）</span><span id="hiFeeNos" style="display: none"></span></h4>
    <p style="font-size:14px;margin-top: 2px; color: #d70f18;margin-left:10px;">温馨提示：如需退费，请到收款处退费.</p>
    <div class="appolist" style="display:block" id="appolistInfo">
        <ul>
        </ul>
        <div id="noData" hidden="true"
             style="position: absolute;top: 50%;left: 50%;margin-top: -50px;margin-left: -76.5px;">
            <img style="width: 153px;height: 100px;" src="../images/nodata.png">
            <p style="margin-top: 10px;width: 153px;text-align: center;color: #eeeeee;">暂无记录</p>
        </div>

    </div>
    <div id="hadData" class="content-block" style="display: block">
        <div style="content: text-align;margin-bottom:33px">
            <span style="width:50%;font-size: 17px;color: #d70f18" >医院门诊缴费合计</span>
            <span id="sum" style="width:30%;font-size: 17px;color: #d70f18"></span>
            <span style="width:20%;font-size: 17px;color: #d70f18">元</span>
        </div>
        <p style="height: 40px;font-size: 16px; line-height: 40px;" class="button button-big button-fill"
           onclick="jsPay()">确定</p>
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
                            var list = result.myIdList
                            if (list.length > 0) {
                                $('#hiFeeNos').text(list[0].hiFeeNos);
                                $('#name').text(list[0].Name);
                                $('#cardNo').text("(门诊ID号" + list[0].CardNo + ")");
                                querytopayrecipeinfolist(list[0]);
                                $.each(result.myIdList, function (i, item) {
                                    var data = JSON.stringify(item);
                                    $('.selectext ul').append("<li onclick='querytopayrecipeinfolist(" + data + ")'>" + item.Name +" </li>")
                                    $('#user').append("<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                            "                    <input  value='"+item.hiFeeNos+"' name='hiFeeNos' style=\"display: none;\"/>\n" +
                                            "                </div>")
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
    var sum = null;
    var hiFeeNosSum = null;
    var patientNo=null;
    function querytopayrecipeinfolist(item) {
        sum=0;
        hiFeeNosSum = null;
        $('.appolist ul').html("");
        console.log(item)
        $(".selectbg").hide();
        patientNo=item.CardNo;
        $('#name').text(item.Name);
        //$('#cardNo').text("(就诊卡号" + item.CardNo + ")");
        $('#cardNo').text("(就诊卡号"+item.CardNo+",门诊号"+item.PatientNo+")");
        var json = {
            "medicareType": "0",
            "patientNo": item.CardNo,
            "synUserName": "",
            "synKey": ""
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querytopayrecipeinfolist",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.hiFee.length>0) {
                            $('#noData').hide();
                            $.each(result.hiFee, function (i, item) {
                                var data = JSON.stringify(item);
                               // sum = parseFloat(sum)+parseFloat(item.settleAmount);
                                var hiFeeNos=item.hiFeeNo;
                                if(hiFeeNosSum == "undefined" || hiFeeNosSum == null || hiFeeNosSum == ""){
                                    hiFeeNosSum=hiFeeNos;
                                }else{
                                    hiFeeNosSum=hiFeeNosSum+","+hiFeeNos;
                                }
                                    $('#hadData').show();
                                    $('.appolist ul').append("<li onclick='details("+data+")'>\n" +
                                            "                <h5>类型："+item.organName+"</h5>\n" +
                                            "                <cite>总金额："+item.patientAmount+"元</cite>\n" +
                                            "                <em>下订单时间："+item.createTime+"</em>\n" +
                                            "                <span>待缴费</span>\n" +
                                            "            </li>")
                            });
                            hiFeeNosSum = hiFeeNosSum + "@" + result.hiFee[0].patientNo;
                            $('#sum').text(result.hiFee[0].settleAmount);
                            sum = parseFloat(result.hiFee[0].settleAmount);
                            return;
                        }
                        $('#noData').show();
                        $('#hadData').hide();
                    }
                }
                $('#hadData').hide();
                $('#noData').show();
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }

    function jsPay() {
        //本地支付新增本地记录
        $.ajax({
            url: "../DBList/newPayment",
            method: "POST",
            dataType: 'json',
            data: {
                synUserName:"",
                synKey:"",
                hiFeeNos:hiFeeNosSum,
                payMoney:sum,
                medicareType:"0"
                  },
            success: function (result) {
                if (result != null) {
                    if (result.code == 'SUCCESS') {
                        outTradeNo=result.orderNo;
                        $.ajax({
                            url: "../his/jsPay",
                            method: "POST",
                            dataType: 'json',
                            data: {
                                payAount: sum,
                                openId: window.localStorage.getItem("openId"),
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
                $.toast("缴费失败，请稍后再试!");
            }
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
                        window.location.reload();
                        // 使用以上方式判断前端返回,微信团队郑重提示：
                        //res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
                    }
                });
    }

    function details(data) {
        var hiFeeNo = data.hiFeeNo;
        window.location.href = '../user/stayPayRecordList?patientNo=' + patientNo +"&hiFeeNo="+hiFeeNo ;
    }


</script>
</body>
</html>