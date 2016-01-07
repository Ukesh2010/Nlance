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

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/jquery-ui.css" rel="stylesheet">
    </head>

    <body id="page-top" class="index">

        <!-- Navigation -->
        <nav class="navbar navbar-default">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header page-scroll">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#page-top">Nlance</a>
                </div>

            </div>
        </nav>

        <!-- Header -->
        <header>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <figure class="image-holder text-center">
                            <img src="img/profile.png" alt="">
                        </figure>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-sm-4 col-sm-offset-4">
                            <a href="employerSignup.jsp" class="btn btn-block btn-default">Hire</a>
                            <a href="bidderSignin.jsp" class="btn btn-block btn-default">Work</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>



    </body>

</html>

