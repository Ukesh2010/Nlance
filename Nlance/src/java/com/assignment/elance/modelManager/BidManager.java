package com.assignment.elance.modelManager;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.models.Bid;
import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import java.util.List;
import org.hibernate.Session;

public class BidManager {

    public List fetchByEmployer(int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidList = session.createQuery("from Bid bid where bid.job.job_id=" + job_id).list();
        session.getTransaction().commit();
        return bidList;
    }

    public List fetchByBidder(int bidder_id, int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidList = session.createQuery("from Bid bid where bid.bidder.bidder_id =" + bidder_id + "and bid.job.job_id=" + job_id).list();
        session.getTransaction().commit();
        return bidList;

    }

    public int insert(int bidder_id, int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Bidder bidder = new Bidder();
        bidder.setBidder_id(bidder_id);

        Job job = new Job();
        job.setJob_id(job_id);

        Bid bid = new Bid();
        bid.setBidder(bidder);
        bid.setJob(job);
        bid.setStatus(SystemAttributes.BidderStatuses.BIDED);

        session.save(bid);
        session.getTransaction().commit();
        return bid.getBid_id();
    }

    public List getBidByStatus(String status, int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidList = session.createQuery("from Bid bid where bid.status ='" + status + "' and bid.job.job_id=" + job_id).list();
        session.getTransaction().commit();

        return bidList;
    }

    public Bid getBidById(int bid_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidList = session.createQuery("from Bid bid where bid.bid_id =" + bid_id).list();
        session.getTransaction().commit();

        return bidList.size() > 0 ? (Bid) bidList.get(0) : null;

    }

    public void changeStatus(String status, int bid_id) {
        Bid bid = getBidById(bid_id);
        bid.setStatus(status);

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        session.update(bid);
        session.getTransaction().commit();

    }

    public List getBidByStatusAndBidder(String status, int bidderId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidList = session.createQuery("from Bid bid where bid.status ='" + status + "' and bid.bidder.bidder_id=" + bidderId).list();
        session.getTransaction().commit();

        return bidList;
    }

}
