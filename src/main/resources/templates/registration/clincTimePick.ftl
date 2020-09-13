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
					<h1 class="title">选时间</h1>
				</header>
				<div class="content">
					<div class="card">
						<div class="card-content">
							<div class="list-block media-list">
								<ul>
									<li class="item-content">
										<div class="item-media">
											<img src="{{doc.photoUrl}}" width="70">
										</div>
										<div class="item-inner">
											<div class="item-title-row">
												<div class="item-title">{{doc.name}}</div>
											</div>
											<div class="item-subtitle">{{doc.job}}</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="card-footer">
							<span>医学专长：{{doc.specialty}}</span>
						</div>
					</div>

					<div class="list-block cards-list">
						<ul>
							<li class="card" ng-repeat="item in timePicks.time">
								<div class="card-content">
									<div class="card-content-inner">
										{{item.sourceDate}}
									</div>
								</div>
								<div class="card-footer">
									<div><span class="time-period">{{item.sourceTimeType}}</span> &nbsp;&nbsp; <span style="color: red;">{{item.payAmount}}</span>元</div>
									<div><a href="#" class="item-link item-content">可挂号<span class="icon icon-right"></span></a></div>
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
			app.controller('clincTimeController', ['$scope', '$http', function($scope, $http){
				//医生信息
				$scope.doc = {
						photoUrl :'/hospital/image/doc.png',
						name: '张三',
						job: '主任医师',
						specialty: '甲状腺疾病专家。从事临床一年工作十余年。'
				}
				//时间段
				$scope.timePicks = {
					time: [{
						sourceDate: '2018-04-11',
						sourceTimeType: '上午',
						payAmount: '30'
					},{
						sourceDate: '2018-04-11',
						sourceTimeType: '下午',
						payAmount: '30'
					},{
						sourceDate: '2018-04-11',
						sourceTimeType: '晚上',
						payAmount: '30'
					}]
				};
				
			}]);
		</script>
	</body>

</html>