/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.modelManager.JobManager;
import com.assignment.elance.modelManager.SkillManager;
import com.assignment.elance.models.Category;
import com.assignment.elance.models.Employer;
import com.assignment.elance.models.Job;
import com.assignment.elance.models.Skill;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
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
        HttpSession session = request.getSession();

        Category category = new Category();
        category.setCategory_id(Integer.parseInt(request.getParameter("category")));

//        Skill skill = new SkillManager().fetchById(Integer.parseInt(request.getParameter("skill")));
        Skill skill = new Skill();
        skill.setSkill_id(Integer.parseInt(request.getParameter("skill")));
//        skill.setSkill_name("Washing");

        Job job = new Job();

        job.setJob_title(request.getParameter("job_title"));
        job.setJob_description(request.getParameter("job_description"));
        job.setJob_cost(Float.parseFloat(request.getParameter("job_cost")));
        job.setCategory(category);
        job.setTime_period(1212);
        job.setJob_posted_date(new Date());
        job.setJob_status("Open");

        job.setEmployer((Employer) session.getAttribute("employer"));

        Set<Skill> skills = new HashSet<Skill>();
        skills.add(skill);
        job.setSkills(skills);

        Set<Job> jobs = new HashSet<Job>();
        jobs.add(job);

        skill.setJobs(jobs);

        JobManager jm = new JobManager();
        int job_id = jm.insert(job);

        response.sendRedirect("projectOverview.jsp?pId=" + job_id);

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
