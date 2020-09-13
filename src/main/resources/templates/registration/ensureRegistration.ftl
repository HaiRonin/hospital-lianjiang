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

	<body ng-controller="ensureController">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">确认挂号信息</h1>
				</header>
				<div class="content">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">诊查费</div>
									<div class="item-after">{{info.regDoctor.payAmount}}元</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">科室</div>
									<div class="item-after">{{info.department.name}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">医生</div>
									<div class="item-after">{{info.doc.name}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">就诊时间</div>
									<div class="item-after">{{info.regDoctor.sourceDate}} {{info.regDoctor.sourceTimeType}}</div>
								</div>
							</li>
						</ul>
					</div>

					<div class="content-block-title">选择就诊人</div>
					<div class="list-block">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">{{user.name}}</div>
									<div class="item-after">就诊卡:{{user.visitCardNo}}</div>
								</div>
							</li>
						</ul>
					</div>

					<div class="content-block">
						<p>
							<a href="#" class="button button-big button-fill">确定挂号 </a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
			var app = angular.module("app",[]);
			app.controller('ensureController', ['$scope', '$http', function($scope, $http){
                window.localStorage.setItem("sourceTimeType", info.regDoctor.sourceTimeType);
				$scope.info = {
						regDoctor: {
							sourceDate: '2018-04-11',
							sourceTimeType: '上午',
							payAmount: '30',
						},
						doc: {
							name: '张三'
						},
						department: {
							name : '外科'
						}
				};
				$scope.user = {
						name: '刘二',
						visitCardNo :'200900013'
				};
			}]);
		</script>
	</body>

</html>