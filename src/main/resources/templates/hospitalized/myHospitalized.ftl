<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<title></title>
	</head>

	<body>
		<div class="page-group">
			<div class="page">
				<header class="bar bar-nav">
					<h1 class="title">我的住院</h1>
				</header>
				<div class="content">
					<div class="list-block" style="margin: 0;">
						<ul>
							<li>
								<a href="${ctx.contextPath}/hosp/hospInfo" class="item-link item-content">
									<div class="item-media"><i class="icon icon-f7"></i></div>
									<div class="item-inner">
										<div class="item-title">住院信息</div>
									</div>
								</a>
							</li>
							<li>
								<a href="${ctx.contextPath}/hosp/hospDetail" class="item-link item-content">
									<div class="item-media"><i class="icon icon-f7"></i></div>
									<div class="item-inner">
										<div class="item-title">住院清单明细</div>
									</div>
								</a>
							</li>
							<li>
								<a href="${ctx.contextPath}/hosp/hospPayment" class="item-link item-content">
									<div class="item-media"><i class="icon icon-f7"></i></div>
									<div class="item-inner">
										<div class="item-title">住院缴费</div>
									</div>
								</a>
							</li>
							<li>
								<a href="${ctx.contextPath}/hosp/depositPayInBack" class="item-link item-content">
									<div class="item-media"><i class="icon icon-f7"></i></div>
									<div class="item-inner">
										<div class="item-title">押金补缴</div>
									</div>
								</a>
							</li>
							<li>
								<a href="${ctx.contextPath}/hosp/depositDetail" class="item-link item-content">
									<div class="item-media"><i class="icon icon-f7"></i></div>
									<div class="item-inner">
										<div class="item-title">押金明细</div>
									</div>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<script>
			$.init();
		</script>
	</body>

</html>