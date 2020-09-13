<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        html,body{font-size:12px;font: 12px "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif, sans-serif;height:100%;margin:0;padding:0;font-weight: initial;}
        @media only screen and (min-width: 320px)  {
            body{font-size: 12px;}
        }
        @media only screen and (min-width: 375px)  {
            body{font-size: 14px;}
        }
        @media only screen and (min-width: 414px)  {
            body{font-size: 15px;}
        }
        @media only screen and (min-width: 1200px)  {
            body{font-size: 12px;}
        }
        .flex{display: flex;display: -webkit-flex;justify-content:center;-webkit-justify-content:center;align-items:center;-webkit-align-items:center;}
        .f-v{flex-direction:column;-webkit-flex-direction:column;}/*垂直排列*/
        .f-w{flex-wrap:wrap;-webkit-flex-wrap:wrap;}/*溢出换行*/
        .f-jc-sb{justify-content:space-between !important;-webkit-justify-content:space-between !important;}/*flex两端对齐*/
        .f-jc-l{justify-content:flex-start;-webkit-justify-content:flex-start;}/*左对齐*/
        .f-all-width{flex-grow:1;-webkit-flex-grow:1;}
        .f-width10{flex-basis:10%;-webkit-flex-basis:10%;min-width: 10%;}
        .f-width20{flex-basis:20%;-webkit-flex-basis:20%;min-width: 20%;}
        .f-width30{flex-basis:30%;-webkit-flex-basis:30%;min-width: 30%;}
        .f-width40{flex-basis:40%;-webkit-flex-basis:40%;min-width: 40%;}
        .f-width50{flex-basis:50%;-webkit-flex-basis:50%;min-width: 50%;}
        .f-width60{flex-basis:60%;-webkit-flex-basis:60%;min-width: 60%;}
        .f-width70{flex-basis:70%;-webkit-flex-basis:70%;min-width: 70%;}
        .f-width80{flex-basis:80%;-webkit-flex-basis:80%;min-width: 80%;}
        .app{position: relative;min-height: 100%;}
        .z-tap{text-align: center;height:4em;padding:1em;border-bottom:1px solid #ddd;box-sizing: border-box;}
        .z-tap>div{padding:.3em 0;background:#ddd;}
        .z-tap>div:first-child{border-top-left-radius: .5em;border-bottom-left-radius: .5em;}
        .z-tap>div:last-child{border-top-right-radius: .5em;border-bottom-right-radius: .5em;}
        .z-tap>div.cur{background:#568bfc;color:#fff;}
        .content{position: absolute;top:4em;left:0;right:0;bottom:0;background:#eee;overflow: auto;}
        .around{position: absolute;background: #568bfc;width:2em;height: 2em;bottom:1.5em;right:1.5em;padding:.5em;color:#fff;border-radius: 50%;z-index: 3;}
        .selItem{padding:1em;position: absolute;top:1em;left:1em;z-index: 3;}
        .selItem.selItem2{right: 1em;left:initial;}
        .selItem{background: #ddd;text-align: center;padding:.2em;border-radius: 1.5em;font-size:.9em;}
        .selItem>div{padding:.3em .6em;min-width:2em;}
        .selItem>div.cur{background:#568bfc;border-radius: 1.5em;color:#fff;}
        /* .content img.portrait{position: absolute;top:0;bottom:0;left:0;right:0;z-index: 2;width: 100%;} */
        .content img.portrait{position: relative;z-index: 2;margin: auto;display: block;height: 100%;}

        .popup-mask{position: absolute;top:0;right:0;left:0;bottom:0;z-index: 10;background: rgba(0,0,0,.2);display: none;}
        .popup{position: absolute;top:0;right:0;bottom:0;width:70%;z-index: 11;background:#fff;display: none;transform: translateX(100%);transition: .2s linear;overflow: auto;}

        .list,.list dt,.list dd,.list li{list-style: none;padding:0;margin:0;}
        .list dt{text-align: center;color:#568bfc;padding:.8em 0;font-size:1.1em;border-bottom: 1px solid #ddd;}
        .list dd,.list li{padding:.8em;border-bottom: 1px solid #ddd;background: #fff;}

        .popup-mask.show1{display: block;}
        .popup.show1{display: block;}
        .popup.show2{display: block;transform: translateX(0%);}
        .imgBox{height: 100%;}
    </style>
</head>
<body >
<div class="app" ng-app="app" ng-controller="myCtrl" >
    <div class="flex z-tap">
        <div class="f-width50" ng-class="{cur: ishow === 1}" ng-click="tapClick(1)">身体部位</div>
        <div class="f-width50" ng-class="{cur: ishow === 2}" ng-click="tapClick(2)">列表</div>
    </div>
    <div class="content">
        <div ng-if="ishow === 1" class="imgBox">
            <div class="flex selItem">
                <div ng-class="{cur: sex === 'male'}" ng-click="sexClick('male')" ng-if="age == 'children'">男</div>
                <div ng-class="{cur: sex === 'female'}" ng-click="sexClick('female')">女</div>
            </div>
            <div class="flex selItem selItem2">
                <div ng-class="{cur: age === 'adult'}" ng-click="ageClick('adult')" ng-if="sex == 'female'">成人</div>
                <div ng-class="{cur: age === 'children'}" ng-click="ageClick('children')">儿童</div>
            </div>
            <div class="around flex f-v" ng-click="around(face)">转身</div>
            <img usemap="#man" ng-src="{{img}}" class="portrait" alt="" id="z-images">
            <map name="man" id="man" ng-if="age === 'adult' && sex === 'female'">
                <!-- 女人 -->
                <!--头部-->
                <area shape="rect" coords="{{calculate('168,56,218,76')}}" ng-if="face === 0" ng-click="rq({bodyPart: '眼'})" />
                <area shape="rect" coords="{{calculate('187,67,202,86')}}" ng-if="face === 0" ng-click="rq({bodyPart: '鼻'})" />
                <area shape="rect" coords="{{calculate('182,84,205,100')}}" ng-if="face === 0" ng-click="rq({bodyPart: '口'})" />
                <area shape="rect" coords="{{calculate('157,65,171,88')}}" ng-if="face === 0" ng-click="rq({bodyPart: '耳'})" />
                <area shape="rect" coords="{{calculate('217,61,231,84')}}" ng-if="face === 0" ng-click="rq({bodyPart: '耳'})" />
                <area shape="rect" coords="{{calculate('159,11,229,109')}}"  ng-click="rq({bodyPart: '头部'})" />
                <!--脖子-->
                <area shape="rect" coords="{{calculate('127,109,261,148')}}" ng-click="rq({bodyPart: '颈部'})" />
                <!--正面0 反面1-->
                <area shape="rect" coords="{{calculate('137,161,249,224')}}" ng-if="face === 0" ng-click="rq({bodyPart: '胸部'})" />
                <area shape="rect" coords="{{calculate('144,221,242,299')}}" ng-if="face === 0" ng-click="rq({bodyPart: '腹部'})" />
                <area shape="rect" coords="{{calculate('145,138,241,298')}}" ng-if="face === 1" ng-click="rq({bodyPart: '背部'})" />
                <!--左上肢-->
                <area shape="rect" coords="{{calculate('54,261,109,393')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('91,122,141,273')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('81,257,131,328')}}" ng-click="rq({bodyPart: '上肢'})" />
                <!--右上肢-->
                <area shape="rect" coords="{{calculate('279,324,332,392')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('246,127,296,278')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('256,279,306,349')}}" ng-click="rq({bodyPart: '上肢'})" />
                <!--左下肢-->
                <area shape="rect" coords="{{calculate('128,362,192,721')}}" ng-click="rq({bodyPart: '下肢'})" />
                <!--右下肢-->
                <area shape="rect" coords="{{calculate('195,361,259,720')}}" ng-click="rq({bodyPart: '下肢'})" />
                <!--臀部-->
                <area shape="rect" coords="{{calculate('125,304,263,368')}}" ng-click="rq({bodyPart: face ? '臀部' : '生殖器'})" />
            </map>
            <map name="man" id="man" ng-if="age === 'children'">
                <!-- 孩子 -->
                <!--头部-->
                <area shape="rect" coords="{{calculate('146,124,224,150')}}" ng-if="face === 0" ng-click="rq({bodyPart: '眼'})" />
                <area shape="rect" coords="{{calculate('176,148,191,173')}}" ng-if="face === 0" ng-click="rq({bodyPart: '鼻'})" />
                <area shape="rect" coords="{{calculate('162,174,213,192')}}" ng-if="face === 0" ng-click="rq({bodyPart: '口'})" />
                <area shape="rect" coords="{{calculate('106,131,137,175')}}" ng-if="face === 0" ng-click="rq({bodyPart: '耳'})" />
                <area shape="rect" coords="{{calculate('232,129,263,173')}}" ng-if="face === 0" ng-click="rq({bodyPart: '耳'})" />
                <area shape="rect" coords="{{calculate('100,32,267,207')}}"  ng-click="rq({bodyPart: '头部'})" />
                <!--脖子-->
                <area shape="rect" coords="{{calculate('118,198,254,226')}}" ng-click="rq({bodyPart: '颈部'})" />
                <!--正面0 反面1-->
                <area shape="rect" coords="{{calculate('119,268,257,327')}}" ng-if="face === 0" ng-click="rq({bodyPart: '胸部'})" />
                <area shape="rect" coords="{{calculate('117,327,258,406')}}" ng-if="face === 0" ng-click="rq({bodyPart: '腹部'})" />
                <area shape="rect" coords="{{calculate('117,225,256,398')}}" ng-if="face === 1" ng-click="rq({bodyPart: '背部'})" />
                <!--左上肢-->
                <area shape="rect" coords="{{calculate('73,232,116,329')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('27,348,86,480')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('72,326,110,399')}}" ng-click="rq({bodyPart: '上肢'})" />
                <!--右上肢-->
                <area shape="rect" coords="{{calculate('257,233,300,330')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('272,353,331,485')}}" ng-click="rq({bodyPart: '上肢'})" />
                <area shape="rect" coords="{{calculate('262,315,300,388')}}" ng-click="rq({bodyPart: '上肢'})" />
                <!--左下肢-->
                <area shape="rect" coords="{{calculate('109,495,185,724')}}" ng-click="rq({bodyPart: '下肢'})" />
                <!--右下肢-->
                <area shape="rect" coords="{{calculate('191,498,274,720')}}" ng-click="rq({bodyPart: '下肢'})" />
                <!--臀部-->
                <area shape="rect" coords="{{calculate('104,400,271,498')}}" ng-click="rq({bodyPart: face ? '臀部' : '生殖器'})" />
            </map>
        </div>
        <div ng-if="ishow === 2">
            <ul class="list">
                <li ng-repeat="item in list2 track by $index" ng-click="rq(item)">{{item.bodyPart}}</li>
            </ul>
        </div>
    </div>
    <div class="popup-mask" ng-class="{show1: anim >= 1}" ng-click="rq('close')"></div>
    <div class="popup" ng-class="{show1: anim >= 1, show2: anim >= 2}">
        <dl class="list">
            <dt>{{listTitle}}</dt>
            <dd ng-repeat="item in list track by $index" ng-click="depart(item)">{{item.symptoms}}</dd>
        </dl>
    </div>
</div>
<script type="text/javascript" src="${ctx.contextPath}/js/lib/angular.js"></script>
<script>

    angular.module('app', []).controller('myCtrl', function ($scope, $timeout, $http) {

        var obj = {
            data: function () {
                $scope.ishow = 1;
                $scope.children = {
                    male: ['${ctx.contextPath}/image/intelguide/nh1.png', '${ctx.contextPath}/image/intelguide/nh2.png'],
                    female: ['${ctx.contextPath}/image/intelguide/nhz1.png', '${ctx.contextPath}/image/intelguide/nhz2.png'],
                };
                $scope.adult = {
                    male: ['${ctx.contextPath}/image/intelguide/dr1.png', '${ctx.contextPath}/image/intelguide/dr2.png'],
                    female: ['${ctx.contextPath}/image/intelguide/nr1.png', '${ctx.contextPath}/image/intelguide/nr2.png'],
                };
                $scope.age = 'adult';
                $scope.sex = 'female';
                $scope.face = 0;
                $scope.img = $scope[$scope.age][$scope.sex][$scope.face];

                $scope.list = [{text: '123'}];
                $scope.listTitle = '上肢';

                $scope.list2 = [];

                $scope.anim = 0;

            },
            event: function () {
                var anim = function (type) {
                    if (type) {
                        $scope.anim = 1;
                        $timeout(function () {
                            $scope.anim = 2;
                        }, 100);
                    } else {
                        $scope.anim = 1;
                        $timeout(function () {
                            $scope.anim = 0;
                        }, 200);
                    }
                }

                var getList2 = function () {
                    $http({
                        method: 'GET',
                        url: '${ctx.contextPath}/symptomsOrgan/getBodyListPart'
                    }).then(function (data) {
                        // console.log(data);
                        $scope.list2 = data.data;
                    });
                }

                $scope.depart = function (item) {
                    window.location.href='${ctx.contextPath}/symptomsOrgan/diagnosis?sex='
                            + item.sex+ '&bodyPart='+ item.bodyPart+"&symptoms="+item.symptoms;
                }

                $scope.imgProblem = function () {
                    $scope.img = $scope[$scope.age][$scope.sex][$scope.face];
                }
                $scope.tapClick = function (val) {
                    if (val === 2 && !$scope.list2.length) {
                        getList2();
                    }
                    $scope.ishow = val;
                }
                $scope.sexClick = function (val) {
                    $scope.sex = val;
                    $scope.imgProblem();
                }
                $scope.ageClick = function (val) {
                    $scope.age = val;
                    $scope.imgProblem();
                }
                $scope.around = function (val) {
                    $scope.face = val ? 0 : 1;
                    $scope.imgProblem();
                }


                $scope.rq = function (item) {
                    if (item === 'close') {
                        anim(0);
                    } else {
                        // 请求
                        $http({
                            method: 'GET',
                            url: '${ctx.contextPath}/symptomsOrgan/getOrganList?sex=' + $scope.sex + '&age='+$scope.age+ '&bodyPart=' + item.bodyPart
                        }).then(function (data) {
                            $scope.listTitle = item.bodyPart;
                            $scope.list = data.data;
                            anim(1);
                        });
                    }
                }

                $scope.calculate = function (valstr) {
                    var arr = valstr.split(',');
                    $scope.imagesDom = document.getElementById('z-images');

                    if (!$scope.imagesDom) {
                        return valstr;
                    }

                    var width = $scope.imagesDom.offsetWidth;
                    width = width==0?240:width;
                    // var height = 739 - $scope.imagesDom.offsetHeight;
                    // var proportion = (width / height).toFixed(2);
                    var proportion = null;
                    var arr2 = [];

                    if (389 >= width) {
                        proportion = 389 / width;
                        for (var i in arr) {
                            arr2[i] = parseInt(Number(arr[i]) / Number(proportion));
                        }
                    } else {
                        proportion = width / 389;
                        for (var i in arr) {
                            arr2[i] = parseInt(Number(arr[i]) * Number(proportion));
                        }
                    }

                    return arr2.join();
                }
            },
            init: function () {
                this.data();
                this.event();

            }


        }

        obj.init();
    });

</script>
</body>
</html>