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
        .app{position: relative;min-height: 100%;background: #eee;}
        .title{margin:0;font-weight: initial;padding:.8em .5em;font-size:.9em;}
        .title>span{color:#568bfc;}
        .text{background: #fff;padding:.8em .5em;}
        .footer{text-align: center;font-size:.8em;margin-top:-1.5em;position: relative;}
        .btn{margin-left:.8em;font-size:1em;background: #fff;color:#568bfc;border: 1px solid #568bfc;border-radius: 1em;padding:.2em .6em;}
    </style>
</head>
<body >
<div class="app" ng-app="app" ng-controller="myCtrl">
    <h5 class="title">就诊建议</h5>
    <div class="text">如果病情持续或加重，建议尽快到医院就诊。</div>
    <h5 class="title">推荐科室</h5>
<#if listOrg?exists>
    <#list listOrg as item>
    <div class="text flex f-jc-sb" style="border-top:1px solid #d7d5d5;border-bottom:1px solid #d7d5d5">
            <div>${item.organName}</div>
            <div class="flex">
                <button class="btn" onclick="departmentDoctorList(${item.organId},2)">预约挂号</button>
                <button class="btn" onclick="departmentDoctorList(${item.organId},0)">当天挂号</button>
            </div>
    </div>
        <hr style="border:2px double #e8e8e8"/>
    </#list>
</#if>
    <h5 class="title"><span>温馨提示：</span>以上推荐科室仅供参考</h5>
</div>


<script>
    function departmentDoctorList(organId,type) {
        window.location.href='${ctx.contextPath}/registration/departmentDoctorList?valus='+organId+"&type="+type;
    }
</script>
</body>
</html>