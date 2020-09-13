<!DOCTYPE html>
<html ng-app="app">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<title></title>
		<style type="text/css">
		</style>
	</head>

	<body ng-controller="depositController">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">押金明细</h1>
				</header>
				<div class="content">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">住院流水号</div>
									<div class="item-after">{{depositDeatil.inHosSerialNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">预缴金金额</div>
									<div class="item-after">{{depositDeatil.payMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">操作员</div>
									<div class="item-after">{{depositDeatil.operatorNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">缴费时间</div>
									<div class="item-after">{{depositDeatil.payDate}}</div>
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
			app.controller('depositController', ['$scope', '$http', function($scope, $http){
				$scope.depositDeatil = {
						inHosSerialNo: '10620180002',
						payMoney:'3000.00',
						operatorNo:'1',
						payDate:'2018-04-01'
				}
			}]);
		</script>
	</body>

</html>