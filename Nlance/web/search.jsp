<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
<%
    if (bidder == null || bidder.getBidder_id() <= 0) {
        response.sendRedirect("bidderSignin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Nlance</title>
        <script src="js/jquery.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.js"></script>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/jquery-ui.css" rel="stylesheet">
        <script>
            $(function () {
//                searchByTitle("");
            });
            function searchByTitle(key) {
                $.post("<%= request.getContextPath()%>/SearchController", {
                    "type": 0,
                    "title": "" + key
                }, function (data) {
                    $('#result').html("");
                    for (item in data) {
                        var row = "<tr><td>" + data[item].title + "</td><td>" + data[item].description + " </td><td> " + data[item].title + " </td><td> " + data[item].title + " </td><td> " + data[item].title + " </td><td > " + data[item].title + " </td></tr>"
                        $('#result').append(row);
                    }
                });
            }
            function search(item) {
                var key = $(item).val();
                searchByTitle(key);
            }
        </script>
    </head>

    <body id="page-top" class="index">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="bidderSignup.jsp"><span></span> <%= bidder.getEmail()%></a></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=0"><span></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="row">
            <div class=" col-sm-3">
                <div class="row">
                    <div class="col-sm-offset-2 col-sm-8">
                        <div class="form-group">
                            <input onkeydown="if (event.keyCode == 13)
                                        search(this)" type="text" class="form-control" id="title" placeholder="Job" onsubmit="alert('heh')">
                        </div>

                        <div>
                            <select name="">

                            </select>
                        </div>
                    </div>


                </div>

            </div>
            <div class="col-sm-8">
                <table class="table">
                    <thead>
                    <th>Job Title</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Posted Date</th>
                    <th>Category</th>
                    <th>Posted By</th>
                    </thead>
                    <tbody id="result">

                    </tbody>

                </table>

            </div>
        </div>

    </body>
</html>







