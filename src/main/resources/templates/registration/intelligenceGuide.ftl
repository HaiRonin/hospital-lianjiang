<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache">
<meta name="format-detection" content="telephone=no" />
<title>智能导诊</title>

<link rel="stylesheet" href="${ctx.contextPath}/css/kdui/kdui.min.css" />
<script src="${ctx.contextPath}/js/jquery-3.2.1.min.js"></script>
<!-- 全局引入加载中loading -->
<!-- 引入高清解决方案 -->
<script>!function(e){function t(a){if(i[a])return i[a].exports;var n=i[a]={exports:{},id:a,loaded:!1};return e[a].call(n.exports,n,n.exports,t),n.loaded=!0,n.exports}var i={};return t.m=e,t.c=i,t.p="",t(0)}([function(e,t){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=window;t["default"]=i.flex=function(e,t){var a=e||100,n=t||1,r=i.document,o=navigator.userAgent,d=o.match(/Android[\S\s]+AppleWebkit\/(\d{3})/i),l=o.match(/U3\/((\d+|\.){5,})/i),c=l&&parseInt(l[1].split(".").join(""),10)>=80,p=navigator.appVersion.match(/(iphone|ipad|ipod)/gi),s=i.devicePixelRatio||1;p||d&&d[1]>534||c||(s=1);var u=1/s,m=r.querySelector('meta[name="viewport"]');localStorage.setItem("initial-scale", u);m||(m=r.createElement("meta"),m.setAttribute("name","viewport"),r.head.appendChild(m)),m.setAttribute("content","width=device-width,user-scalable=no,initial-scale="+u+",maximum-scale="+u+",minimum-scale="+u),r.documentElement.style.fontSize=a/2*s*n+"px"},e.exports=t["default"]}]);  flex(100, 1);</script>
</head>
<body onload="load()">
<!-- 获取是否开通了妇女的标签，如果值为“1”则表示为开通了 -->

<!-- 获取是否开通了儿童的标签，如果值为“1”则表示为开通了 -->

<!-- 获取智能导诊温馨提示 -->

