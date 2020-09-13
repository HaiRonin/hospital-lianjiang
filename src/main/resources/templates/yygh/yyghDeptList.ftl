<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <title></title>
    <style type="text/css">
        .time-period {
            display: inline-block;
            width: 4.5rem;
            height: 1.5rem;
            line-height: 1.5rem;
            text-align: center;
            border-radius: 4px;
            background: green;
            color: #fff;
        }
    </style>

</head>

<body>
<div class="page-group">
    <div class="page">
        <header class="bar bar-nav">
            <h1 class="title">预约挂号</h1>
        </header>
        <div class="content">
            <div class="list-block" style="margin: 0;">
                <ul>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label"><i style="color: red;">* </i>姓名</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入姓名" required="required" name="Name"
                                           id="Name">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label"><i style="color: red;">* </i>就诊卡号</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入就诊卡号" required="required" name="CardNo"
                                           id="CardNo">
                                </div>
                            </div>
                        </div>
                    </li>

                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label"><i style="color: red;">* </i>住院号</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入就住院号" required="required" name="CardNo"
                                           id="inHosNo">
                                </div>
                            </div>
                        </div>
                    </li>

                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label"><i style="color: red;">* </i>身份证号</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入身份证号" required="required" name="IDCardno"
                                           id="IDCardno">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label"><i style="color: red;">* </i>联系电话</div>
                                <div class="item-input">
                                    <input type="text" placeholder="请输入联系电话" required="required" name="Mobile"
                                           id="Mobile">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-gender"></i></div>
                            <div class="item-inner">
                                <div class="item-title label"><i style="color: red;">* </i>性别</div>
                                <div class="item-input">
                                    <select name="Sex" id="Sex">
                                        <option value="1">男</option>
                                        <option value="0">女</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label">家庭住址</div>
                                <div class="item-input">
                                    <input type="text" id="address" placeholder="请输入家庭住址">
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content-block">
                <p><a class="button button-big button-fill" onclick="submitInfo()">提交</a></p>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    function submitInfo() {

       var doRegIn={
           "organdoctorId": "260",
           "departmentorganId": "105",
           "cardNo":"450121198805095111",
           "patientNo":"0514551",
           "socialsecurityNO":"",
           "sourceDate":"2019-1-15",
           "timestypeNo":"0",
           "sourceTimeType":"2",
           "payType":"2",
           "payNo":"000100000068",
           "payAmount":"6"

       }
        var data = {
            "synUserName": "测试1",
            "synKey": "",
            "doRegIn":doRegIn,
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/dopay",
                dataParam: JSON.stringify(dataInfo)
            },
            async: false,
            success: function (result) {
                var msg = "";
                if (result != null) {
                    if (result.resultCode === '00') {
                        $.toast("绑定成功!");
                        self.location = document.referrer;
                        return
                    }
                    msg = result.resultMsg;
                }
                $.toast(msg);
            },
            error: function () {
                $.toast("服务器维护中,稍后重试!");
            }
        });
    }
</script>
</body>

</html>