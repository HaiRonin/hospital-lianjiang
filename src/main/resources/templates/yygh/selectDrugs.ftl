<!DOCTYPE html>
<html ng-app="app">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet" href="../css/sm.min.css">
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <title>药品查询/非药品查询</title>

</head>

	<body >
		<div class="page-group">
			<div class="page">
				<div class="content" style="top=0rem; font-size: 14px;">
					<div class="list-block" style="margin: 0;" id="displayInfo">
						<ul>
                            <li>
                                <div class="item-content">
                                    <div class="item-media"><i class="icon icon-form-name"></i></div>
                                    <div class="item-inner">
                                        <div class="item-title label"><i style="color: red;">* </i>查询条件</div>
                                        <div class="item-input">
                                            <input type="text" placeholder="请输入首字母" required="required" name="seachString"
                                                   id="seachString">
                                        </div>
                                    </div>
                                </div>
                            </li>

                            <li>
                                <div class="item-content">
                                    <div class="item-media"><i class="icon icon-form-gender"></i></div>
                                    <div class="item-inner">
                                        <div class="item-title label"><i style="color: red;">* </i>药品类型</div>
                                        <div class="item-input">
                                            <select name="seachType" id="seachType">
                                                <option value="1">药品</option>
                                                <option value="2">非药品</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </li>
						</ul>
					</div>
                    <div class="list-info" style="margin: 0; display: none;" id="noneInfo">
                        <ul id ="selectInfo">

                        </ul>
                    </div>
                    <div class="content-block" id="submitInfo" style="display: block">
                        <p style="height: 40px;font-size: 16px; line-height: 40px;" class="button button-big button-fill"
                           onclick="submitInfoOut()">确定</p>
                    </div>
				</div>
			</div>
		</div>

		<script>
            function submitInfoOut() {
                var seachString = $('#seachString').val();
                if (seachString == '') {
                    $.toast("请填写查询条件!");
                    return
                }

                var seachType = $('#seachType').val();
                if (seachType == '') {
                    $.toast("请填写查询类型!");
                    return
                }
                window.location.href = '../help/yyghDdpt?seachString=' + seachString
                        +"&seachType="+seachType;

            }
		</script>
	</body>

</html>