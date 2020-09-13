<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/base.css" type="text/css"/>
        <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
        <script type="text/javascript" src="../js/common.js"></script>
		<title></title>
		<style type="text/css">
			.header-cont {
				height: 2rem;
				line-height: 2rem;
				padding-left: 1rem;
				background: #FFFFFF;
				border-bottom: #ccc;
			}
			.time {
				font-size: .6rem;
				color: #aaa;
			}
			.order-state-cancel{
				display: inline-block;
				float: right;
				color: #aaa;
			}
			.order-state-timeover{
				display: inline-block;
				float: right;
				color: orange;
			}
		</style>
	</head>

	<body>
		<#--<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">挂号记录</h1>
				</header>
				<div class="content">
					<div class="header-cont">就诊人： 刘二(就诊卡:20180001)</div>

					<div class="card">
						<div class="card-content">
							<div class="card-content-inner">
								<div>挂号:甲状腺外科-张三</div>
								<div>30.00元<span class="order-state-cancel">取消预约(已退费)</span></div>
								<div class="time">订单生成时间:2018-04-04 11:09:33</div>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-content">
							<div class="card-content-inner">
								<div>挂号:甲状腺外科-张三</div>
								<div>30.00元<span class="order-state-timeover">支付成功</span></div>
								<div class="time">订单生成时间:2018-04-03 11:09:33</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
		</script>-->

        <div class="c-main pb15 appoin">
            <h4>就诊人：<span id="name"></span><span id="cardNo"></span>
            </h4>
            <div class="appolist" style="overflow-y:auto;">
                <ul>
                </ul>
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

	</body>

</html>
<script>
    $().ready(function(){
        var height = ($(window).height()-110) + "px";
        $(".appolist").css("height",height);
    });
    $.showPreloader('加载中...');
    $(function () {
        $('.selectbg').hide();
        firsDayOfMonth = this.fun_date(-30);
       currDay = this.fun_date(1);
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
                        }
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }

    var firsDayOfMonth = "";
    var currDay = "";

    function querypaymentrecordlist(item) {
        $(".selectbg").hide();
        $('#name').text(item.Name);
        $('#cardNo').text("(住院号" + item.inHosNo + ")");
        var json = {
            "CardNo": item.CardNo,
            "synUserName":"",
            "synKey":"",
            "startDate":firsDayOfMonth,
            "endDate":currDay
        };
        $('.appolist ul').empty();
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/QueryReg",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                console.log(result);
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.returnList !== null) {
                            $.each(result.returnList, function (i, item) {
                                var consultationFee = Number(item.consultationFee).toFixed(2);
                                $('.appolist ul').append("<li>\n" +
                                        "                <h5>挂号：" + item.LocationName + "-" + item.DoctorName + "</h5>\n" +
                                        "                 <cite><p>是否已就诊：" + item.IsConsultation + "</p></cite>\n" +
                                        "                 <cite><p>挂号费用：" + consultationFee + "元</p></cite>\n" +
                                        "                 <cite>挂号日期：" + item.sourceDate + "</cite>\n" +
                                        "            </li>")
                            });
                            return;
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