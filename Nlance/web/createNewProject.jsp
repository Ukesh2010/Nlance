<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="com.assignment.elance.modelManager.SkillManager"%>
<%@page import="com.assignment.elance.models.Category"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.CategoryManager"%>
<jsp:useBean id="employer" class="com.assignment.elance.models.Employer" scope="session"/>
<%
    if (employer.getEmployer_id() <= 0) {
        response.sendRedirect("employerSignin.jsp");
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            var ids = [];
            function select(item) {
                var id = $(item).val()
                alert(id);
//                    ids.push(id);
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
                        <li><a href="#"><span class=""></span><%= employer.getUsername()%></a></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=1"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="row">
            <div class="col-sm-8 col-sm-offset-2">
                <form role="form" method="post" action="<%= request.getContextPath()%>/JobController?type=0">            
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
                    <input class="form-control" id="about" type="text" name="job_title" required/>
                    <br>

                    <label> Tell us more about your project</label>
                    <label for="skills"> What skills are required.</label>
                    <div style=" height: 100px; overflow-y: scroll;">
                        <ul class="list-group">

                            <% SkillManager sm = new SkillManager();
                                Iterator iterator_skill = sm.fetch().iterator();
                                while (iterator_skill.hasNext()) {
                                    Skill skill = (Skill) iterator_skill.next();
                            %>
                            <li class="list-group-item"><input type="checkbox" name="<%= skill.getSkill_id()%>" /><%= skill.getSkill_name()%></li> 

                            <%
                                }
                            %>
                        </ul>
                    </div>

                    <br>
                    <br>
                    <label for="description"> Describe your project.</label>                  
                    <textarea class="form-control" id="description" name="job_description" required></textarea>
                    <br>

                    <label for="budget">What budget do you have in mind?</label>                    
                    <input min="0" max="1000000" placeholder="In Rupees" id="budget" class="form-control" type="number" name="job_cost"/>
                    <br> 
                    <button type="submit" class="btn btn-default">Create New Project</button>
                </form>


            </div>
        </div>

    </body>



</html>

