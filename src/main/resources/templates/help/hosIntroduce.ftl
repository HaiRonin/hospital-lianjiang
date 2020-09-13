<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
        <meta charset="UTF-8"> <meta name="viewport"
              content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
        <link rel="stylesheet" href="../css/sm.min.css">
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
        <script type="text/javascript" src="../js/common.js"></script>
		<title>信息查询</title>


	</head>

	<body>
		<div class="page-group">
			<div class="page">
                <div class="content" style="top=0rem; font-size: 14px;">
					<div class="list-block" style="margin: 0;">
                                    <ul>
                                        <li>
                                            <a  onclick="summary()" class="item-link item-content">
                                                <div class="item-media"><i class="icon icon-f7"></i></div>
                                                <div class="item-inner">
                                                    <div class="item-title">医院简介</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a  onclick="expert()" class="item-link item-content">
                                                <div class="item-media"><i class="icon icon-f7"></i></div>
                                                <div class="item-inner">
                                                    <div class="item-title">专家介绍</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a onclick="drugIntroduce()" class="item-link item-content">
                                                <div class="item-media"><i class="icon icon-f7"></i></div>
                                                <div class="item-inner">
                                                    <div class="item-title">药品查询/非药品查询</div>
                                                </div>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
    <script>
        function drugIntroduce() {
            window.location.href = '../help/drugIntroduce'
        }
        function expert() {
            window.location.href = '../help/expert'
        }
        function summary() {
            window.location.href = '../help/summary'
        }
    </script>
	</body>

</html>