
<!doctype html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>个人中心</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/slider.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/base.js"></script>

</head>

<body class="bgc-f7fbff">
<div class="c-main pb15">
	<div class="memb-head c-pack">
    	<div class="mh-img"><img style="border-radius:50%" id="batImg" src="../images/d-male.png" alt=""></div>
    	<p class="c-f15 mt5" id="batName"></p>
        <p class="mt3" id="batPlace"><i class="sicon icon-nv"></i></p>
    </div>
    <div class="mt10 c-border-tb">
    	<ul class="c-list c-f14 sd-color1">
        	<li class="c-list-a">
            	<a href="../user/memberList" class="c-arrow-r">
                    <div class="c-list-key c-666 pr15"><i class="sicon icon-memtb8"></i>就诊人管理</div>
            	</a>
            </li>
            <li class="c-list-a">
            	<a href="../user/reservationRecord" class="c-arrow-r">
                    <div class="c-list-key c-666 pr15"><i class="sicon icon-memtb9"></i>预约挂号记录</div>
            	</a>
            </li>
             <li class="c-list-a">
            	<a href="../user/stayPayRecord" class="c-arrow-r">
                    <div class="c-list-key c-666 pr15"><i class="sicon icon-memtb10"></i>待缴费处方记录</div>
            	</a>
            </li>
            <li class="c-list-a">
                <a href="../user/payRecord" class="c-arrow-r">
                    <div class="c-list-key c-666 pr15"><i class="sicon icon-memtb10"></i>已缴费处方记录</div>
                </a>
            </li>
        </ul>
    </div>
    <div class="h50">
    	<div class="footer">
        	<ul>
                <li><a href="../his/index" ><i class="sicon icon-depart"></i><p>门诊</p></a></li>
                <li><a href="../business/index"><i class="sicon icon-hosp"></i><p>住院</p></a></li>
                <li><a href="../user/me" class="curr"><i class="sicon icon-my"></i><p>我的</p></a></li>
            </ul>
        </div>
    </div>
</div>
<script>
    var AppId = "wx14095476fefe834e";
    var local = "http://weixin.ljfy.com.cn/hospital/user/me";
    var code = getUrlParam('code');
    $(document).ready(function () {
        if(code ==null ||code ==''){
            window.location.href = 'http://open.weixin.qq.com/connect/oauth2/authorize' +
                    '?appid=' + AppId + '&redirect_uri=' + local + '&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect';
        }
        else {
            this.getOpenId(code);
        }
    });

    function getOpenId(code) {
        $.ajax({
            url: "../wechat/getOpenid?code="+code,
            method: "GET",
            dataType: 'json',
            async: false,
            success: function (result) {
                if (result != '1000') {
                    $('#batImg').attr('src',result.headimgurl);
                    $('#batName').text(result.nickname+"医疗空间");
                    $('#batPlace').text(result.province+"  "+result.city);
                    window.localStorage.setItem("openId", result.openId);
                    window.localStorage.setItem("headImgUrl", result.headimgurL);
                    window.localStorage.setItem("nickname", result.nickname);
                    window.localStorage.setItem("province", result.province);
                    window.localStorage.setItem("city", result.city);
                    window.localStorage.setItem("sex", result.sex);
                }else {
                    $.toast("获取用户信息失败!");
                }
            },
            error: function () {
                $.toast("服务器维护中,稍后重试!");
            }
        });
    }

    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
</script>
</body>
</html>
