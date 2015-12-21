<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="com.assignment.elance.modelManager.SkillManager"%>
<%@page import="com.assignment.elance.models.Category"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.CategoryManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Freelancer - Start Bootstrap Theme</title>

        <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/freelancer.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
        <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    </head>

    <body id="page-top" class="index">

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="bidderSignup.jsp"><span class="glyphicon glyphicon-log-in"></span> Signup</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="row">
            <div class="col-sm-8 col-sm-offset-2">
                <form role="form" method="post" action="<%= request.getContextPath()%>/JobController">            
                    <label for="category">What type of work do you require?</label>
                    <select class="form-control" name="category" id="category">
                        <% CategoryManager cm = new CategoryManager();
                            Iterator iterator = cm.fetch().iterator();
                            while (iterator.hasNext()) {
                                Category category = (Category) iterator.next();
                        %>
                        <option value="<%= category.getCategory_id()%>"><%= category.getCategory_name()%></option>
                        <%
                            }
                        %>
                    </select>
                    <br>
                    <label for="about">What is your project about?</label>
                    <input class="form-control" id="about" type="text" name="job_title"/>
                    <br>
                    <label> Tell us more about your project</label>
                    <label for="skills"> What skills are required.</label>
                    <select name="skill" id="skills" class="form-control">
                        <% SkillManager sm = new SkillManager();
                            Iterator iterator_skill = sm.fetch().iterator();
                            while (iterator_skill.hasNext()) {
                                Skill skill = (Skill) iterator_skill.next();
                        %>
                        <option value="<%= skill.getSkill_id()%>"><%= skill.getSkill_name()%></option>                        
                        <%
                            }
                        %>
                    </select>
                    <br>
                    <br>
                    <label for="description"> Describe your project.</label>                  
                    <input class="form-control" id="description" type="text" name="job_description"/>
                    <br>
                    <label for="budget">What budget do you have in mind?</label>                    
                    <input id="budget" class="form-control" type="text" name="job_cost"/>
                    <br> 
                    <button type="submit" class="btn btn-default">Create New Project</button>
                </form>


            </div>
        </div>




        <!-- jQuery -->
        <script src="js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Plugin JavaScript -->
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
        <script src="js/classie.js"></script>
        <script src="js/cbpAnimatedHeader.js"></script>

        <!-- Contact Form JavaScript -->
        <script src="js/jqBootstrapValidation.js"></script>
        <script src="js/contact_me.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="js/freelancer.js"></script>

    </body>

</html>

