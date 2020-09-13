<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>住院信息</title>
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

    <div style="margin-top: 10px;position: relative">
        <div class="list-block" style="margin-top: 10px;font-size: 14px;">
            <ul>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">患者姓名</div>
                        <div id="patientName" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">性别</div>
                        <div id="patientSex" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">身份证号</div>
                        <div id="cardNo1" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">住院日期</div>
                        <div id="inHosDate" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">科室名称</div>
                        <div id="departmentName" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">是否住院</div>
                        <div id="inHosState" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">床号</div>
                        <div id="bedNo" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">医保类型代码</div>
                        <div id="medicalTypeCode" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">医保类型名称</div>
                        <div id="medicalTypeNmae" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">医保统筹金额</div>
                        <div id="overMoney" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">医保记账自费金额</div>
                        <div id="payMoney" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">自费金额</div>
                        <div id="cashMoney" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">押金余额</div>
                        <div id="depositMoney" class="item-after"></div>
                    </div>
                </li>
                <li class="item-content">
                    <div class="item-media"><i class="icon icon-f7"></i></div>
                    <div class="item-inner">
                        <div class="item-title">总费用</div>
                        <div id="totalMoney" class="item-after"></div>
                    </div>
                </li>

            </ul>
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
                                $('#cardNo').text("(就诊卡号" + list[list.length - 1].CardNo + ")");
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
        console.log(item);

        $(".selectbg").hide();
        $('#name').text(item.Name);
        $('#cardNo').text("(住院号" + item.inHosNo + ")");
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
                            if (inHosList.length > 0) {
                                var item = inHosList[0];
                                $("#patientName").text(item.patientName);
                                $("#patientSex").text(item.patientSex=='0'?'女':'男');
                                $("#cardNo1").text(item.cardNo);
                                $("#departmentName").text(item.departmentName);
                                var inHosState ='';
                                if(item.inHosState =='0'){
                                    inHosState = '无住院';
                                }else if(item.inHosState =='1'){
                                    inHosState = '申请中';
                                }else if(item.inHosState =='2'){
                                    inHosState = '入院中';
                                }else {
                                    inHosState = '已出院';
                                }
                                $("#inHosState").text(inHosState);
                                $("#cashMoney").text(item.cashMoney==''?'0.00元':item.cashMoney+"元");
                                $("#depositMoney").text(item.depositMoney==''?'0.00元':item.depositMoney+"元");
                                $("#totalMoney").text(item.totalMoney ==''?'0.00元':item.totalMoney+"元");
                                $("#bedNo").text(item.bedNo);
                                $("#inHosDate").text(item.inHosDate.substring(0,10));
                                $("#medicalTypeCode").text(item.medicalTypeCode);
                                $("#medicalTypeNmae").text(item.medicalTypeNmae);
                                $("#overMoney").text(item.overMoney==0?'0.00元':item.overMoney+"元");
                                $("#payMoney").text(item.payMoney==0?'0.00元':item.payMoney+"元");

                                $('.list-block ul').show();
                                return;

                            }
                        }
                    }
                   // $('#noData').show();
                    $.toast("无住院信息");
                    $('.addInHosNo').show();
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