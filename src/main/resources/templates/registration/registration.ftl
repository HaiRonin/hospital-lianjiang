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
			.col-40 .list-block ul li {background: #33b478; color: white;}
			.active {background: white !important; color: black !important;}
		</style>
	</head>

	<body ng-controller="regisController">
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">挂号</h1>
				</header>
				<div class="bar bar-header-secondary">
					<div class="searchbar">
						<a class="searchbar-cancel">取消</a>
						<div class="search-input">
							<label class="icon icon-search" for="search"></label>
							<input type="search" id='search' placeholder='请输入关键字...' />
						</div>
					</div>
				</div>
				<div class="content">
					<div class="content-padded grid-demo">
						<div class="row no-gutter">
							<div class="col-40">
								<div class="list-block">
									<ul>
										<li ng-repeat="item in depas.depa" ng-click="showSubItem($event,item.clinc)" class="item-content">
											<div class="item-inner">
												<div class="item-title">{{item.name}}</div>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-60">
								<div class="list-block">
									<ul>
										<li ng-repeat="item in clincs">
											<a href="#" class="item-link item-content">
												<div class="item-media"><i class="icon icon-f7"></i></div>
												<div class="item-inner">
													<div class="item-title">{{item.name}}</div>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
			var app = angular.module("app",[]);
			app.controller('regisController', ['$scope', '$http', function($scope, $http){
				$scope.depas = {
					depa: [{
						name: '内科',
						clinc: [{
							name: '呼吸内科门诊'
						},{
							name: '消化内科门诊'
						},{
							name: '血液内科门诊'
						},{
							name: '内分泌内科门诊'
						},{
							name: '肿瘤内科门诊'
						},{
							name: '肾病内科门诊'
						},{
							name: '腹膜透析门诊'
						},{
							name: '内科普通门诊'
						},{
							name: '肾病内科门诊'
						},{
							name: '肾病内科门诊'
						},{
							name: '肾病内科门诊'
						}]
					},{
						name: '外科',
						clinc: [{
							name: '胃肠外科门诊'
						},{
							name: '神经外科门诊'
						},{
							name: '心脏外科门诊'
						},{
							name: '骨外科门诊'
						},{
							name: '外科普通门诊'
						}]
					},{
						name: '儿科',
						clinc: [{
							name: '儿科门诊'
						},{
							name: '儿科行为中心'
						}]
					},{
						name: '耳鼻喉科',
						clinc: [{
							name: '耳鼻喉科门诊'
						},{
							name: '鼻科门诊'
						},{
							name: '耳科门诊'
						},{
							name: '咽喉头颈科门诊'
						}]
					},{
						name: '神经科',
						clinc: [{
							name: '神经科门诊'
						}]
					}]
				};
				
				$scope.showSubItem = function(event, depa){
					$(event.currentTarget).addClass("active").siblings().removeClass("active");
					$scope.clincs = depa;
				}
			}]);
		</script>
	</body>

</html>