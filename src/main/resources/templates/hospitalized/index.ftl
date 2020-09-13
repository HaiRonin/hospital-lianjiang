
<!doctype html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>我的住院</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/slider.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/base.js"></script>
	<style>
    .aui-banner-content{width:100%; height:200px;}
	.aui-banner-content .aui-banner-wrapper .aui-banner-wrapper-item{width:100%; height:100%;}
	.aui-banner-wrapper-item img{width:100%; height:100%;}
    </style>
</head>

<body>
<div class="c-main pb15">

	<div class="aui-banner-content" data-aui-slider>
                <div class="aui-banner-wrapper">
                    <div class="aui-banner-wrapper-item">
                        <a href="#">
                            <img src="../images/br01.jpg">
                        </a>
                    </div>
                    <div class="aui-banner-wrapper-item">
                        <a href="#">
                            <img src="../images/br02.jpg">
                        </a>
                    </div>
                    <div class="aui-banner-wrapper-item">
                        <a href="#">
                            <img src="../images/br03.jpg">
                        </a>
                    </div>
                </div>
                <div class="aui-banner-pagination"></div>
            </div>

    <div class="mt10 c-border-t">
    	<ul class="index-list index-hosp clearfix">
            <li><a href="../hosp/HospitalInfo"  style="cursor: pointer"><i class="sicon icon-indextb2"></i><p>住院信息</p></a></li>
            <li><a href="../hosp/hospitalizationExpenses"  style="cursor: pointer"><i class="sicon icon-indextb9"></i><p>押金缴纳</p></a></li>
        	<li><a href="../hosp/depositHospitalList"  style="cursor: pointer"><i class="sicon icon-indextb9"></i><p>押金缴纳记录</p></a></li>
            <li><a href="../hosp/inHospitalList" style="cursor: pointer"><i class="sicon icon-indextb10"></i><p>住院清单</p></a></li>
            <li><a href="../hosp/outHospitalList"><i class="sicon icon-indextb11"></i><p>出院汇总清单</p></a></li>
        </ul>
    </div>
    <div class="h50">
    	<div class="footer">
        	<ul>
                <li><a href="../his/index" ><i class="sicon icon-depart"></i><p>门诊</p></a></li>
                <li><a href="../business/index" class="curr"><i class="sicon icon-hosp"></i><p>住院</p></a></li>
                <li><a href="../user/me"><i class="sicon icon-my"></i><p>我的</p></a></li>
            </ul>
        </div>
    </div>
    
</div>
<script>
    var AppId = "wx14095476fefe834e";
    var local = window.location.href;
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
                    window.localStorage.setItem("openId", result.openId);
                    window.localStorage.setItem("headImgUrl", result.headimgurl);
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