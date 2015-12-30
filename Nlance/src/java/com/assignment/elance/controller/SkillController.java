/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.modelManager.SkillManager;
import com.assignment.elance.models.Skill;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author EyeWeb005
 */
public class SkillController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int type = Integer.parseInt(request.getParameter("type"));
        switch (type) {
            case 0:
                SkillManager sm = new SkillManager();
                Map<String, String> skillsMap = new HashMap<String, String>();
                Iterator skills = sm.fetch().iterator();
                while (skills.hasNext()) {
                    Skill skill = (Skill) skills.next();
                    skillsMap.put(skill.getSkill_id() + "", skill.getSkill_name());
                }
                String json = new Gson().toJson(skillsMap);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;

        }

//        String country = request.getParameter("countryname");
//        Map<String, String> ind = new LinkedHashMap<String, String>();
//        ind.put("1", "New delhi");
//        ind.put("2", "Tamil Nadu");
//        ind.put("3", "Kerala");
//        ind.put("4", "Andhra Pradesh");
//
//        Map<String, String> us = new LinkedHashMap<String, String>();
//        us.put("1", "Washington");
//        us.put("2", "California");
//        us.put("3", "Florida");
//        us.put("4", "New York");
//        String json = null;
//        if (country.equals("India")) {
//            json = new Gson().toJson(ind);
//        } else if (country.equals("US")) {
//            json = new Gson().toJson(us);
//        }
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write(json);
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
