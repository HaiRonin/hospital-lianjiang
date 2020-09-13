<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>登录</title>
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<link rel="stylesheet" type="text/css" href="${ctx.contextPath}/css/style.css"/>
		<link rel="stylesheet" type="text/css" href="${ctx.contextPath}/css/common.css"/>
		<link rel="stylesheet" type="text/css" href="${ctx.contextPath}/css/report.css"/>
		
		<style type="text/css">
			#div1 {
				margin-top: 30px;
				width: 100%;
				text-align: center;
			}
			#div1 a {
				color: #3795f2;
			}
		</style>
	</head>
	<body>
		<div id="warp">
			<div id="main">
				<div class="hp_input one">
					<span class="title">手机号:</span>
					<input type="text" id="UserName" name="UserName"  />
				</div>
				<div class="hp_input two">
					<span class="title">密码:</span>
					<input type="password" id="PassWord" name="PassWord"/>
				</div>
				<button class="button blue" id="comfirm">
					确定
				</button>
				<div id="div1">
					<div class="f_l" style="width: 50%;">
						<a href="${ctx.contextPath}/user/findBackPwd">忘记密码？</a>
					</div>
					<div>
						<a href="${ctx.contextPath}/user/register">新用户注册</a>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		$(function(){
			$("#comfirm").click(function(){
				var UserName = $("#UserName").val();
				var PassWord = $("#PassWord").val();
				if(!UserName){
					$.toast("手机号不能为空");
					return false;
				}
				if(!PassWord){
					$.toast("密码不能为空");
					return false;
				}
				$.ajax({
					url: "${ctx.contextPath}/user/doLogin",
					data:{"UserName":UserName,"PassWord":PassWord},
					type: "post",
					dataType: 'json',
					success: function(result){
						
					},
					error: function(){
						
					}
				});
			});
		})
		
		
	</script>
</html>
