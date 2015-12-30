package com.assignment.elance.controller;

import com.assignment.elance.modelManager.MessageManager;
import com.assignment.elance.models.Message;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MessageController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (Integer.parseInt(request.getParameter("type"))) {
            case 0:
                new MessageManager().insert(Integer.parseInt(request.getParameter("job_id")), request.getParameter("message"), Boolean.parseBoolean(request.getParameter("send_dir")));
//                response.setContentType("application/json");
//                response.setCharacterEncoding("UTF-8");
//                response.getWriter().write(json);
                break;
            case 1:
                ArrayList<Map<String, Object>> messages = new ArrayList<Map<String, Object>>();
                Iterator temp = new MessageManager().fetchByJobId(Integer.parseInt(request.getParameter("jobId"))).iterator();
                while (temp.hasNext()) {
                    Message message = (Message) temp.next();
                    Map<String, Object> messageMap = new HashMap<String, Object>();
                    messageMap.put("message", message.getMessage());
                    messageMap.put("dir", message.isSend_dir());
                    messages.add(messageMap);
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(new Gson().toJson(messages));
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
