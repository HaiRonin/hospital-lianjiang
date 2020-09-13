<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>医生列表</title>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/picker.js"></script>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<div class="c-main">
    <div class="h45">
        <ul class="doc-filter">
            <li id="filter-dept"><a href="javascript:;" class="c-nowrap"><label id="detpName"></label><i
                    class="sicon icon-gjt"></i></a></li>
            <li>
                <a href="javascript:;" class="c-nowrap"><label id="filterrank">医生职称</label><i
                        class="sicon icon-gjt"></i></a>

            </li>
        </ul>
    </div>
    <div class="mt10" id="doctors">
        <ul class="c-list c-border-tb">
        </ul>

    </div>
    <div class="dept-box" style="display:none">
        <div class="dept">
            <ul id="querydepartmentlist">

            </ul>
        </div>
    </div>
</div>
<script>
    var id = "";
    var names = "主治医师";
    var type = "";
    var nameInfo="";
    $(document).ready(function () {
        id = getQueryString("valus");
        type = getQueryString("type");
        nameInfo = getQueryString("name");
        $(function () {
            querydepartmentlist();
            querydoctorlist(id);
        });
    });

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    //获取所有科室
    function querydepartmentlist() {
        var json = {
            "synUserName": "",
            "synKey": ""
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querydepartmentlist",
                dataParam: JSON.stringify(json)
            },
            async: false,
            success: function (result) {
                console.log(result);
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.department !== null) {
                            $.each(result.department, function (i, item) {
                                if(item.name!=="儿科一区门诊") {
                                    if (item.name !== "放射科") {
                                        var detpName = item.name;
                                        var organId = item.organId;
                                        if (id == organId) {
                                            $("#detpName").text(detpName)
                                        }
                                        $('#querydepartmentlist').append("<li><a onclick=\"querydoctorlist1(" + item.organId + ",'" + item.name + "')\">" + item.name + "</a></li>")
                                    }
                                }

                            });
                        }
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }

    function querydoctorlist1(id,name) {
        $("#detpName").text(name)
        $(".dept-box").toggle();
        $("#filterrank").text("医生职称");
        querydoctorlist(id);
    }

    function querydoctorlist(id) {
        var json = {
            "synUserName": "",
            "synKey": "",
            "departmentorganId": id
        };
        $('ul.c-border-tb').empty();
        names = '';
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/queryDoctorlistSource",
                dataParam: JSON.stringify(json)
            },
            async: false,
            success: function (result) {
                if (result != null) {
                    if (result.resultCode === "00") {
                        console.log(result);
                        if (result.Doctor !== null) {
                            $.each(result.Doctor, function (i, item) {
                                var photoUrl = item.photoUrl;
                                if(photoUrl==''){
                                    photoUrl='../images/d-male.png';
                                }
                                console.log(photoUrl);
                                if(names == ''){
                                    names = item.job;
                                }else{
                                    if(!(names.indexOf(item.job) != -1)){
                                        names = names + "," + item.job;
                                    }
                                }
                                    if(type=="0"){
                                        if(item.isReg=="1"){
                                        $('ul.c-border-tb').append("<li class=\"islink\">\n" +
                                                "                <div class=\"c-list-img\"><img src='" + photoUrl + "' alt=\"\"></div>\n" +
                                                "                <div class=\"c-list-mess\">\n" +
                                                "                    <h4><span class=\"c-f15 c-333 mr5\">" + item.name + "</span></h4>\n" +
                                                "                    <p class=\"c-nowrap mt5\">" + item.job + "</p>\n" +
                                                "                </div>\n" +
                                                "                <a href=\"../registration/doctorInfo?valus="+item.organdoctorId+"&depId="+id+"&type="+ type +"\" class=\"btn-docfr\"> 挂号</a>\n" +
                                                "            </li>");
                                        }
                                    }else {
                                        if(item.sevenDaySource=="1") {
                                            $('ul.c-border-tb').append("<li class=\"islink\">\n" +
                                                    "                <div class=\"c-list-img\"><img src='" + photoUrl + "' alt=\"\"></div>\n" +
                                                    "                <div class=\"c-list-mess\">\n" +
                                                    "                    <h4><span class=\"c-f15 c-333 mr5\">" + item.name + "</span></h4>\n" +
                                                    "                    <p class=\"c-nowrap mt5\">" + item.job + "</p>\n" +
                                                    "                </div>\n" +
                                                    "                <a href=\"../registration/subscribe?valus=" + item.organdoctorId + "&depId=" + id + "&type=" + type + "&name=" + item.name + "&job=" + item.job + "&photoUrl=" + item.photoUrl + "\" class=\"btn-docfr\"> 挂号</a>\n" +
                                                    "            </li>");
                                        }
                                    }
                            });

                            refresh();
                        }
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }


    $("#detpName").click(function () {
        $(".dept-box").toggle();
    });
    var data1 = [
        {
            text: '医生职称',
            value: 'ALL'
        }
    ];

    var filterrank = new Picker({
        data: [data1]
    });

    function refresh(){
        data1 = [];
        data1.push({text: '医生职称',value: '医生职称'});
        if(names != ''){
            var nameList = names.split(",");
            for(var i=0;i<nameList.length;i++){
                data1.push({text: nameList[i],value: nameList[i]});
            }
        }

        filterrank = new Picker({
            data: [data1]
        });

        filterrank = new Picker({
            data: [data1]
        });

        var filterrankEl = document.getElementById('filterrank');


        filterrank.on('picker.select', function (selectedVal, selectedIndex) {
            filterrankEl.innerText = data1[selectedIndex[0]].text;
        });

        filterrank.on('picker.change', function (index, selectedIndex) {
            console.log(index);
        });

        filterrank.on('picker.valuechange', function (selectedVal, selectedIndex) {
            var name = selectedVal[0];
            if(name != '医生职称'){
                $("#doctors").find("li").each(function(){
                    if($(this).find("p").eq(0).text() != name){
                        $(this).hide();
                    }else{
                        $(this).css("display","");
                    }
                });
            }else{
                $("#doctors").find("li").css("display","");
            }
        });


        filterrankEl.addEventListener('click', function () {
            filterrank.show();
        });
    }


</script>
</body>
</html>
