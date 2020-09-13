<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<script type="text/javascript" src="${ctx.contextPath}/js/lib/angular.js"></script>
		<title></title>
	</head>

	<body ng-app="app">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">我的信息</h1>
				</header>
				<div class="content" ng-controller="InfoController">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">姓名</div>
									<div class="item-after">{{user.patientName}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">性别</div>
									<div class="item-after">{{user.patientSex}}</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="list-block">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">二代身份证</div>
									<div class="item-after">{{user.patientIdcardNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">手机号</div>
									<div class="item-after">{{user.patientTelephone}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">就诊卡号</div>
									<div class="item-after">{{user.CardNo}}</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="content-block">
						<a href="#" class="button button-big button-fill">删除就诊人</a>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
			var app = angular.module("app",[]);
			app.controller('InfoController', ['$scope', '$http', function($scope, $http){
				$scope.user = {
					patientName: '刘二',
					patientSex: '男',
					patientIdcardNo: '4******************3',
					patientTelephone: '134****2355',
					CardNo: '20080001'
				};
			}]);
		</script>
	</body>
</html>