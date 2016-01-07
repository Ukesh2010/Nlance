/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.helper.SystemMethods;
import com.assignment.elance.modelManager.JobManager;
import com.assignment.elance.models.Job;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author EyeWeb005
 */
public class SearchController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JobManager jm = new JobManager();
        ArrayList<Map<String, Object>> jobAl = new ArrayList<Map<String, Object>>();
        switch (Integer.parseInt(request.getParameter("type"))) {
            case 0:
                List jobs = jm.SearchJobsByTitle(request.getParameter("title"));

                Iterator temp = jobs.iterator();
                while (temp.hasNext()) {
                    Job job = (Job) temp.next();
                    int days_count = SystemMethods.subtractDate(job.getJob_posted_date(), new Date());
                    if (days_count < 7) {

                        Map<String, Object> jobMap = new HashMap<String, Object>();
                        jobMap.put("id", job.getJob_id());
                        jobMap.put("title", job.getJob_title());
                        jobMap.put("description", job.getJob_description());
                        jobMap.put("cost", job.getJob_cost());
                        jobMap.put("posted_date", job.getJob_posted_date());
                        jobMap.put("employer_name", job.getEmployer().getUsername());
                        jobMap.put("category", job.getCategory().getCategory_name());
                        jobAl.add(jobMap);
                    }
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(new Gson().toJson(jobAl));

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
