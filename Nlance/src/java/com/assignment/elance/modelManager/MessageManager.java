/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import com.assignment.elance.models.Message;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class MessageManager {

    public void insert(int job_id, String msg, boolean sent_dir) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Message message = new Message();
        message.setJob((Job) session.load(Job.class, new Integer(job_id)));
        message.setMessage(msg);
        message.setSend_dir(sent_dir);

        session.save(message);
        session.getTransaction().commit();
    }

    public List fetchByJobId(int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List messages = session.createQuery("from Message m where m.job.job_id=" + job_id).list();
        session.getTransaction().commit();
        return messages;
    }
}
