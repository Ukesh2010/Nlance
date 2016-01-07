<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
<jsp:useBean id="employer" class="com.assignment.elance.models.Employer" scope="session"/>
<%
    if ((bidder.getBidder_id() > 0)) {
        response.sendRedirect("bidderHome.jsp");
    } else if ((employer.getEmployer_id() > 0)) {
        response.sendRedirect("employerHome.jsp");
    }%>
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
        <script src="js/jquery.noty.packaged.min.js"></script>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/jquery-ui.css" rel="stylesheet">
    </head>

    <body id="page-top" class="index">

        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="employerSignup.jsp"><span class="glyphicon glyphicon-log-in"></span> Signup</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="row">
            <div class="col-sm-4 col-sm-offset-4">
                <form role="form" onsubmit="return login()" method="post" action="<%= request.getContextPath()%>/LoginController?type=<%= 1%>">
                    <div class="form-group">
                        <label for="login_email">Email address:</label>
                        <input type="email" class="form-control" id="login_email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="login_pwd">Password:</label>
                        <input type="password" class="form-control" id="login_pwd" name="password" required>
                    </div>
                    <button  type="submit" class="btn btn-default btn-block"> Signin</button>

                </form>        


            </div>
        </div>
        <script>
            function showNotification(message) {
                noty({text: message,
                    type: 'alert',
                    timeout: true,
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing',
                        speed: 500
                    }});
            }
            var login = function () {
                var email = $('#login_email').val();
                var pwd = $('#login_pwd').val();
                $.post('<%= request.getContextPath()%>/LoginController', {
                    'email': email,
                    'password': pwd,
                    'type': 1
                }, function (data) {
                    if (data.success == true) {
                        location.reload();
                    } else {
                        showNotification('Username or Password incorrect');
                    }

                });
                return false;
            };
        </script>
    </body>

</html>
