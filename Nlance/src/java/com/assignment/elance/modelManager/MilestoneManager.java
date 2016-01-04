/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import com.assignment.elance.models.Milestone;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class MilestoneManager {

    public void insert(int job_id, float amount, String description, boolean send_dir) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Milestone milestone = new Milestone();
        milestone.setJob((Job) session.load(Job.class, new Integer(job_id)));
        milestone.setMilestone_amount(amount);
        milestone.setMilestone_description(description);
        milestone.setMilestone_status(SystemAttributes.MileStoneStatuses.REQUEST);
        milestone.setSend_dir(send_dir);

        session.save(milestone);
        session.getTransaction().commit();
    }

    public List fetchMilestones(int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List list = session.createQuery("from Milestone ms where ms.job.job_id=" + job_id).list();
        session.getTransaction().commit();
        return list;
    }

    public void changeStatus(int milestone_id, int status) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Milestone milestone = (Milestone) session.load(Milestone.class, new Integer(milestone_id));
        milestone.setMilestone_status(status);
        session.update(milestone);
        session.getTransaction().commit();
    }
}
