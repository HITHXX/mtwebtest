<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Leaderboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap-select.min.css">
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-select.min.js"></script>

    <script>


        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '${pageContext.request.contextPath}/user/logout'
            }
        }

        function init() {
            var username = "${username}";
            if (username != "null" && username != "") {
                var userDrop = document.getElementById("userDrop");
                userDrop.classList.remove("dropdown");
                document.getElementById("userHome").classList.remove("hidden");
                document.getElementById("addSys").classList.remove("hidden");
                document.getElementById("submit").classList.remove("hidden");
                document.getElementById("history").classList.remove("hidden");
                document.getElementById("downTest").classList.remove("hidden");
                document.getElementById("upload").classList.remove("hidden");


                userDrop.innerHTML = '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + username + '<strong class="caret"></strong></a>\n' +
                    '                            <ul class="dropdown-menu">\n' +
                    '                                <li>\n' +
                    '                                    <a href="${pageContext.request.contextPath}/user/edit/' + username + '">个人资料</a>\n' +
                    '                                </li>\n' +'<li> <a href="${pageContext.request.contextPath}/user/changePWD">修改密码</a> </li>'+
                    '                                <li>\n' +
                    '                                    <a href="javascript:void(0)" onclick="logout()">登出</a>\n' +
                    '                                </li>\n' +
                    '                            </ul>';
            }
        }

        function getLeaderBoard() {
            var track = document.getElementById("track").value;
            var metric = document.getElementById("metric").value;
            var data;
            $.ajax(
                {
                    type: 'get',
                    url: '${pageContext.request.contextPath}/leaderboard/' + track + "/" + metric,
                    success: function (result) {
                        for (var i = 0; i < result.length; i++) {
                            //console.log(result[i]);
                            data += '<tr>' +
                                '<td>' + (i + 1) + '</td>' +
                                '<td><a href="${pageContext.request.contextPath}/system/detail/'+result[i].systemid+'">'+ result[i].systemName + '</td>' +
                                '<td>' + result[i].affiliation + '</td>' +
                                '<td>' + result[i].testset + '</td>' +
                                /*'<td>' + result[i].srclang + '</td>' +
                                '<td>' + result[i].tgtlang + '</td>' +*/
                                '<td>' + result[i].bleu_SBP + '</td>' +
                                '<td>' + result[i].bleu_NIST + '</td>' +
                                '<td>' + result[i].ter + '</td>' +
                                '<td>' + result[i].meteor + '</td>' +
                                '<td>' + result[i].nist + '</td>' +
                                '<td>' + result[i].gtm + '</td>' +
                                '<td>' + result[i].mwer + '</td>' +
                                '<td>' + result[i].mper + '</td>' +
                                '<td>' + result[i].ict + '</td>' +
                                '<td>' + result[i].isConstraint + '</td>' +
                                '<td>' + result[i].submitter + '</td>' +
                                '<td>' + result[i].time + '</td>' +
                                '</tr>'
                        }
                        //清空上次数据
                        $("#leaderBoard tbody tr:not(:first)").html("");
                        //将查询出来的数据插入
                        $("#leaderBoard #firstTr").after(data);
                    }
                }
            )
        }

        $(document).ready(function () {
            init();
            getLeaderBoard()
        });


    </script>
</head>

<body>
<div class="container-fluid">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default navbar-inverse" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1"><span
                            class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">通用机器翻译测评平台</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="${pageContext.request.contextPath}/">主页</a>
                        </li>
                        <li class="active">
                            <a href="#">排行榜</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/about">使用说明</a>
                        </li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="hidden" id="userHome">
                            <a href="${pageContext.request.contextPath}/user/status">个人主页</a>
                        </li>

                        <li class="hidden" id="addSys">
                            <a href="${pageContext.request.contextPath}/system/new">添加系统</a>
                        </li>

                        <li class="hidden" id="submit">
                            <a href="${pageContext.request.contextPath}/submit/frame">提交测试</a>
                        </li>

                        <li class="hidden" id="history">
                            <a href="${pageContext.request.contextPath}/submit/history">历史提交</a>
                        </li>

                        <li class="hidden" id="downTest">
                            <a href="${pageContext.request.contextPath}/test_sets/list">数据下载</a>
                        </li>

                        <li class="hidden" id="upload">
                            <a href="${pageContext.request.contextPath}/upload">CCMT2019提交入口</a>
                        </li>

                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">账户<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/register">注册</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-4">
            <h4>排行榜</h4>
        </div>
        <%--<div class="col-md-4">--%>

        <%--</div>--%>

        <div class="col-md-4">
            <label for="track">选择任务:</label>
            <select class="selectpicker" id="track" onchange="getLeaderBoard()">
                <option value="CE">CE</option>
                <option value="EC">EC</option>
                <option value="MC">MC</option>
                <option value="TC">TC</option>
                <option value="UC">UC</option>
                <%--<option value="JE">JE</option>--%>

            </select>
        </div>

        <div class="col-md-4">
            <label for="metric">排序指标：</label>
            <select class="selectpicker" id="metric" onchange="getLeaderBoard()">
                <option value="BLEU_SBP">BLEU_SBP</option>
                <option value="BLEU_NIST">BLEU_NIST</option>
                <%--<option value="TER">TER</option>--%>
                <option value="METEOR">METEOR</option>
                <option value="NIST">NIST</option>
                <option value="GTM">GTM</option>
                <%--<option value="mWER">mWER</option>
                <option value="mPER">mPER</option>--%>
                <option value="ICT">ICT</option>
            </select>
        </div>

    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped" id="leaderBoard">
                <thead>
                <tr>
                    <th>Rank</th>
                    <th>System</th>
                    <th>Affiliation</th>
                    <th>Test Set</th>
                    <%--<th>Source language</th>
                    <th>Target language</th>--%>
                    <th>BLEU_SBP</th>
                    <th>BLEU_NIST</th>
                    <th>TER</th>
                    <th>METEOR</th>
                    <th>NIST</th>
                    <th>GTM</th>
                    <th>mWER</th>
                    <th>mPER</th>
                    <th>ICT</th>
                    <th>IsConstraint</th>
                    <th>Submitter</th>
                    <th>Submit Time</th>
                </tr>
                </thead>
                <tbody>
                <tr id="firstTr"></tr>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
