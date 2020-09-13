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

	<body>
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">住院信息</h1>
				</header>
				<div class="content" ng-controller="hospInfoController">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">姓名</div>
									<div class="item-after">{{hospInfo.patientName}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">住院号</div>
									<div class="item-after">{{hospInfo.inHosNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">住院流水号</div>
									<div class="item-after">{{hospInfo.inHosSerialNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">住院日期</div>
									<div class="item-after">{{hospInfo.inHosDate}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">床号</div>
									<div class="item-after">{{hospInfo.bedNo}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">科室名称</div>
									<div class="item-after">{{hospInfo.departmentName}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">医保类型名称</div>
									<div class="item-after">{{hospInfo.medicalTypeNmae}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">医保统筹金额</div>
									<div class="item-after">{{hospInfo.overMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">医保记账自费金额</div>
									<div class="item-after">{{hospInfo.payMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">纯自费金额</div>
									<div class="item-after">{{hospInfo.cashMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">押金余额</div>
									<div class="item-after">{{hospInfo.depositMoney}}</div>
								</div>
							</li>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">总费用</div>
									<div class="item-after">{{hospInfo.totalMoney}}</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
	</body>
		<script type="text/javascript">
			$.init();
			angular.module("app",[]).controller('hospInfoController', ['$scope', '$http', function($scope, $http){
				$scope.hospInfo = {
						patientName: '张三',
						inHosNo:'20180406008',
						inHosSerialNo:'2018040600800014',
						inHosDate:'2018-04-01',
						bedNo:'1',
						departmentName:'内科',
						medicalTypeNmae:'市保',
						overMoney:'1000.00',
						payMoney:'1000.00',
						cashMoney:'1000.00',
						depositMoney:'1000.00',
						totalMoney:'4000.00'
				}
			}]);
		</script>
	
</html>