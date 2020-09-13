<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<script type="text/javascript" src="${ctx.contextPath}/js/lib/angular.js"></script>
		<title>科室介绍</title>
	</head>

	<body ng-app="app" class="ng-cloak">
		<div class="page-group" ng-controller="depintroController">
			<div class="page">
                <header style="height: 0px;" class="bar bar-nav">
                </header>
                <div class="content" style="top=0rem; font-size: 14px;">
					<div class="card demo-card-header-pic">
						<div valign="bottom" class="card-header color-white no-border">
							<div class="item-subtitle"><span ng-bind="department.name"></span></div>
						</div>
						<div class="card-content">
							<div class="card-content-inner">
								<p class="color-gray">医生数量：<span ng-bind="department.numDoctors"></span></p>
								<p ng-bind="department.ddesc"></p>
							</div>
						</div>
						<div class="card-footer">科室地址：<span ng-bind="department.departAddr"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init()
			var organId = ${organId};
			var app = angular.module("app",[]);
			app.controller('depintroController', ['$scope', '$http', function($scope, $http){

				/* $scope.department = {
					name : '内科',
					numDoctors : 5,
					ddesc : "科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍",
					departAddr : '10F'
				}; */
				$http({
				    method: 'GET',
				    url: '${ctx.contextPath}/help/queryDepartmentById',
				    params:{'organId': organId}
				}).then(function successCallback(response) {
				    // 请求成功执行代码
				    $scope.department = response.data;
				}, function errorCallback(response) {
				    // 请求失败执行代码
					alert(response);
				})
			}]);
		</script>
	</body>

</html>