<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="com.assignment.elance.modelManager.SkillManager"%>
<%@page import="com.assignment.elance.models.Category"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.CategoryManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Job job = new JobManager().getJobById(Integer.parseInt(request.getParameter("jobId")));
    Set<Skill> selectedSkills = job.getSkills();
%>
<%!
    public boolean checkIfSelected(Set<Skill> selectedSkills, Skill skill) {
        Iterator temp = selectedSkills.iterator();
        while (temp.hasNext()) {
            Skill selectedskill = (Skill) temp.next();
            if (selectedskill.getSkill_id() == skill.getSkill_id()) {
                return true;
            }
        }
        return false;
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
                <form role="form" method="post" action="<%= request.getContextPath()%>/JobController?type=0">            
                    <label for="category">What type of work do you require?</label>
                    <select class="form-control" name="category" id="category">
                        <% CategoryManager cm = new CategoryManager();
                            Iterator iterator = cm.fetch().iterator();
                            while (iterator.hasNext()) {
                                Category category = (Category) iterator.next();
                        %>
                        <option <%= job.getCategory().getCategory_id() == category.getCategory_id() ? "selected='selected'" : ""%> value="<%= category.getCategory_id()%>"><%= category.getCategory_name()%></option>
                        <%
                            }
                        %>
                    </select>
                    <br>

                    <label for="about">What is your project about?</label>
                    <input class="form-control" id="about" type="text" name="job_title" value="<%= job.getJob_title()%>"/>
                    <br>

                    <label> Tell us more about your project</label>
                    <label for="skills"> What skills are required.</label>
                    <ul class="list-group">
                        <%
                            SkillManager sm = new SkillManager();
                            Iterator iterator_skill = sm.fetch().iterator();
                            while (iterator_skill.hasNext()) {
                                Skill skill = (Skill) iterator_skill.next();
                        %>
                        <li class="list-group-item"><input <%=checkIfSelected(selectedSkills, skill) ? "checked='checked'" : ""%> type="checkbox" name="<%= skill.getSkill_id()%>" /><%= skill.getSkill_name()%></li> 

                        <%
                            }
                        %>
                    </ul>

                    <br>
                    <br>
                    <label for="description"> Describe your project.</label>                  
                    <textarea class="form-control" id="description" name="job_description" ><%= job.getJob_description()%></textarea>
                    <br>

                    <label for="budget">What budget do you have in mind?</label>                    
                    <input id="budget" class="form-control" type="number" name="job_cost" value="<%=job.getJob_cost()%>"/>
                    <br> 
                    <button type="submit" class="btn btn-default">Repost Project</button>
                </form>


            </div>
        </div>

    </body>



</html>

