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
		</style>
	</head>

	<body ng-controller="hospDetailController">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">住院清单</h1>
				</header>
				<div class="content">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">记账日期</div>
									<div class="item-after">{{hospDetail.chargeDate}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">药品分类</div>
									<div class="item-after">{{hospDetail.drugType}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">项目编码</div>
									<div class="item-after">{{hospDetail.projectCode}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">项目名称</div>
									<div class="item-after">{{hospDetail.projectName}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">单价</div>
									<div class="item-after">{{hospDetail.feeItemAmount}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">数量</div>
									<div class="item-after">{{hospDetail.feeItemNum}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">单位</div>
									<div class="item-after">{{hospDetail.feeItemUnit}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">总价</div>
									<div class="item-after">{{hospDetail.feeItemAllAmount}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">规格</div>
									<div class="item-after">{{hospDetail.feeItemStandard}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">扣费时间</div>
									<div class="item-after">{{hospDetail.payDate}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">可记账金额</div>
									<div class="item-after">{{hospDetail.amountMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">医保记账自费部分</div>
									<div class="item-after">{{hospDetail.MmedicareMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">纯自费金额</div>
									<div class="item-after">{{hospDetail.payMoney}}</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
			var app = angular.module("app",[]);
			app.controller('hospDetailController', ['$scope', '$http', function($scope, $http){
				$scope.hospDetail = {
						chargeDate: '2018-04-06',
						drugType:'非处方',
						projectCode:'0201',
						projectName:'西药费',
						feeItemAmount:'98.50',
						feeItemNum:'10',
						feeItemUnit:'盒',
						feeItemAllAmount:'985.00',
						feeItemStandard:'12X3',
						payDate:'2018-04-06',
						amountMoney:'300.00',
						MmedicareMoney:'300.00',
						payMoney:'385.00'
				}
			}]);
		</script>
	</body>

</html>