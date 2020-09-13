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
    <title>信息绑定</title>
</head>

<body>
<div class="page-group">
    <div class="page">
        <div class="content">
            <div class="list-block" style="margin: 0;">
                <ul>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <span style="color:red;">*</span> <div class="item-title label">姓名</div>
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
                                 <div class="item-title label">身份证号码</div><span style="font-size:10px;color:#d70f18">
                                <div class="item-input">
                                    <input type="text" placeholder="请输入身份证号码" required="required" name="iDCardno"
                                           id="iDCardno">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label">就诊卡号<span style="font-size:10px;color:#d70f18">(选填)</span></div>
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
                                <div class="item-title label">住院号<span style="font-size:10px;color:#d70f18">(选填)</span></div>

                                <div class="item-input">
                                    <input type="text" placeholder="请输入就住院号" required="required" name="inHosNo"
                                           id="inHosNo">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <div class="item-title label">门诊号<span style="font-size:10px;color:#d70f18">(选填)</span></div>

                                <div class="item-input">
                                    <input type="text" placeholder="请输入门诊号" required="required" name="PatientNo"
                                           id="PatientNo">
                                </div>
                            </div>
                        </div>
                    </li>

                    <li>
                        <div class="item-content">
                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                            <div class="item-inner">
                                <span style="color:red;">*</span><div class="item-title label">联系电话</div>
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
                                <span style="color:red;">*</span><div class="item-title label">性别</div>
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
                <p id="btn_add" class="button button-big button-fill" onclick="submitInfow()">提交</p>
                <p id="btn_update" class="button button-big button-fill" onclick="userUpate()">修改</p>
                <span style="font-size:15px;color:#d70f18">温馨提示：</span>
                <p style="font-size:14px;margin-top: 2px; color: #d70f18">1.身份证号码，就诊卡号，住院号，门诊号，可以四个选择一个。</p>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    function submitInfow() {

        var name = $('#Name').val();
        if (name == '') {
            $.toast("请填写姓名!");
            return
        }
        var inHosNo = $('#inHosNo').val();

        var cardNo = $('#CardNo').val();

        var iDCardno = $('#iDCardno').val();

        var mobile = $('#Mobile').val();
        var PatientNo = $('#PatientNo').val();
        if(iDCardno==''&&cardNo==''&&inHosNo==''&&PatientNo==''){
            $.toast("填写基本信息，请重填");
            return
        }


        if (mobile == '') {
            $.toast("请填写手机号码!");
             return
        }else {
            if(!(/^1[34578]\d{9}$/.test(mobile))){
                $.toast("手机号码有误，请重填");
                return
            }
        }


        if (iDCardno == '') {

        }else {
            if(validateIdCard(iDCardno) === false) {
                $.toast("身份证输入不合法");
                return
            }
        }

        var address = $('#address').val();


        var sex = $("#Sex").val();


        var data = {
            "Name": name,
            "IDCardno": iDCardno,
            "Sex": sex,
            "address": address,
            "Mobile": mobile,
            "inHosNo": inHosNo,
            "synUserName": "",
            "PatientNo":PatientNo,
            "synKey": "",
            "CardNo": cardNo,
            "id": window.localStorage.getItem("openId")
             //"id": 'oKuwuv3fRIi_C26FkR6W0OzOtSBk'
        }
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/addPatients",
                dataParam: JSON.stringify(data)
            },
            async: false,
            success: function (result) {
                var msg = "";
                if (result != null) {
                    if (result.resultCode === '00') {
                        $.toast("绑定成功!");
                        self.location = document.referrer;
                        window.location.href = '../user/memberList'
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

    function validateIdCard(idCard) {
        var regIdCard = /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;

        if (regIdCard.test(idCard)) {
            if (idCard.length == 18) {
                var idCardWi = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9,
                        10, 5, 8, 4, 2);
                var idCardY = new Array(1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2);
                var idCardWiSum = 0;
                for (var i = 0; i < 17; i++) {
                    idCardWiSum += idCard.substring(i, i + 1) * idCardWi[i];
                }
                var idCardMod = idCardWiSum % 11;//计算出校验码所在数组的位置
                var idCardLast = idCard.substring(17);//得到最后一位身份证号码

                //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                if (idCardMod == 2) {
                    if (idCardLast == "X" || idCardLast == "x") {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                    if (idCardLast == idCardY[idCardMod]) {
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        } else {
            return false;
        }
    }


    
    function userUpate() {
        var name = $('#Name').val();
        if (name == '') {
            $.toast("请填写姓名!");
            return
        }
        var inHosNo = $('#inHosNo').val();

        var cardNo = $('#CardNo').val();

        var iDCardno = $('#iDCardno').val();

        var mobile = $('#Mobile').val();
        var PatientNo = $('#PatientNo').val();
        if(iDCardno==''&&cardNo==''&&inHosNo==''&&PatientNo==''){
            $.toast("填写基本信息，请重填");
            return
        }


        if (mobile == '') {
            $.toast("请填写手机号码!");
            return
        }else {
            if(!(/^1[34578]\d{9}$/.test(mobile))){
                $.toast("手机号码有误，请重填");
                return
            }
        }


        if (iDCardno == '') {

        }else {
            if(validateIdCard(iDCardno) === false) {
                $.toast("身份证输入不合法");
                return
            }
        }

        var address = $('#address').val();
        var sex = $("#Sex").val();


        var data = {
            "Name": name,
            "IDCardno": iDCardno,
            "Sex": sex,
            "address": address,
            "Mobile": mobile,
            "inHosNo": inHosNo,
            "synUserName": "",
            "PatientNo":PatientNo,
            "synKey": "",
            "CardNo": cardNo,
            "id": window.localStorage.getItem("openId")
        }
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/addPatients",
                dataParam: JSON.stringify(data)
            },
            async: false,
            success: function (result) {
                var msg = "";
                if (result != null) {
                    if (result.resultCode === '00') {
                        $.toast("绑定成功!");
                        self.location = document.referrer;
                        window.location.href = '../user/memberList'
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
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }


    $(document).ready(function () {
        var cardNo = getQueryString("CardNo");
        if (cardNo != null && cardNo != '') {
            getUserInfo(cardNo);
            $('#btn_add').hide();
        }else {
            $('#btn_update').hide();
        }
    });


    function getUserInfo(cardNo) {
        var json = {
            "visitCardNo": cardNo,
            "synUserName": "",
            "synKey": "",
            "socialsecurityNO":'',
            "bankCardNumber":''
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querypatientinfobysocialsecurityno",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                console.log(result);
                if(result.resultCode =='00' ){
                    $('#Name').val(result.patientName).attr("disabled",true);
                    $('#CardNo').val(result.patientNo).attr("disabled",true);
                    $('#Mobile').val(result.patientTelephone).attr("disabled",true);
                    $('#Sex').val(result.patientSex).attr("disabled",true);
                }
            },
            error: function (e) {
                $.toast("绑定失败，请稍后再试");
            }
        });
    }
</script>
</body>

</html>