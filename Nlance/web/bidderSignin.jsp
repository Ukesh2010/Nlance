<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.SkillManager"%>
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

        <title>Freelancer - Start Bootstrap Theme</title>
        <script src="js/jquery.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery.noty.packaged.min.js"></script>

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/jquery-ui.css" rel="stylesheet">
        <script>
            $(function () {
                change(true);
            });
            function change(value) {
                if (value) {
                    $('#signinBtn').css("color", "grey");
                    $('#signupBtn').css("color", "white");
                    $('#signin').show();
                    $('#signup').hide();
                } else {
                    $('#signinBtn').css("color", "white");
                    $('#signupBtn').css("color", "grey");
                    $('#signin').hide();
                    $('#signup').show();
                }
            }


        </script>
    </head>

    <body id="page-top" class="index" >

        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a class="btn  btn-link" id="signupBtn" onclick="change(false)"><span class="glyphicon glyphicon-link"></span> Sign Up</a></li>
                        <li><a class="btn  btn-link" id="signinBtn" onclick="change(true)"><span class="glyphicon glyphicon-log-in"></span> Sign In</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="row" id="signin">
            <div class="col-sm-4 col-sm-offset-4">
                <form role="form" method="post" action="<%= request.getContextPath()%>/LoginController?type=<%= 0%>">
                    <div>
                        <div class="form-group">
                            <label for="login_email">Email address:</label>
                            <input type="email" class="form-control" id="login_email" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="login_pwd">Password:</label>
                            <input type="password" class="form-control" id="login_pwd" name="password" required>
                        </div>


                        <button type="submit" onclick="login(event)" class="btn btn-default btn-block"> Signin</button>
                    </div>
                </form>        
            </div>
        </div>
        <div class="row" id="signup">
            <div class="col-sm-4 col-sm-offset-4">
                <form onsubmit="return checked();" role="form" method="post" action="<%= request.getContextPath()%>/RegisterController?type=<%= 0%>">
                    <div class="form-group">
                        <label for="email">Email address:</label>
                        <input type="email"  class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="un">Username:</label>
                        <input type="text" class="form-control" id="un" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="pwd">Password:</label>
                        <input type="password" class="form-control" id="pwd" name="password" required>
                    </div>


                    <button id="registerBtn"  type="submit" class="btn btn-default btn-block"> Register</button>

                </form>        


            </div>
        </div>

        <script>
            var emailcheck = false;

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

            var login = function (event) {
                event.preventDefault();
                var email = $('#login_email').val();
                var pwd = $('#login_pwd').val();
                $.post('<%= request.getContextPath()%>/LoginController', {
                    'username': email,
                    'password': pwd,
                    'type': 0
                }, function (data) {
                    if (data.success == true) {
                        location.reload();
                    } else {
                        showNotification("Username or password incorrect!");

                    }

                });
            };

            $('#email').on('change', function () {
                var email = $('#email').val();
                $.post('<%= request.getContextPath()%>/RegisterController', {
                    'email': email,
                    'type': 2
                }, function (data) {
                    if (data == "true") {
                        emailcheck = true;
                    } else {
                        emailcheck = false;
                        showNotification("Email address already used!");
                    }

                });
            });
            var checked = function () {
                if (emailcheck) {
                    return true;
                } else {
                    showNotification("Email address already used!");
                    return false;
                }

            }

        </script>


    </body>

</html>