<style>.smart-tab{height:.9rem;text-align:center;background:#FFF;width:100%;padding:.2rem .3rem}.smart-tab .smart-tab__item{width:50%;height:.5rem;line-height:.5rem;float:left;color:#222;background:#aaa}.smart-tab .smart-tab__item.smart-tab__item-left{border-radius:.1rem 0 0 .1rem}.smart-tab .smart-tab__item.smart-tab__item-right{border-radius:0 .1rem .1rem 0}.smart-tab .smart-tab__item.smart-tab__item_selected{color:#FFF;background:#007aff}.kdui-switch-tab__wrap{position:absolute;z-index:100;top:1rem;width:1.6rem}.kdui-switch-tab__wrap.kdui-switch-tab__wrap-left{left:.3rem}.kdui-switch-tab__wrap.kdui-switch-tab__wrap-right{right:.3rem}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__gender:before{content:'女'}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__gender:after{content:'男'}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__age:before{content:'儿童'}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__age:after{content:'成人'}.smart-rotate-button{z-index:100;position:absolute;right:.3rem;bottom:.3rem;height:.8rem;width:.8rem;border-radius:.4rem;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEQAAABECAMAAAAPzWOAAAAAhFBMVEX///81neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neRotuvz+f3///+Bwu50vOxCo+aOyPCTy/GazvKh0fK02vW83vbA4ffN5/jX6/rm8/zy+P1Oqedbr+lCpObJ5fh4vu1dsena7frk8vun1POu2PRQquiGxO9rt+scp+dLAAAADXRSTlMAECAwUGCAkLDA0ODwMDZX9QAAAzJJREFUeF61mOmSqjAQheWKKGpnYd0X12Xm/d/vohA6GCOgNeeHWKX1cXpJSDPTyjAtew2t1rZlGrOJmi/XoGi9nE9ALARB5SzGEQxrC2+0tYwRLjYwoM2Qm382jJD9762NLYzS1tQzljBaS11GVwqAeEF6VxAQF/paGS8ZT3UtvRM7RQEnhDhBVH/3yn61jUEGSVnk9O7uRDR1BiirPoIGgoByeX4ickTvcupeBEKRRxNXm10TUNUpLUEnN8krpJi9HttKsdMA3sljHPtF7jobGRz/oxGhSLGRsZAYtIIhVRJl0VV3o/w+ROmKtBF1tjBtuQdjxGmXequFYFaTBMbpkna5fc6IQ92REDfn/axgv+Mvg6qCrvvvjDlGmsMnmmPDo5GpWsrROFONYDwGCEXY7sXP43K9IuDwq6UY0tLD2t/Y7XE9+wjJQi3ExE4jGM1h3xpq7+5nWcayh15BLFx7QQRCPqvls0ZHgDA7NPLZDlTZmNfEEz7CNhq/MTQIWc8el7QCSAlUaUM5HwqoFYcCUmStXkJg1m0AtKxo1BalgZx/OifCpA4iKEww4PxbQ46sVdx34h8FoJQggsIEoyY8nPgZqDmJC1H2iHGECAqLhPnGwS5r//57iBGSHQWDMsoRoriDxknRwq6ZUI2+CcYjfo4QRX5c7FldozvNR/L+HLJdxygp1BQdJGNhXBxhF7JryA6IKMJdV520ApKC6AlsNuiF03wyUWR/z+Jbv8Regs1m6yGw2xd3Jz9xUVyPUCc2PsOLRW/PLA2k0TW8V2vvN2EyKUOQE1yAJgxKVGQnt2tJpa3AgIlSF72B2+NE5Y683S8/YvC8t1HPPzPCe48MjCeoPjGy7j9GeT76KUodEFo8PdDTyxBAffBvn48WJeWjGJ5k2VIOOWTgnKSepjYGHremn7YwI0K2RCF6gHoytF8fQTnz3re7KAweQdWAoMoTfaXL9CTHa2pHHTehGjNuQC/yDZbvBgRyyrn7CpH2ErYaGFWclPYnFZdHLCWTBh6cmRxCCMeZSWEMjm8uCdrpzVPrvjL+YJBEmdNG2u+H6+/H/O9fOHz/6uMvX8J8/zroPypt1kzv9LSwAAAAAElFTkSuQmCC);background-size:.8rem}.smart-body__image-wrap{display:block;position:relative;top:0;z-index:99}.divya,.pic_arrow{position:absolute}.smart-body__image-wrap img{max-width:100%;height:auto;margin:auto;background-size:cover;vertical-align:middle;text-align:center}.divya,.divya1{z-index:1000;width:100%;height:100%;top:0;left:0}.divya{display:none}.divya1{background-color:#000;-moz-opacity:.7;opacity:.7;filter:alpha(opacity=70);margin:0}.divya-top{background:#fff;color:#007aff;line-height:.9rem;height:.9rem;text-align:center;border-bottom:1px solid #e6e6e6}.pic_arrow{left:10%;top:45%;width:.34rem;height:.42rem;background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABEAAAAVCAMAAACXIvXeAAAAS1BMVEVsbGz///9sbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGyxa3U6AAAAGXRSTlMAAAEEBQcKDUdIS05RVVtccnh9f4CDhYaHPXnfnwAAAFVJREFUeF6F0DkSgCAQRNEGFFwAd+X+JzVQkp/Q4aup2WSYT2LQnyp5txClw0KUTgdRvDqI5ruHaHo8REPxEI2bg6isjZrah7O4D3fmXY3bF/yHP2ReWUgDMXgw3PoAAAAASUVORK5CYII=);background-size:.34rem .42rem}</style>
<!-- 切换tab（身体部位、列表） -->
<div class="smart-tab">
	<div id="a1" class="smart-tab__item smart-tab__item-left smart-tab__item_selected" onclick="intelGuide.setTab('smart-tab__item','a',1,2)">身体部位</div>
	<div id="a2" class="smart-tab__item smart-tab__item-right" onclick="intelGuide.setTab('smart-tab__item','a',2,2)">列表</div>
</div>
<!-- 人体部位 -->
<div id="con_a1">
	<div class="kdui-text_center" id="boxbg">
		<div id="mzm" class="smart-body__image-wrap"><img  data-src="${ctx.contextPath}/image/intelguide/MMZ.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="nzm" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/FMZ.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="mfm" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/MMF.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="nfm" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/FMF.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="cbz" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/CBZ.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="cgz" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/CGZ.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="cbf" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/CBF.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div id="cgf" class="smart-body__image-wrap" style="display: none;"><img data-src="${ctx.contextPath}/image/intelguide/CGF.png" usemap="#Map" />
			<!-- js自动输入 -->
		</div>
		<div class="kdui-switch-tab__wrap kdui-switch-tab__wrap-left" id="adult_switch">
			<input id="sex_switch" class="kdui-switch-tab kdui-switch-tab__gender" type="checkbox" onchange="intelGuide.setSex()" />
		</div>
		<div class="kdui-switch-tab__wrap kdui-switch-tab__wrap-right" id="children_switch">
			<input id="age_switch" class="kdui-switch-tab kdui-switch-tab__age" type="checkbox" onchange="intelGuide.setManOrBoy()" />
		</div>
		<div id="mid" class="smart-rotate-button" onclick="intelGuide.setBody()">
		</div>
		<div id="nid" class="smart-rotate-button" onclick="intelGuide.setBody()" style="display:none;">
		</div>
	</div>
	<!-- 温馨提示 -->
	
</div>

<div class="kdui_wrapper kdui_wrapper__top_sm" id="wrapper">
<div class="kdui_scroller" id="scroller">
<!-- 列表数据 -->
<div class="kdui-flex__item" id="con_a2" style="display:none;">
	<div class="kdui-cells">
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','BAD6ECD2D3AC4CD19CDFFE791B6021F5','下肢')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">下肢</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','5ED9ED1A89904686B54AEF859E9F599C','耳眼口鼻')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">耳眼口鼻</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','C8EBA1FCECE847449B3608ECF45BF96E','头部')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">头部</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','79B1EF185AE443CC966DE3FAB9850520','胸部')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">胸部</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','B731BD8048144959B14C1A4B3F42E26E','腹部')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">腹部</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','69F6F7DA9E8F42C9AA4AB814C83A4953','皮肤')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">皮肤</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','7D51F4B7BF6347E3AE5B84C5F7B33EF4','上肢')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">上肢</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','4A368DA518C14F678CC4164ACA937094','四肢')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">四肢</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','5010E4C3372341889CDCBA708C13D7FA','其他')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">其他</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','F23532C3D4964C32928888B79F02F3E2','颈部')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">颈部</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','E9ECC0CB0AC94F659201A7A15404D5BC','生殖器')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">生殖器</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
			<a href="javascript:;" class="kdui-cell_access" onclick="intelGuide.getDis('osY1uwUr_A2KGu5uxyEziEDChseA','26E412D1820748B290718438E17596FB','背部')">
				<div class="kdui-cell">
					<div class="kdui-cell__bd">背部</div>
					<div class="kdui-cell__ft"></div>
				</div>
			</a>
		
	</div>
