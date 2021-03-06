/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.modelManager.CategoryManager;
import com.assignment.elance.modelManager.JobManager;
import com.assignment.elance.modelManager.SkillManager;
import com.assignment.elance.models.Employer;
import com.assignment.elance.models.Job;
import com.assignment.elance.models.Skill;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author EyeWeb005
 */
public class JobController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (Integer.parseInt(request.getParameter("type"))) {
            case 0:
                HttpSession session = request.getSession();
                ArrayList<Integer> skills = new ArrayList<Integer>();
                SkillManager sm = new SkillManager();
                Iterator temp = sm.fetch().iterator();
                while (temp.hasNext()) {
                    Skill skill = (Skill) temp.next();
                    if (request.getParameter(skill.getSkill_id() + "") != null && request.getParameter(skill.getSkill_id() + "").equals("on")) {
                        skills.add(skill.getSkill_id());
                    }

                }
                JobManager jm = new JobManager();
                int job_id = jm.insert(Integer.parseInt(request.getParameter("category")), skills, request.getParameter("job_title"), request.getParameter("job_description"), Float.parseFloat(request.getParameter("job_cost")), (Employer) session.getAttribute("employer"));

                response.sendRedirect("projectOverview.jsp?pId=" + job_id);
                break;
            case 1:
                JobManager jobManager = new JobManager();
                Job j = jobManager.getJobById(Integer.parseInt(request.getParameter("jobId")));
                List<String> skillslist = new ArrayList<String>();

                Iterator i = j.getSkills().iterator();
                while (i.hasNext()) {
                    SkillManager sk = new SkillManager();
                    skillslist.add(sk.fetchById(((Skill) i.next()).getSkill_id()).getSkill_name());
                }

                Map<String, Object> jobMap = new HashMap<String, Object>();
                jobMap.put("job_title", j.getJob_title());
                jobMap.put("job_description", j.getJob_description());
                jobMap.put("job_posted_date", j.getJob_posted_date());
                jobMap.put("job_employer_id", j.getEmployer().getEmployer_id());
                jobMap.put("skills", skillslist);
                jobMap.put("category", new CategoryManager().fetchById(j.getCategory().getCategory_id()).getCategory_name());
                jobMap.put("no_of_bids", j.getBids().size());

                String json = new Gson().toJson(jobMap);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case 2:
                JobManager jobMan = new JobManager();
                jobMan.changeStatus(Integer.parseInt(request.getParameter("jobId")), SystemAttributes.JobStatuses.CLOSED);
                break;
            case 3:
                JobManager jobMana = new JobManager();
                jobMana.changeStatus(Integer.parseInt(request.getParameter("jobId")), SystemAttributes.JobStatuses.S_CLOSED);
                response.sendRedirect("projectOverview.jsp?pId=" + request.getParameter("jobId"));
                break;
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
