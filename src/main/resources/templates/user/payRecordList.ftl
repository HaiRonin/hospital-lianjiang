<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>已缴费处方记录详情</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<div class="c-main pb15 appoin">
    <div class="detailsInfo" id="detailsInfoList" style="width: 95%; margin: 10px auto;margin-top: 10px; margin-right: auto; margin-bottom: 10px; margin-left: auto">
      <ul>

      </ul>
        <div id="listInfo">

        </div>
    </div>
</div>
<script>
    $.showPreloader('加载中...');
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        firsDayOfMonth = this.fun_date(-30);
        currDay = this.fun_date(1);
    });
    $(document).ready(function () {
         getQueryString();
         patientNo = getQueryString("patientNo");
         startDate = getQueryString("startDate");
         endDate = getQueryString("endDate");
         name = getQueryString("name");
         hiFeeNo = getQueryString("hiFeeNo");
        details();
    });

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return null;
    }
    var patientNo =null;
    var startDate = null;
    var endDate = null;
    var name =null;
    var hiFeeNo = null;

      function details() {
          var json = {
              "startDate": startDate,
              "endDate": endDate,
              "patientNo": patientNo,
              "synUserName": "",
              "synKey": ""
          };
          $.ajax({
              url: "../his/request",
              method: "POST",
              dataType: 'json',
              data: {
                  api: "/querypaymentrecordlist",
                  dataParam: JSON.stringify(json)
              },
              success: function (result) {
                  if (result != null) {
                      if (result.resultCode === "00") {
                          if (result.hiFee.length > 0) {
                              console.log(result);
                              $('#noData').hide();
                              $.each(result.hiFee, function (i, item) {
                                  var data = JSON.stringify(item);
                                  if(hiFeeNo ==item.hiFeeNo){
                                      var isPrint =null;
                                      if(item.isPrint=="0"){
                                          isPrint="未打印";
                                      }else {
                                          isPrint="已打印";
                                      }
                                      console.log(data);
                                      $('.detailsInfo ul').append("<li class=\"islink\">\n"+ "<div class=\"c-list-mess\">\n" +"<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145 ;width: 50%;margin-top: 0;'>" +"患者名称"+":" + item.patientName+ "</span>\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145; width: 50%; margin-top: 0;text-align: right '>" +"缴费编号"+":"+ item.hiFeeNo + "</span>\n" +"</div>\n" +"<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;'>" +"患者编号"+":"+ item.patientNo + "</span>\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145; width: 50%;margin-top: 0;text-align: right'>" +"收费员名称"+":"+ item.organdoctorId+ "</span>\n" +"</div>\n" +"<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;'>" +"挂号医生名称"+":"+ item.doctorName +"</span>\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;text-align: right '>" +"就诊科室名"+":"+ item.organName +"</span>\n" +"</div>\n" +"<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;'>" +"门诊流水号"+":"+ item.serialNumber +"</span>\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;text-align: right '>" +"打印状态"+":"+ isPrint +"</span>\n" +"</div>\n" +"<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;'>" +"结算金额"+":"+ item.settleAmount +"</span>\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;text-align: right'>" +"自费金额"+":"+ item.patientAmount +"</span>\n" +"</div>\n" +"<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;'>" +"就诊日期"+":"+ item.visitDate  +"</span>\n" +
                                              " <span class=\"c-nowrap mt5\" style='color: #3d4145;width: 50%;margin-top: 0;text-align: right'>" +"订单创建时间"+":"+ item.createTime +"</span>\n" +"</div>\n" +"<div style=\"height: 60px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">\n" +
                                              "</span>\n" +"</div>\n" +"</div>\n" + " </li>")
                                      $.each(item.hiFeeItem, function (i, item1) {
                                          var data1 = JSON.stringify(item1);
                                          console.log(data1);
                                          $("#listInfo").append(
                                                  "<div style=\"padding-top:12px;\">\n"+
                                                  "                <h5>名称：" + item1.feeItemName + "</h5>\n" +
                                                  "                 <h5>单价：" + item1.feeItemAmount + "元</h5>\n" +
                                                  "                 <h5>数量：" + item1.feeItemNum + item1.feeItemUnit+"</h5>\n" +
                                                  "                 <em>规格：" + item1.feeItemStandard + "元</em>\n" +
                                                  "                <h5>总价：" + item1.feeItemAllAmount + "</h5>\n" +
                                                  "</div>")
                                      });
                                  }
                              });
                              return;
                          }
                          $('#noData').show();
                      }

                  }
              },
              error: function (e) {
                  $.toast("获取失败，请稍后再试!");
              }
          });


    }
</script>
</body>
</html>