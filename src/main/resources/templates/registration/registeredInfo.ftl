<!DOCTYPE html>
<html ng-app="app">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet" href="../css/sm.min.css">
    <link rel="stylesheet" href="../css/kdui/min.css">
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <title>确任挂号信息</title>
</head>

<body ng-controller="clincTimeController">
<div class="page-group">
    <div class="page">
        <header style="height: 0px;" class="bar bar-nav">
        </header>
        <div class="content" style="top: 0rem;font-size: 14px;">
            <div class="card"
                 style="display: flex;flex-direction: column;border-radius: 5px;padding: 8px;font-size: 14px; ">
                <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                    <span style="width: 50%">费用</span>
                    <span id="consultationFee" style="width: 50%;text-align: right;"></span>
                </div>
                <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                    <span style="width: 50%">科室</span>
                    <span id="locationName" style="width: 50%;text-align: right;"></span>
                </div>
                <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                    <span style="width: 50%">医生</span>
                    <span id="doctorName" style="width: 50%;text-align: right;"></span>
                </div>
                <div style="height: 40px;line-height:40px;display: flex;flex-direction: row;">
                    <span style="width: 65%">就诊时间</span>
                    <span id="sourceDate" style="width: 25%;"></span>
                    <span id="sourceTimeType" style="width: 10%;"></span>
                   <#-- <select name="sourceTimeType" id="sourceTimeType" disabled="disabled">
                        <option value="1">上午</option>
                        <option value="2">下午</option>
                        <option value="3">晚上</option>
                    </select>-->
                </div>

            </div>

            <p style="margin-left: 15px;">选择就诊人</p>

            <div id="user" class="card"
                 style="display: flex;flex-direction: column;border-radius: 5px;padding: 5px;font-size: 14px;">
            </div>

            <div class="list-info" style="margin: 0; display: none;" id="noneInfo">

            </div>

            <div class="content-block">
                <p style="height: 40px;font-size: 16px; line-height: 40px;" class="button button-big button-fill"  onclick="jsPay()">确认支付</p>
                <span style="font-size:15px;color:#d70f18">温馨提示：</span>
                <p style="font-size:14px;margin-top: 2px; color: #d70f18">1.挂号后如不就诊，请于当天申请取消挂号并申请退费。</p>
                <p style="font-size:14px;margin-top: -12px;color: #d70f18">2.完成预约后，请于就诊当天到1号楼一楼或者2号楼二楼自助挂号机取号就诊。</p>
                <p style="font-size:14px;margin-top: -12px;color: #d70f18">3.请在预约时间前取号就诊。</p>
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
    </div>

</div>

