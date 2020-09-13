<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<script type="text/javascript" src="${ctx.contextPath}/js/lib/angular.js"></script>
		<title>科室列表</title>
	</head>

	<body ng-app="app" class="ng-cloak">
		<div class="page-group">
			<div class="page">
                <header style="height: 0px;" class="bar bar-nav">
                </header>
                <div class="content" style="top=0rem; font-size: 14px;" ng-controller="depaController">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li ng-repeat="depa in depaList.department">
								<a href="${ctx.contextPath}/help/depaIntroduce?organId={{depa.organId}}" class="item-link item-content">
									<div class="item-media"><i class="icon icon-f7"></i></div>
									<div class="item-inner">
										<div class="item-title"><span ng-bind="depa.name"></span></div>
									</div>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init()
			var app = angular.module("app",[]);
			app.controller('depaController', ['$scope', '$http', function($scope, $http){
				$scope.depaList = {
					department : [{
							organId : '1',
							name : '外科'
					    }, {
					    	organId : '2',
							name : '内科'
					    }, {
					    	organId : '3',
							name : '骨科'
					    }]
				};
				/* $http({  
				    method: 'GET',  
				    url: '${ctx.contextPath}/help/querydepartmentlist'  
				}).then(function successCallback(response) {  
				    // 请求成功执行代码  
				    $scope.depaList = response.data;
				}, function errorCallback(response) {  
				    // 请求失败执行代码  
					alert(response);
				}) */
				
			}]);
			
		</script>
	</body>

</html>