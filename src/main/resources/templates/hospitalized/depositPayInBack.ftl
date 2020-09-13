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

	<body ng-controller="payInBackController">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">押金补缴</h1>
				</header>
				<div class="content">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">姓名</div>
									<div class="item-after">{{payInBack.patientName}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">科室名称</div>
									<div class="item-after">{{payInBack.departmentName}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">床号</div>
									<div class="item-after">{{payInBack.bedNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">押金余额</div>
									<div class="item-after">{{payInBack.depositMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">补缴上限</div>
									<div class="item-after">{{payInBack.uppeLimit}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">补缴下限</div>
									<div class="item-after">{{payInBack.lowerLimit}}</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="content-block">
						<p>
							<a href="#" class="button button-big button-fill">补缴 </a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
			var app = angular.module("app",[]);
			app.controller('payInBackController', ['$scope', '$http', function($scope, $http){
				$scope.payInBack = {
						patientName: '张三',
						departmentName:'内科',
						bedNo:'1',
						depositMoney:'3000.00',
						uppeLimit:'3000.00',
						lowerLimit:'1000.00'
				}
			}]);
		</script>
	</body>

</html>