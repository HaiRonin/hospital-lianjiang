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
			.buttons-tab a {
				display: inline-block;
				height: 4rem;
				width: 20%;
				text-align: center;
				padding-top: .5rem;
				position: relative;
			}
			
			.buttons-tab a span:first-child {
				position: absolute;
				width: 20px;
				height: 30px;
				top: .6rem;
				left: 50%;
			}
			
			.buttons-tab a span:last-child {
				position: absolute;
				width: 20px;
				height: 30px;
				top: 2rem;
			}
		</style>
	</head>

	<body>
		<div class="page-group">
			<div class="page" ng-controller="clincController">
				<header class="bar bar-nav">
					<h1 class="title">{{clinc.clincName}}门诊挂号</h1>
				</header>
				<div class="content">
					<div class="buttons-tab">
						<a href="{{item.href}}" class="tab-link" ng-repeat="item in clinc.time" ng-if="$index < 4"><span>{{item.week}}</span> <span>{{item.day}}</span></a>
						<a href="#" class="tab-link">收起</a>
					</div>
					<div class="buttons-tab">
						<a href="{{item.href}}" class="tab-link" ng-repeat="item in clinc.time" ng-if="$index > 3"><span>{{item.week}}</span> <span>{{item.day}}</span></a>
						<a href="#" class="tab-link "></a>
					</div>

					<div class="card">
						<div class="card-content">
							<div class="card-content-inner">
								温馨提示：我院于2017年1月1日起全面实施实名制挂号，未办理实名认证的诊疗卡号将无法挂号。为保证广大患者的权利，多次取消预约挂号将导致您无法预约，请珍惜您的预约挂号权利。
							</div>
						</div>
					</div>

					<div class="tabs">
						<div class="tab" ng-repeat="doc in docsInfo" id="{{doc.tabId}}">
							<div class="card" ng-repeat="item in doc.docs">
								<div class="card-content">
									<div class="list-block media-list">
										<ul>
											<li class="item-content">
												<div class="item-media">
													<img src="{{item.picSrc}}" width="60">
												</div>
												<div class="item-inner">
													<div class="item-title-row">
														<div class="item-title">{{item.name}}</div>
													</div>
													<div class="item-subtitle">{{item.position}}</div>
												</div>
											</li>
										</ul>
									</div>
								</div>
								<div class="card-footer">
									<span>剩余<span style="color: red;">{{item.rest}}</span>个号</span>
									<a href="#" class="item-link item-content"><span class="icon icon-right"></span></a>
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
			app.controller('clincController', ['$scope', '$http', function($scope, $http){
				$scope.clinc = {
						clincName:'呼吸内科',
						time:[{
							week:'二',
							day:'3',
							href:'#tab1',
							tabId:'tab1',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'张三',
								position:'主任医师',
								rest:'1'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'张三二',
								position:'主任医师',
								rest:'4'
							}]
						},{
							week:'三',
							day:'4',
							href:'#tab2',
							tabId:'tab2',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'李四',
								position:'主任医师',
								rest:'1'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'李四二',
								position:'主任医师',
								rest:'10'
							}]
						},{
							week:'四',
							day:'5',
							href:'#tab3',
							tabId:'tab3',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'王五',
								position:'主任医师',
								rest:'10'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'王五二',
								position:'主任医师',
								rest:'14'
							}]
						},{
							week:'五',
							day:'6',
							href:'#tab4',
							tabId:'tab4',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'赵六',
								position:'主任医师',
								rest:'2'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'赵六二',
								position:'主任医师',
								rest:'15'
							}]
						},{
							week:'六',
							day:'7',
							href:'#tab5',
							tabId:'tab5',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'孙七',
								position:'主任医师',
								rest:'9'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'孙七二',
								position:'主任医师',
								rest:'17'
							}]
						},{
							week:'日',
							day:'8',
							href:'#tab6',
							tabId:'tab6',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'钱八',
								position:'主任医师',
								rest:'12'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'钱八二',
								position:'主任医师',
								rest:'8'
							}]
						},{
							week:'一',
							day:'9',
							href:'#tab7',
							tabId:'tab7',
							docs:[{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'刘九',
								position:'主任医师',
								rest:'6'
							},{
								picSrc:'${ctx.contextPath}/image/doc.png',
								name:'刘九二',
								position:'主任医师',
								rest:'5'
							}]
						}]
				}
				$scope.docsInfo=$scope.clinc.time;
			}]);
		</script>
	</body>

</html>