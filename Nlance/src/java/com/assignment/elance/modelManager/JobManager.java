/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.Employer;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class JobManager {

    //add job
    public int insert(int category_id, ArrayList<Integer> skill, String title, String description, float cost, Employer emp) {
        int lastId;
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query = session.createSQLQuery("INSERT INTO `job`(`job_title`, `job_description`, `job_cost`, `time_period`, `job_posted_date`, `job_status`, `employer_id`,  `category_id`) VALUES (:job_title, :job_description, :job_cost, :time_period, :job_posted_date, :job_status, :employer_id, :category_id)")
                .setParameter("job_title", title)
                .setParameter("job_description", description)
                .setParameter("job_cost", cost)
                .setParameter("time_period", new Long(00))
                .setParameter("job_posted_date", new Date())
                .setParameter("job_status", SystemAttributes.JobStatuses.OPEN)
                .setParameter("employer_id", emp.getEmployer_id())
                //                .setParameter("bidder_id", null)
                .setParameter("category_id", category_id);
        query.executeUpdate();
        lastId = ((BigInteger) session.createSQLQuery("SELECT LAST_INSERT_ID()").uniqueResult()).intValue();

        session.getTransaction().commit();
        insertJobSkills(lastId, skill);
        return lastId;
    }

    private void insertJobSkills(int job_id, ArrayList<Integer> skill) {

        Session session2 = HibernateUtil.getSessionFactory().getCurrentSession();
        session2.beginTransaction();
        for (int skill_id : skill) {

            Query query2 = session2.createSQLQuery("INSERT INTO `job_skill`(`job_id`, `skill_id`,`bidder_id`) VALUES (:job_id,:skill_id,:bidder_id)").setParameter("job_id", job_id).setParameter("skill_id", skill_id).setParameter("bidder_id", 1);
            query2.executeUpdate();
        }
        session2.getTransaction().commit();
    }

    //Employer posted job list
    public List fetchJobsByEmployerId(int eId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List jobs = session.createQuery("from Job j where j.employer.employer_id=" + eId).list();
        session.getTransaction().commit();
        return jobs;
    }

    //Employer posted Open job list
    public List fetchJobsByEmployerIdAndOpen(int eId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List jobs = session.createQuery("from Job j where j.employer.employer_id=" + eId + "AND j.job_status='" + SystemAttributes.JobStatuses.OPEN + "'").list();
        session.getTransaction().commit();
        return jobs;
    }

    //Closed jobs
    public List fetchJobsByEmployerIdAndClosed(int eId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List jobs = session.createQuery("from Job j where j.employer.employer_id=" + eId + "AND j.job_status IN  ('" + SystemAttributes.JobStatuses.CLOSED + "','" + SystemAttributes.JobStatuses.S_CLOSED + "')").list();
        session.getTransaction().commit();
        return jobs;
    }

    //All the Jobs list
    public List fetchJobs() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List jobs = session.createQuery("from Job job where job.bidder.bidder_id =" + null).list();
        session.getTransaction().commit();
        return jobs;

    }

    //fetch Job of specific Id
    public Job getJobById(int id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Job job = (Job) session.get(Job.class, new Integer(id));
        session.getTransaction().commit();
        return job;
//        List jobs = session.createQuery("from Job j where j.job_id=" + id).list();
//        session.getTransaction().commit();
//        return jobs.size() > 0 ? (Job) jobs.get(0) : null;
    }

    public void addBidder(int bidderId, int jobId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Job job = (Job) session.load(Job.class, new Integer(jobId));

        Bidder bidder = (Bidder) session.load(Bidder.class, bidderId);
        job.setBidder(bidder);

        session.save(job);
        session.getTransaction().commit();
    }

    //change job status
    public void changeStatus(int jobId, String status) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Job job = (Job) session.load(Job.class, new Integer(jobId));
        job.setJob_status(status);

        session.update(job);
        session.getTransaction().commit();

    }

    public void setStartAndEndDate(int jobId, long hrs, float price) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Job job = (Job) session.load(Job.class, new Integer(jobId));
        Date currentDate = new Date();
        job.setStart_date(currentDate);
        long tempDate = currentDate.getTime() + hrs * 60 * 60 * 1000;
        job.setEnd_date(new Date(tempDate));
        job.setBidded_price(price);
        session.update(job);
        session.getTransaction().commit();
    }

    //Employer active jobs
    public List activeJobList(int emp_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List list = session.createQuery("from Job job where job.employer.employer_id=" + emp_id + " AND job.job_status='" + SystemAttributes.JobStatuses.INPROGRESS + "'").list();
        session.getTransaction().commit();
        return list;
    }

    //All the Jobs list
    public List SearchJobsByTitle(String key) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List jobs = session.createQuery("from Job where job_title like '%" + key + "%' AND job_status = '" + SystemAttributes.JobStatuses.OPEN + "'").list();
        session.getTransaction().commit();
        return jobs;

    }
}
