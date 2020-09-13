<!DOCTYPE html>
<html ng-app="app">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<script type="text/javascript" src="${ctx.contextPath}/js/lib/angular.js"></script>
		<title></title>
		<style type="text/css">
			.time-period {
				display: inline-block;
				width: 7rem;
				height: 1.5rem;
				line-height: 1.5rem;
				text-align: center;
				border-radius: 4px;
				background: green;
				color: #fff;
			}
		</style>
	</head>

	<body ng-controller="clincTimeController">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">查询物品</h1>
				</header>
				<div class="content" style="top=0rem; font-size: 14px;">
                        <div class="list-info" style="margin: 0" id="noneInfo">
                            <ul id ="selectInfo">

                            </ul>
                        </div>
				</div>
			</div>
		</div>
		<script>
            $(document).ready(function () {
                getQueryString();
               seachString = getQueryString("seachString");
               seachType = getQueryString("seachType");
                funcionInfo();

            });
            var seachString=null;
            var seachType=null;

            function getQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return decodeURI(r[2]);
                return null;
            }
            function funcionInfo() {
                var pagenumber=1;
                var count=200;
                var data={
                    "seachString":seachString,
                    "seachType":seachType,
                    "pagenumber":pagenumber,
                    "count":count

                };
                $.ajax({
                    url: "../his/request",
                    method: "POST",
                    dataType: 'json',
                    data: {
                        api: "/Seachitem",
                        dataParam: JSON.stringify(data)
                    },
                    async: false,
                    success: function (result) {

                        var msg = "";
                        if (result != null) {
                            if (result.resultCode === '00') {
                                $.toast("查询成功!");
                                if (result.resultMsg === "成功") {
                                    msg = result.resultMsg;
                                    var list = result.returnList;
                                    $.each(result.returnList, function (i, item) {
                                        if(item.Type=="1"){
                                            var Type="药品"
                                        }else{
                                            var Type="非药品"
                                        }
                                        $("#selectInfo").append("<li class=\"islink\">\n"+ "<div class=\"c-list-mess\">\n" + "<h4><span class=\"c-f15 c-333 mr5\">"+"名称类型"+":" +Type + "</span></h4>\n" + " <p class=\"c-nowrap mt5\">" +"物品名称"+":"+ item.Name + "</p>\n" + " <p class=\"c-nowrap mt5\">" +"规格"+":"+ item.spec + "</p>\n" +" <p class=\"c-nowrap mt5\">"+"价格"+":" + item.price +"元"+ "</p>\n" +" <p class=\"c-nowrap mt5\">" +"产地"+":"+ item.manufacturerName + "</p>\n" +"</div>\n" + " </li>")

                                    });
                                }
                            }

                        }
                        $.toast(msg);

                    },
                    error: function () {
                        $.toast("服务器维护中,稍后重试!");
                    }
                });
            }

		</script>
	</body>

</html>