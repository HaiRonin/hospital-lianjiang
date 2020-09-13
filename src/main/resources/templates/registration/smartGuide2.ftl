<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="format-detection" content="telephone=no" />
    <title>智能导诊</title>

    <link rel="stylesheet" href="${ctx.contextPath}/css/kdui/kdui.min.css" />
    <script src="${ctx.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${ctx.contextPath}/js/iscroll.min.js" defer="defer"></script>
    <script type="text/javascript" src="${ctx.contextPath}/js/lib/angular.js"></script>
    <style>.smart-tab{height:.9rem;text-align:center;background:#FFF;width:100%;padding:.2rem .3rem}.smart-tab .smart-tab__item{width:50%;height:.5rem;line-height:.5rem;float:left;color:#222;background:#aaa}.smart-tab .smart-tab__item.smart-tab__item-left{border-radius:.1rem 0 0 .1rem}.smart-tab .smart-tab__item.smart-tab__item-right{border-radius:0 .1rem .1rem 0}.smart-tab .smart-tab__item.smart-tab__item_selected{color:#FFF;background:#007aff}.kdui-switch-tab__wrap{position:absolute;z-index:100;top:1rem;width:1.6rem}.kdui-switch-tab__wrap.kdui-switch-tab__wrap-left{left:.3rem}.kdui-switch-tab__wrap.kdui-switch-tab__wrap-right{right:.3rem}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__gender:before{content:'女'}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__gender:after{content:'男'}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__age:before{content:'儿童'}.kdui-switch-tab__wrap .kdui-switch-tab.kdui-switch-tab__age:after{content:'成人'}.smart-rotate-button{z-index:100;position:absolute;right:.3rem;bottom:.3rem;height:.8rem;width:.8rem;border-radius:.4rem;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEQAAABECAMAAAAPzWOAAAAAhFBMVEX///81neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neQ1neRotuvz+f3///+Bwu50vOxCo+aOyPCTy/GazvKh0fK02vW83vbA4ffN5/jX6/rm8/zy+P1Oqedbr+lCpObJ5fh4vu1dsena7frk8vun1POu2PRQquiGxO9rt+scp+dLAAAADXRSTlMAECAwUGCAkLDA0ODwMDZX9QAAAzJJREFUeF61mOmSqjAQheWKKGpnYd0X12Xm/d/vohA6GCOgNeeHWKX1cXpJSDPTyjAtew2t1rZlGrOJmi/XoGi9nE9ALARB5SzGEQxrC2+0tYwRLjYwoM2Qm382jJD9762NLYzS1tQzljBaS11GVwqAeEF6VxAQF/paGS8ZT3UtvRM7RQEnhDhBVH/3yn61jUEGSVnk9O7uRDR1BiirPoIGgoByeX4ickTvcupeBEKRRxNXm10TUNUpLUEnN8krpJi9HttKsdMA3sljHPtF7jobGRz/oxGhSLGRsZAYtIIhVRJl0VV3o/w+ROmKtBF1tjBtuQdjxGmXequFYFaTBMbpkna5fc6IQ92REDfn/axgv+Mvg6qCrvvvjDlGmsMnmmPDo5GpWsrROFONYDwGCEXY7sXP43K9IuDwq6UY0tLD2t/Y7XE9+wjJQi3ExE4jGM1h3xpq7+5nWcayh15BLFx7QQRCPqvls0ZHgDA7NPLZDlTZmNfEEz7CNhq/MTQIWc8el7QCSAlUaUM5HwqoFYcCUmStXkJg1m0AtKxo1BalgZx/OifCpA4iKEww4PxbQ46sVdx34h8FoJQggsIEoyY8nPgZqDmJC1H2iHGECAqLhPnGwS5r//57iBGSHQWDMsoRoriDxknRwq6ZUI2+CcYjfo4QRX5c7FldozvNR/L+HLJdxygp1BQdJGNhXBxhF7JryA6IKMJdV520ApKC6AlsNuiF03wyUWR/z+Jbv8Regs1m6yGw2xd3Jz9xUVyPUCc2PsOLRW/PLA2k0TW8V2vvN2EyKUOQE1yAJgxKVGQnt2tJpa3AgIlSF72B2+NE5Y683S8/YvC8t1HPPzPCe48MjCeoPjGy7j9GeT76KUodEFo8PdDTyxBAffBvn48WJeWjGJ5k2VIOOWTgnKSepjYGHremn7YwI0K2RCF6gHoytF8fQTnz3re7KAweQdWAoMoTfaXL9CTHa2pHHTehGjNuQC/yDZbvBgRyyrn7CpH2ErYaGFWclPYnFZdHLCWTBh6cmRxCCMeZSWEMjm8uCdrpzVPrvjL+YJBEmdNG2u+H6+/H/O9fOHz/6uMvX8J8/zroPypt1kzv9LSwAAAAAElFTkSuQmCC);background-size:.8rem}.smart-body__image-wrap{display:block;position:relative;top:0;z-index:99}.divya,.pic_arrow{position:absolute}.smart-body__image-wrap img{max-width:100%;height:auto;margin:auto;background-size:cover;vertical-align:middle;text-align:center}.divya,.divya1{z-index:1000;width:100%;height:100%;top:0;left:0}.divya{display:none}.divya1{background-color:#000;-moz-opacity:.7;opacity:.7;filter:alpha(opacity=70);margin:0}.divya-top{background:#fff;color:#007aff;line-height:.9rem;height:.9rem;text-align:center;border-bottom:1px solid #e6e6e6}.pic_arrow{left:10%;top:45%;width:.34rem;height:.42rem;background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABEAAAAVCAMAAACXIvXeAAAAS1BMVEVsbGz///9sbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGxsbGyxa3U6AAAAGXRSTlMAAAEEBQcKDUdIS05RVVtccnh9f4CDhYaHPXnfnwAAAFVJREFUeF6F0DkSgCAQRNEGFFwAd+X+JzVQkp/Q4aup2WSYT2LQnyp5txClw0KUTgdRvDqI5ruHaHo8REPxEI2bg6isjZrah7O4D3fmXY3bF/yHP2ReWUgDMXgw3PoAAAAASUVORK5CYII=);background-size:.34rem .42rem}</style>

    <!-- 引入高清解决方案 -->
    <script>!function(e){function t(a){if(i[a])return i[a].exports;var n=i[a]={exports:{},id:a,loaded:!1};return e[a].call(n.exports,n,n.exports,t),n.loaded=!0,n.exports}var i={};return t.m=e,t.c=i,t.p="",t(0)}([function(e,t){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=window;t["default"]=i.flex=function(e,t){var a=e||100,n=t||1,r=i.document,o=navigator.userAgent,d=o.match(/Android[\S\s]+AppleWebkit\/(\d{3})/i),l=o.match(/U3\/((\d+|\.){5,})/i),c=l&&parseInt(l[1].split(".").join(""),10)>=80,p=navigator.appVersion.match(/(iphone|ipad|ipod)/gi),s=i.devicePixelRatio||1;p||d&&d[1]>534||c||(s=1);var u=1/s,m=r.querySelector('meta[name="viewport"]');localStorage.setItem("initial-scale", u);m||(m=r.createElement("meta"),m.setAttribute("name","viewport"),r.head.appendChild(m)),m.setAttribute("content","width=device-width,user-scalable=no,initial-scale="+u+",maximum-scale="+u+",minimum-scale="+u),r.documentElement.style.fontSize=a/2*s*n+"px"},e.exports=t["default"]}]);  flex(100, 1);</script>
</head>
<script>
    var organId = ${organId};
    var app = angular.module("app",[]);
    app.controller('symptomsOrganController', function ($scope, $http) {
        $scope.bodyPart={};
        $scope.queryDepartmentById = function() {
            $http({
                method: 'GET',
                url: '${ctx.contextPath}/symptomsOrgan/getBodyListPart'
            }).then(function (data) {
                $scope.bodyPart=data.data;
            });
        }
        var myScroll;
        $scope.loadIscroll = function(){
            myScroll = new IScroll('#wrapper',{hScrollbar:false,vScrollbar:false});
        }

        $scope.setTab = function (e, t, m, n) {
            1 == m ? $(".smart-tab").removeClass("kdui-border_b") : $(".smart-tab").addClass("kdui-border_b");
            for (var i = 1; i <= n; i++) {
                var d = document.getElementById(t + i),
                        c = document.getElementById("con_" + t + i),
                        o = document.getElementById("more_" + t + i);
                i == m ? $(d).addClass("smart-tab__item_selected") : $(d).removeClass("smart-tab__item_selected"), c.style.display = i == m ? "block" : "none", o && (o.style.display = i == m ? "block" : "none")
            }
            myScroll && myScroll.refresh()
        }


        $scope.setSmartImg = function () {
            //成人还是儿童
            var gender = $("#gender").val();
            //男还是女
            var gender = $("#sex").val();
            //正面还是背面
            var gender = $("#zb").val();


        }

        //设置成人还是儿童
        $scope.gender = 'M';
        $scope.setManOrBoy = function() {
            $scope.gender =  $scope.gender == 'M'?'L':'M';
            $scope.setSmartImg();
        }
        //设置男还是女
        $scope.sex = 'M';
        $scope.setSex =function() {
            $scope.sex = $scope.sex == 'W'?'M':'W';
            $scope.setSmartImg();
        }

        //设置正面还是反面
        $scope.zb = 'M';
        $scope.setZMorBM =function() {
            $scope.zb = $scope.zb == 'Z'?'B':'Z';
            $scope.setSmartImg();
        }

        $scope.symptoms={};
        $scope.getDis = function(bodyPart) {
            var sex = "w";
            $http({
                method: 'GET',
                url: '${ctx.contextPath}/symptomsOrgan/getOrganList?sex='+sex+"&bodyPart="+bodyPart
            }).then(function (data) {
                debugger;
                $scope.symptoms=data.data;
                $scope.choisePart(bodyPart, $scope.symptoms, sex);
            });
        }

        $scope.queryDepartmentById();
        $scope.loadIscroll();
    });

</script>
<body ng-app="app" ng-controller = "symptomsOrganController">
<div >
<!-- 切换tab（身体部位、列表） -->
<div class="smart-tab">
    <div id="a1" class="smart-tab__item smart-tab__item-left smart-tab__item_selected" ng-click="setTab('smart-tab__item','a',1,2)">身体部位</div>
    <div id="a2" class="smart-tab__item smart-tab__item-right" ng-click="setTab('smart-tab__item','a',2,2)">列表</div>
</div>

<!-- 人体部位 -->
<div id="con_a1">

    <div class="kdui-text_center" id="boxbg">
        <div id="mzm"><img  src="${ctx.contextPath}/image/intelguide/MMZ.png" usemap="#Map" />
        </div>
        <div id="nzm" style="display: none;"><img src="${ctx.contextPath}/image/intelguide/FMZ.png" usemap="#Map" />
        </div>

        <div class="kdui-switch-tab__wrap kdui-switch-tab__wrap-left" id="adult_switch">
            <input id="sex_switch" class="kdui-switch-tab kdui-switch-tab__gender" type="checkbox" ng-click="setSex()" />
        </div>
        <div class="kdui-switch-tab__wrap kdui-switch-tab__wrap-right" id="children_switch">
            <input id="age_switch" class="kdui-switch-tab kdui-switch-tab__age" type="checkbox"ng-click="setManOrBoy()" />
        </div>
        <div id="mid" class="smart-rotate-button" ng-click="setZMorBM()">
        </div>
    </div>
</div>

<!-- 列表 -->
<div class="kdui_wrapper kdui_wrapper__top_sm" id="wrapper" >
    <div class="kdui_scroller" id="scroller">
        <!-- 列表数据 -->
        <div class="kdui-flex__item" id="con_a2" style="display:none;">
            <div class="kdui-cells">

                <a href="javascript:;" class="kdui-cell_access" ng-repeat="data in bodyPart"
                   ng-click="getDis(data.bodyPart)">
                    <div class="kdui-cell">
                        <div class="kdui-cell__bd">{{data.bodyPart}}</div>
                        <div class="kdui-cell__ft"></div>
                    </div>
                </a>

            </div>
        </div>

    </div>
</div>
</div>
<script>

</script>
</body>
</html>