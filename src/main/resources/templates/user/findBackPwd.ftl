<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>找回密码</title>
        <link rel="stylesheet" href="../css/kdui/min.css">
        <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
        <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
		<link rel="stylesheet" type="text/css" href="${ctx.contextPath}/css/style.css"/>
		<link rel="stylesheet" type="text/css" href="${ctx.contextPath}/css/common.css"/>
		<link rel="stylesheet" type="text/css" href="${ctx.contextPath}/css/report.css"/>
		<style type="text/css">
			.btn {
				display: inline-block;
				padding: 6px;
				background: #3795f2;
				color: #FFF;
				position: absolute;
				top: 10px;
				right: 10px;
				border-radius: 5px;
			}
		</style>
	</head>
	<body>
		<div id="warp">
			<div id="main">
				<div class="hp_input one">
					<span class="title">手机号:</span>
					<input type="text" id="UserName" name="UserName"/>
					<button class="btn f_r" id="sendCode">获取验证码</button>
				</div>
				<input type="hidden" id="receiveCode" name="receiveCode" value="">
				<div class="hp_input two">
					<span class="title">验证码:</span>
					<input type="text" id="verifyCode" name="verifyCode"/>
				</div>
				<div class="hp_input two">
					<span class="title">设置新密码:</span>
					<input type="password" id="PassWord" name="PassWord"/>
				</div>
				<div class="hp_input two">
					<span class="title">确认密码:</span>
					<input type="password" id="repassword"/>
				</div>
				<button class="button blue" id="comfirm">
					确认
				</button>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		$(function(){
			// 点击获取验证码按钮
			$("#sendCode").click(function(){
				var UserName = $("#UserName").val();
				if(!/^1(3|4|5|7|8)\d{9}$/.test(UserName)){
					$.toast("请填写正确的手机号");
					return false;
				}
				$.ajax({
					url : "${ctx.contextPath}/user/sendShortMessage",
					type: "post",
					dataType: 'json',
					data: {"mobile": UserName},
					async: true,
					cache: false,
					success: function(result){
						if(result.data.code==200){
							$("#receiveCode").val(result.data.obj);
							// 开始倒计时
							var time = 60;
							setTime = setInterval(function(){
								if(time<=0){
				                    $("#sendCode").attr("disabled", false);
				                    time = 60;
				                    $("#sendCode").text("获取验证码");
				                    clearInterval(setTime);
				                    return;
				                }
								$("#sendCode").attr("disabled", true);
								time--;
								$("#sendCode").text(time + "s");
							}, 1000);
						}else{
							$.toast("验证码发送失败");
						}
					}, 
					error : function(){
						$.toast("发送验证码失败，请稍后再试");
					}
				});
			});
			$("#comfirm").click(function(){
				var UserName = $("#UserName").val();
				var verifyCode = $("#verifyCode").val();
				var PassWord = $("#PassWord").val();
				var repassword = $("#repassword").val();
				var receiveCode = $("#receiveCode").val();
				if(!/^1(3|4|5|7|8)\d{9}$/.test(UserName)){
					$.toast("手机号格式不正确");
					return false;
				}
				if(!verifyCode){
					$.toast("验证码不能为空");
					return false;
				}
				if(!/(\S|\s){6,20}/.test(PassWord)){
					$.toast("密码在6到20位之间");
					return false;
				}
				if(PassWord != repassword){
					$.toast("两次密码不一致");
					return false;
				}
				$.ajax({
					url: "${ctx.contextPath}/user/setNewPwd",
					data:{"UserName":UserName,"PassWord":PassWord,"verifyCode":verifyCode,"receiveCode":receiveCode},
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