<script>
    //微信订单号
    var payNo = null;
    //商户订单号
    var outTradeNo = null;
    var sourceDate=null;
    var consultationFee=null;
    var openId=null;

    var organdoctorId=null;
    var departmentorganId=null;
    var sourceTimeType=null;

    var selCarNo='';
    function selectUser(item){
        selCarNo=item;
    }

    function jsPay() {
        sourceDate = getQueryString("sourceDate");
        //线上改成这个
         consultationFee = getQueryString("consultationFee");
        //线下测试
        //consultationFee="0.01";
        sourceDate = getQueryString("sourceDate");
        openId = window.localStorage.getItem("openId");

        var patientNo = $('#user input[name="user"]:checked ').val();
        if(patientNo ==''|| patientNo==null||patientNo== undefined){
            $.toast("请选择就诊卡号!");
            return
        }
        console.log(selCarNo)
        var obj = new Function("return" + selCarNo)();
        var cardNo = obj.IDCardno.toString();

        organdoctorId = getQueryString("organdoctorId");
        departmentorganId = getQueryString("departmentorganId");
        sourceTimeType = getQueryString("sourceTimeType");
        //本地支付新增本地记录
        $.ajax({
            url: "../DBList/outpatientPayment",
            method: "POST",
            dataType: 'json',
            data: {
                "organdoctorId":organdoctorId,
                "departmentorganId":departmentorganId,
                "patientNo":patientNo,
                "socialsecurityNO":"",
                "sourceDate":sourceDate,
                "timestypeNo":"0",
                "sourceTimeType":sourceTimeType,
                "payAmount":consultationFee,
                "cardNo":cardNo
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
                                payAount: consultationFee,
                               // payAount: "0.01",
                                openId: openId,
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
                $.toast("挂号失败，请稍后再试!");
            }
        });
    }

    function addpsonpopclose() {
        $(".addpsonpop").hide();
    }


    $(document).ready(function () {

        $('#consultationFee').text(getQueryString("consultationFee") + "元");
        $('#locationName').text(getQueryString("locationName"));
        $('#doctorName').text(getQueryString("doctorName"));
        $('#sourceDate').text(getQueryString("sourceDate"));
       // $('#sourceTimeType').text(getQueryString("sourceTimeType"));
        var sourceTimeTypeInfo = getQueryString("sourceTimeType");
        if(sourceTimeTypeInfo=="1"){
            sourceTimeTypeInfo="上午";
            $('#sourceTimeType').text(sourceTimeTypeInfo);
        }else if(sourceTimeTypeInfo=="2"){
            sourceTimeTypeInfo="下午";
            $('#sourceTimeType').text(sourceTimeTypeInfo);
        }else if(sourceTimeTypeInfo=="3"){
            sourceTimeTypeInfo="晚上";
            $('#sourceTimeType').text(sourceTimeTypeInfo);

        }
        queryPatients();

    });



    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return null;
    }


    //获取就诊人列表
    function queryPatients() {
        var json = {
            "id":window.localStorage.getItem("openId"),
            //"id": "oKuwuv3fRIi_C26FkR6W0OzOtSBk",
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
                                $('#idCardno').text(list[0].IDCardno);
                                $('#name').text(list[0].Name);
                                $('#cardNo').text("(就诊卡号:" + list[0].CardNo + ")");
                                $.each(result.myIdList, function (i, item) {
                                    var data = JSON.stringify(item);
                                    var rak = "(就诊卡号" + item.CardNo + ")";
                                    $('#user').append("<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\" >\n" +
                                            "                    <input  value='"+item.IDCardno+"' name='idCardno' style=\"display: none;\"/>\n" +
                                            "                    <input onchange = selectUser('"+data+"') value='"+item.CardNo+"' name='user' style=\"margin-top: 15px;\" type=\"radio\"/>\n" +
                                            "                    <span style=\"width: 50%;margin-left: 5px;\">" + item.Name + "</span>\n" +
                                            "                    <span style=\"width: 50%;text-align: right;\">" + rak + "</span>\n" +
                                            "                </div>")
                                });
                            }
                            return
                        }
                    }
                }
                $('.addpsonpop').show();
                $('.content').hide();
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }
    function sleep(numberMillis) {
        var now = new Date();
        var exitTime = now.getTime() + numberMillis;
        while (true) {
            now = new Date();
            if (now.getTime() > exitTime)
                return true;
        }
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
                        // $.toast("支付成功，正在生成预约订单，请稍后!");
                        $.toast('支付成功，正在排队预约，请稍后!', 2000);
                        //睡眠2秒钟
                        sleep(1500);
                        $.ajax({
                            url: "../DBList/getTransactionId",
                            method: "POST",
                            dataType: 'json',
                            data: {
                                outTradeNo:outTradeNo
                            },
                            success: function (result) {
                                if (result != null) {
                                    if (result.code == 'SUCCESS') {
                                        payNo = result.transactionId;
                                        if(null == result.transactionId || '' == result.transactionId){
                                            var payResultMsg = result.resultMsg;
                                            if(result.resultMsg ==''||result.resultMsg==null){
                                                payResultMsg=""
                                            }
                                            alert("预约失败,稍后再试"+payResultMsg);
                                             window.location.href = '../his/index'
                                            }else{
                                            if(result.successfulPayment=="1"){
                                                $.toast("恭喜您,预约成功!");
                                                alert("温馨提示：1.挂号后如不就诊，请于当天申请取消挂号并申请退费。2.完成预约后，请于就诊当天到1号楼一楼或者2号楼二楼自助挂号机取号就诊。3.请在预约时间前取号就诊。");
                                                window.location.reload();
                                                window.location.href = '../user/reservationRecord'
                                            }else if(result.successfulPayment=="2") {
                                                var payResultMsg = result.resultMsg;
                                                if(result.resultMsg ==''||result.resultMsg==null){
                                                    payResultMsg=""
                                                }
                                                alert("预约失败,稍后再试"+payResultMsg);
                                                window.location.href = '../his/index'
                                            }
                                        }
                                    }
                                }
                            },
                            error: function (e) {
                                $.toast("获取失败，请稍后再试!");
                            }
                        });

                        // 使用以上方式判断前端返回,微信团队郑重提示：
                        //res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
                    }
                });
    }

</script>
</body>
</html>