</div>

  </div>
</div>
<script>
	var myScroll;
	function loadIscroll() {
		myScroll = new IScroll('#wrapper',{hScrollbar:false,vScrollbar:false});
	}
</script>
<!--点击弹出的部位疾病-->
<div class="divya" id="div5">
	<a onClick="intelGuide.toggle('div5')">
		<div class="divya1">
			<div class="pic_arrow"></div>
		</div>
	</a>
	<div style="position:absolute; right:0.1%; top:0.1%; width:0.1%; " id="div51">
		<div class="divya-top" id="topId">
			<!--通过js赋值  -->
		</div>
		<div class="divya-mid" style="background: #f0f0f6;" id="divmid">
			<div class="divya-middle" id="contentId">
				<!--通过js赋值  -->
			</div>
		</div>
	</div>
</div>	
	<!-- 隐藏域 -->
	<input type="hidden" id="gender" value="MM">
	<input type="hidden" id="sex" value="MM">
	<!-- 性别，默认为成人男 -->
	<input type="hidden" id="zfm" value="ZM">
	<!-- 正反面，默认为正面 -->
	<!-- 获取配置了妇女的标签 ，默认没有开通，“1”表示开通了-->
	<input type="hidden" id="isFemale" value="0">
	<!-- 获取配置了儿童的标签  ，默认没有开通，“1”表示开通了-->
	<input type="hidden" id="isChildren" value="0">
	</div>
	<script>
		function bodyOnload() {
			$("#isFemale").val("0");
			$("#isChildren").val("0");
			intelGuide.load();
		}

		function changeJson(ratio) {
			var json = "[";
			
			var str = "110,103,284,151";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'MM'}";
				}
			} 
			
			var str = "147,261,238,316";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'FM'}";
				}
			} 
			
			var str = "107,490,269,724";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'CG'}";
				}
			} 
			
			var str = "129,359,260,722";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'FM'}";
				}
			} 
			
			var str = "125,338,245,410";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'CB'}";
				}
			} 
			
			var str = "125,388,261,721";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'MM'}";
				}
			} 
			
			var str = "151,281,238,338";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'MM'}";
				}
			} 
			
			var str = "143,164,248,211";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'FM'}";
				}
			} 
			
			var str = "27,241,108,481";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CB'}";
				}
			} 
			
			var str = "263,240,332,487";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CB'}";
				}
			} 
			
			var str = "102,196,269,241";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'CB'}";
				}
			} 
			
			var str = "150,337,239,388";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'MM'}";
				}
			} 
			
			var str = "111,497,274,723";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'BAD6ECD2D3AC4CD19CDFFE791B6021F5','partname':'下肢','kindflag':'3','typeflag':'CB'}";
				}
			} 
			
			var str = "158,12,231,103";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'FM'}";
				}
			} 
			
			var str = "121,262,255,330";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'CG'}";
				}
			} 
			
			var str = "27,150,126,434";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'MM'}";
				}
			} 
			
			var str = "263,149,366,432";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'MM'}";
				}
			} 
			
			var str = "102,31,268,197";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'CB'}";
				}
			} 
			
			var str = "112,251,252,443";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'CG'}";
				}
			} 
			
			var str = "134,153,254,284";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'MM'}";
				}
			} 
			
			var str = "125,414,250,497";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'CB'}";
				}
			} 
			
			var str = "127,102,264,148";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'FM'}";
				}
			} 
			
			var str = "115,366,256,439";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'B731BD8048144959B14C1A4B3F42E26E','partname':'腹部','kindflag':'0','typeflag':'CG'}";
				}
			} 
			
			var str = "121,262,255,329";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'CB'}";
				}
			} 
			
			var str = "130,150,259,214";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'79B1EF185AE443CC966DE3FAB9850520','partname':'胸部','kindflag':'0','typeflag':'MM'}";
				}
			} 
			
			var str = "145,314,239,360";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'FM'}";
				}
			} 
			
			var str = "56,147,129,397";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'FM'}";
				}
			} 
			
			var str = "260,148,336,396";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'FM'}";
				}
			} 
			
			var str = "113,440,255,485";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'E9ECC0CB0AC94F659201A7A15404D5BC','partname':'生殖器','kindflag':'0','typeflag':'CG'}";
				}
			} 
			
			var str = "161,19,233,105";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'MM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'MM'}";
				}
			} 
			
			var str = "134,153,254,284";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'FM'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'FM'}";
				}
			} 
			
			var str = "99,205,270,247";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'F23532C3D4964C32928888B79F02F3E2','partname':'颈部','kindflag':'3','typeflag':'CG'}";
				}
			} 
			
			var str = "26,246,108,482";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CG'}";
				}
			} 
			
			var str = "254,247,327,490";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'7D51F4B7BF6347E3AE5B84C5F7B33EF4','partname':'上肢','kindflag':'3','typeflag':'CG'}";
				}
			} 
			
			var str = "127,256,244,392";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("true") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'CB'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'26E412D1820748B290718438E17596FB','partname':'背部','kindflag':'1','typeflag':'CB'}";
				}
			} 
			
			var str = "104,35,262,205";
			var strArray = new Array();
			if(str != '') {
				strArray = str.split(",");
				for(var i = 0, len = strArray.length; i < len; i++) {
					strArray[i] *= ratio;
				}
				str = strArray[0] + "," + strArray[1] + "," + strArray[2] + "," + strArray[3];
				if("false") {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'CG'},";
				} else {
					json += "{'spot':'" + str + "','openid':'osY1uwUr_A2KGu5uxyEziEDChseA','partid':'C8EBA1FCECE847449B3608ECF45BF96E','partname':'头部','kindflag':'3','typeflag':'CG'}";
				}
			} 
			
			json += "]";
			var dataJson = eval(json);
			return dataJson;
		}
	</script>
	<!-- 引入记录页面操作日志需要用到隐藏form表单 -->
	<form id="pageOperatingLogsForm" class="hide">
		<input type="hidden" name="pageOperatingLogs.pageId" id="pageOperatingLogs_pageId" value="SMARTGUIDANCE_PAT" />
	</form>
	<script>"use strict";
var intelGuide = function() {
    function _initPicFocus(e) {
        var t = $("#" + e + " img");
        t[0].src = t.data("src");
        var m = function(t) {
            intelGuide.AutoResizeImage(t, e), picData = changeJson(ratio), intelGuide.setChangePicFouse(picData), ui.hideLoading()
        };
/*         if (ui.showLoading(), t[0].complete) return void m(t[0]);
        t[0].onload = function() {
            m(t[0])
        } */
    }

    function _initBody() {
        var e = $("#sex").val(),
            t = $("#zfm").val();
        document.getElementById("sex_switch").checked = !1, document.getElementById("age_switch").checked = !1, document.getElementById("mzm").style.display = "none", document.getElementById("mid").style.display = "none", "MM" == e && "ZM" == t ? (document.getElementById("mzm").style.display = "block", document.getElementById("nid").style.display = "block", _initPicFocus("mzm")) : "MM" == e && "FM" == t ? (document.getElementById("mfm").style.display = "block", document.getElementById("mid").style.display = "block", _initPicFocus("mfm")) : "FM" == e && "ZM" == t ? (document.getElementById("sex_switch").checked = "checked", document.getElementById("nzm").style.display = "block", document.getElementById("nid").style.display = "block", _initPicFocus("nzm")) : "FM" == e && "FM" == t ? (document.getElementById("sex_switch").checked = "checked", document.getElementById("nfm").style.display = "block", document.getElementById("mid").style.display = "block", _initPicFocus("nfm")) : "CB" == e && "ZM" == t ? (document.getElementById("age_switch").checked = "checked", document.getElementById("cbz").style.display = "block", document.getElementById("nid").style.display = "block", _initPicFocus("cbz")) : "CB" == e && "FM" == t ? (document.getElementById("age_switch").checked = "checked", document.getElementById("cbf").style.display = "block", document.getElementById("mid").style.display = "block", _initPicFocus("cbf")) : "CG" == e && "ZM" == t ? (document.getElementById("sex_switch").checked = "checked", document.getElementById("age_switch").checked = "checked", document.getElementById("cgz").style.display = "block", document.getElementById("nid").style.display = "block", _initPicFocus("cgz")) : "CG" == e && "FM" == t && (document.getElementById("sex_switch").checked = "checked", document.getElementById("age_switch").checked = "checked", document.getElementById("cgf").style.display = "block", document.getElementById("mid").style.display = "block", _initPicFocus("cgf"))
    }
    var ratio = 0,
        picData = "",
        initScale = localStorage.getItem("initial-scale");
    return {
        load: function(e) {
            intelGuide.selectPic()
        },
        selectPic: function() {
            var e = sessionStorage.getItem("session_sex_value"),
                t = sessionStorage.getItem("session_zfm_value"),
                m = !1;
            if (e && "" != e && (m = !0, $("#sex").val(e)), t && "" != t && (m = !0, $("#zfm").val(t)), m) _initBody();
            else {
                var n = $("#gender").val();
                "MM" == n ? $("#sex").val("MM") : "FM" == n && $("#sex").val("FM"), intelGuide.initBodyFromTag(), _initBody()
            }
        },
        initBodyFromTag: function() {
            var e = $("#isFemale").val(),
                t = $("#isChildren").val();
            "1" === e && "1" === t ? (document.getElementById("sex_switch").checked = "checked", document.getElementById("mzm").style.display = "none", document.getElementById("nzm").style.display = "block", document.getElementById("mid").style.display = "none", document.getElementById("nid").style.display = "block", $("#sex").val("FM"), document.getElementById("adult_switch").style.display = "none") : "1" === e ? (document.getElementById("sex_switch").checked = "checked", document.getElementById("mzm").style.display = "none", document.getElementById("nzm").style.display = "block", document.getElementById("mid").style.display = "none", document.getElementById("nid").style.display = "block", $("#sex").val("FM"), document.getElementById("adult_switch").style.display = "none", document.getElementById("children_switch").style.display = "none") : "1" === t && (document.getElementById("mzm").style.display = "none", document.getElementById("nzm").style.display = "none", document.getElementById("cbz").style.display = "block", document.getElementById("mid").style.display = "none", document.getElementById("nid").style.display = "block", $("#sex").val("CB"), document.getElementById("children_switch").style.display = "none")
        },
        AutoResizeImage: function(e, t) {
            var m = $(window).height(),
                n = new Image;
            n.src = e.src;
            var i = n.width,
                d = n.height,
                c = n.height;
            d = m - 55 / initScale, d -= $(".kdui-cells__tips").outerHeight(!0) || 0, ratio = d / c, i *= ratio, e.height = d, e.width = i;
            var o = (m - 55 / initScale - d) / 2;
            document.getElementById(t).style.top = o / 100 + "rem"
        },
        setTab: function(e, t, m, n) {
            1 == m ? $(".smart-tab").removeClass("kdui-border_b") : $(".smart-tab").addClass("kdui-border_b");
            for (var i = 1; i <= n; i++) {
                var d = document.getElementById(t + i),
                    c = document.getElementById("con_" + t + i),
                    o = document.getElementById("more_" + t + i);
                i == m ? $(d).addClass("smart-tab__item_selected") : $(d).removeClass("smart-tab__item_selected"), c.style.display = i == m ? "block" : "none", o && (o.style.display = i == m ? "block" : "none")
            }
            myScroll && myScroll.refresh()
        },
        choisePart: function(e, t, m, n) {
            $("#topId div").remove(), $("#contentId div").remove(), $("#topId").html(t);
            var i = '<div class="kdui_wrapper" id="wrapper_smartguide" style="top:.9rem">',
                d = 0;
            i += '<div class="kdui_scroller" id="scroller_smartguide">', i += '<div class="kdui-cells">';
            for (var c = 0; c < m.length; c++) {
                var o = m[c].symId,
                    l = m[c].symName;
                i += '\n\t\t\t\t\t<a href="smartGuidance!findGuideTreeBySymId.do?openId=' + e + "&symId=" + o + "&questionFlag=" + n + "&partId=" + m[c].partId + '" class="kdui-cell_access">\n\t\t\t\t\t\t<div class="kdui-cell">\n\t\t\t\t\t\t\t<div class="kdui-cell__bd">' + l + '</div>\n\t\t\t\t\t\t\t<div class="kdui-cell__ft"></div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</a>\n\t\t\t\t', d += 45 / initScale
            }
            i += "</div>", i += "</div>", i += "</div>", $("#contentId").append(i), intelGuide.toggle("div5"), $("#scroller_smartguide").height(d), myScroll = new IScroll("#wrapper_smartguide")
        },
        toggle: function(e) {
            if (document.getElementById) {
                var t = document.getElementById(e);
                if ("block" == t.style.display) $("#div51").animate({
                    width: "0.1%"
                }, "slow").queue(function(e) {
                    t.style.display = "none", myScroll && myScroll.refresh(), e()
                });
                else {
                    t.style.display = "block";
                    var m = $(".divya1").height();
                    $("#divmid").height(m - 45 / initScale), $("#wrapper_smartguide").height(m - 45 / initScale), $("#div51").animate({
                        width: "70%"
                    }, "slow")
                }
            }
        },
        setSex: function() {
            var e = $("#sex").val(),
                t = $("#zfm").val();
            "MM" == e && "ZM" == t ? intelGuide.commonTurn("mzm", "nzm", "sex_switch", "FM", 1) : "MM" == e && "FM" == t ? intelGuide.commonTurn("mfm", "nfm", "sex_switch", "FM", 1) : "FM" == e && "ZM" == t ? intelGuide.commonTurn("nzm", "mzm", "sex_switch", "MM", 1) : "FM" == e && "FM" == t ? intelGuide.commonTurn("nfm", "mfm", "sex_switch", "MM", 1) : "CB" == e && "ZM" == t ? intelGuide.commonTurn("cbz", "cgz", "sex_switch", "CG", 1) : "CB" == e && "FM" == t ? intelGuide.commonTurn("cbf", "cgf", "sex_switch", "CG", 1) : "CG" == e && "ZM" == t ? intelGuide.commonTurn("cgz", "cbz", "sex_switch", "CB", 1) : "CG" == e && "FM" == t && intelGuide.commonTurn("cgf", "cbf", "sex_switch", "CB", 1)
        },
        setManOrBoy: function() {
            var e = $("#sex").val(),
                t = $("#zfm").val(),
                m = $("#isChildren").val();
            "1" === m && "FM" === e && (document.getElementById("adult_switch").style.display = "block"), "1" !== m || "CB" !== e && "CG" !== e || (document.getElementById("adult_switch").style.display = "none", e = "CG"), "MM" == e && "ZM" == t ? intelGuide.commonTurn("mzm", "cbz", "age_switch", "CB", 2) : "MM" == e && "FM" == t ? intelGuide.commonTurn("mfm", "cbf", "age_switch", "CB", 2) : "FM" == e && "ZM" == t ? intelGuide.commonTurn("nzm", "cgz", "age_switch", "CG", 2) : "FM" == e && "FM" == t ? intelGuide.commonTurn("nfm", "cgf", "age_switch", "CG", 2) : "CB" == e && "ZM" == t ? intelGuide.commonTurn("cbz", "mzm", "age_switch", "MM", 2) : "CB" == e && "FM" == t ? intelGuide.commonTurn("cbf", "mfm", "age_switch", "MM", 2) : "CG" == e && "ZM" == t ? intelGuide.commonTurn("cgz", "nzm", "age_switch", "FM", 2) : "CG" == e && "FM" == t && intelGuide.commonTurn("cgf", "nfm", "age_switch", "FM", 2)
        },
        commonTurn: function(e, t, m, n, i) {
            $("#" + m).attr("onclick", ""), $("#" + e).fadeOut("slow").queue(function(e) {
                $("#" + t).fadeIn("slow"), e(), 1 == i ? $("#" + m).attr("onchange", "intelGuide.setSex()") : 2 == i && $("#" + m).attr("onchange", "intelGuide.setManOrBoy()")
            }), $("#sex").val(n), sessionStorage.setItem("session_sex_value", n), _initPicFocus(t)
        },
        setBody: function(e, t) {
            var m = $("#sex").val(),
                n = $("#zfm").val();
            "MM" == m && "ZM" == n ? intelGuide.commonTurnSide("mzm", "mfm", "mid", "nid", "FM") : "MM" == m && "FM" == n ? intelGuide.commonTurnSide("mfm", "mzm", "nid", "mid", "ZM") : "FM" == m && "ZM" == n ? intelGuide.commonTurnSide("nzm", "nfm", "mid", "nid", "FM") : "FM" == m && "FM" == n ? intelGuide.commonTurnSide("nfm", "nzm", "nid", "mid", "ZM") : "CB" == m && "ZM" == n ? intelGuide.commonTurnSide("cbz", "cbf", "mid", "nid", "FM") : "CB" == m && "FM" == n ? intelGuide.commonTurnSide("cbf", "cbz", "nid", "mid", "ZM") : "CG" == m && "ZM" == n ? intelGuide.commonTurnSide("cgz", "cgf", "mid", "nid", "FM") : "CG" == m && "FM" == n && intelGuide.commonTurnSide("cgf", "cgz", "nid", "mid", "ZM")
        },
        commonTurnSide: function(e, t, m, n, i) {
            document.getElementById(e).style.display = "none", document.getElementById(t).style.display = "block", document.getElementById(m).style.display = "none", document.getElementById(n).style.display = "block", $("#zfm").val(i), sessionStorage.setItem("session_zfm_value", i), _initPicFocus(t)
        },
        setChangePicFouse: function(e) {
            var t = $("#sex").val(),
                m = $("#zfm").val(),
                n = '<map name="Map">';
            "MM" == t && "ZM" == m ? ($("#mfm map").remove(), $("#nzm map").remove(), $("#nfm map").remove(), $("#cbz map").remove(), $("#cbf map").remove(), $("#cgz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "0"), n += "</map>", $("#mzm").append(n)) : "MM" == t && "FM" == m ? ($("#mzm map").remove(), $("#nzm map").remove(), $("#nfm map").remove(), $("#cbz map").remove(), $("#cbf map").remove(), $("#cgz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "1"), n += "</map>", $("#mfm").append(n)) : "FM" == t && "ZM" == m ? ($("#mzm map").remove(), $("#mfm map").remove(), $("#nfm map").remove(), $("#cbz map").remove(), $("#cbf map").remove(), $("#cgz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "0"), n += "</map>", $("#nzm").append(n)) : "FM" == t && "FM" == m ? ($("#mzm map").remove(), $("#nzm map").remove(), $("#mfm map").remove(), $("#cbz map").remove(), $("#cbf map").remove(), $("#cgz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "1"), n += "</map>", $("#nfm").append(n)) : "CB" == t && "ZM" == m ? ($("#mzm map").remove(), $("#mfm map").remove(), $("#nzm map").remove(), $("#mfm map").remove(), $("#cbf map").remove(), $("#cgz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "0"), n += "</map>", $("#cbz").append(n)) : "CB" == t && "FM" == m ? ($("#mzm map").remove(), $("#mfm map").remove(), $("#nzm map").remove(), $("#mfm map").remove(), $("#cbz map").remove(), $("#cgz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "1"), n += "</map>", $("#cbf").append(n)) : "CG" == t && "ZM" == m ? ($("#mzm map").remove(), $("#mfm map").remove(), $("#nzm map").remove(), $("#mfm map").remove(), $("#cbf map").remove(), $("#cbz map").remove(), $("#cgf map").remove(), n = intelGuide.getSpot(n, e, t, "0"), n += "</map>", $("#cgz").append(n)) : "CG" == t && "FM" == m && ($("#mzm map").remove(), $("#mfm map").remove(), $("#nzm map").remove(), $("#mfm map").remove(), $("#cbz map").remove(), $("#cgz map").remove(), $("#cbf map").remove(), n = intelGuide.getSpot(n, e, t, "1"), n += "</map>", $("#cgf").append(n))
        },
        getSpot: function(e, t, m, n) {
            for (var i = 0; i < t.length; i++) t[i].typeflag != m && "ALL" != t[i].typeflag || t[i].kindflag != n && "3" != t[i].kindflag || (e += "<area id='heart' shape='rect' coords='" + t[i].spot + "' onclick=\"intelGuide.getDis('" + t[i].openid + "','" + t[i].partid + "','" + t[i].partname + "')\" onFocus='this.blur()'>");
            return e += "</map>"
        },
        toggleQue: function(e, t) {
            var m = $(window).width() - 20 / initScale;
            $("#" + e)[0].style.display = "none", $("#" + t)[0].style.display = "block", $("#" + t).animate({
                width: m
            })
        },
        getDis: function getDis(openId, fpartId, fpartName) {
            var sex = $("#sex").val();
            $.ajax({
                url: "smartGuidance!findSymptomList.do",
                data: {
                    openId: openId,
                    partId: fpartId,
                    typeFlag: sex
                },
                type: "post",
                cache: !1,
                dataType: "json",
                success: function success(data) {
                    var reportData = eval(data);
                    intelGuide.choisePart(openId, fpartName, reportData, sex)
                },
                error: function() {
                    alert("异常！")
                }
            })
        }
    }
}();
//# sourceMappingURL=intel_guide.min.js.map
</script>
	<!-- 通用页面底部 -->

<!-- 全局引入加载中loading -->

<div id="loadingToast" class="kdui-hide">
	<div class="kdui-mask_transparent"></div>
	<div class="kdui-toast">
		<i class="kdui-loading kdui-icon_toast"></i>
		<p class="kdui-toast__content">数据加载中...</p>
	</div>
</div>
<!-- 全局引入toast结果提示  -->

<div id="toast" class="kdui-hide">
	<div class="kdui-mask_transparent"></div>
	<div class="kdui-toast kdui-toast_mini">
		<p class="kdui-toast__content">取消成功</p>
	</div>
</div>
<div class="footer-hospitial-name" style="display:none"></div>
<div class="footer3"></div>
<!-- 新版调用接口需要用到的token -->
<input type="hidden" id="userToken" value="ZQouaz7jtUyKEsrcj5rt5w=="/>
<script src="${ctx.contextPath}/js/polyfill.min.js" defer="defer"></script>
<script src="${ctx.contextPath}/js/fastclick.min.js" async="async"></script>
<script src="${ctx.contextPath}/js/iscroll.min.js" defer="defer"></script>
<!-- <script src="//at.alicdn.com/t/font_313159_zm8rl2st5r8uxr.js" async="async"></script> -->
<!-- 内联方式的引入v5版本通用js -->
<script>"use strict";function onBridgeReady(){WeixinJSBridge.call("hideOptionMenu")}function load(){FastClick.attach(document.body);var e={};isShowTenantName&&"true"===isShowTenantName&&(e.hospitalShortName=hospitalShortName),showCopyright(e),"undefined"!=typeof bodyOnload&&bodyOnload(),"undefined"!=typeof loadIscroll&&(loadIscroll(),"undefined"!=typeof loadIscrollCb&&loadIscrollCb()),/**Util.checkNull(tenantName)||"wxcity"===isWeixincity&&showName(tenantName),**/"undefined"!=typeof showAd&&showAd();var t=$("#pageOperatingLogs_pageId");void 0===t||Util.checkNull(t.val())||ajaxToPrintPageLogs(),$.ajax({type:"get",url:Util.getBasePath()+"/js/baidu/baiduStatistics.min.js",dataType:"script",cache:!0,success:function(e){},error:function(){}})}function showName(e){$(".js__copyright").html(e)}function ajaxPrintJsError(e,t,o,n,i){$.ajax({url:Util.getBasePath()+"/pageStatisticsLogs!printJsErrorLogs.do",data:{"jsErrorLogs.sMsg":e,"jsErrorLogs.sUrl":t,"jsErrorLogs.sLine":o,"jsErrorLogs.sCol":n,"jsErrorLogs.errorObj":i},type:"post",cache:!1,dataType:"json",success:function(e){},error:function(){}})}function checkSensitive(e,t){Util.checkNull(e)?t.call(null,null,null):$.ajax({url:"https://api.mhealth100.com/open-api/sensitive.do",contentType:"application/json",data:JSON.stringify({text:e}),type:"post",success:function(e){if(e=JSON.parse(e||"{}"),console.log(e),e&&"0"==e.resultCode){var o=JSON.parse(e.emotion||"{}"),n=JSON.parse(e.polity||"{}");t.call(null,o,n)}else t.call(null,null,null)},error:function(){ui.hideLoading(),t.call(null,null,null)}})}function showCopyright(e){var t=new Date,o=t.getFullYear(),n="金蝶医疗软件科技有限公司";void 0!==e&&void 0!==e.hospitalShortName&&(n=e.hospitalShortName+" 金蝶医疗"),$(".js__copyright").html("Copyright © 1993-"+o+" "+n)}function ajaxToPrintPageLogs(){$.ajax({url:Util.getBasePath()+"/pageStatisticsLogs!printPageOperatLogs.do",data:$("#pageOperatingLogsForm").serialize(),type:"post",cache:!1,dataType:"json",success:function(e){},error:function(){}})}function showLoading(e){ui.showLoading(e)}function hideLoading(){ui.hideLoading()}var isShow=$("#showOption").val();"true"!==isShow&&("undefined"==typeof WeixinJSBridge?document.addEventListener?document.addEventListener("WeixinJSBridgeReady",onBridgeReady,!1):document.attachEvent&&(document.attachEvent("WeixinJSBridgeReady",onBridgeReady),document.attachEvent("onWeixinJSBridgeReady",onBridgeReady)):onBridgeReady());var tenantId="00309",tenantName="博德嘉联医生集团",isWeixincity="",isShowTenantName='false',hospitalShortName='';window.onerror=function(e,t,o,n,i){if(-1==e.indexOf("WeixinJSBridge"))return ajaxPrintJsError(e,t,o,n,i?i.stack:""),!1},ui.unenableMovetouchDefault();
//# sourceMappingURL=common_footer_v5.min.js.map
</script>
</body>
</html>