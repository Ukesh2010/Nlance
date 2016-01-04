package com.assignment.elance.modelManager;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.models.Bid;
import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.hibernate.Session;

public class BidManager {

    //Job Bids
    public List fetchByEmployer(int job_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidList = session.createQuery("from Bid bid where bid.job.job_id=" + job_id).list();
        session.getTransaction().commit();
        return bidList;
    }

    //
//    public List fetchByBidder(int bidder_id, int job_id) {
//        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
//        session.beginTransaction();
//
//        List bidList = session.createQuery("from Bid bid where bid.bidder.bidder_id =" + bidder_id + "and bid.job.job_id=" + job_id).list();
//        session.getTransaction().commit();
//        return bidList;
//
//    }
    public int insert(int bidder_id, int job_id, float bidded_price, long toc) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Bidder bidder = (Bidder) session.load(Bidder.class, new Integer(bidder_id));

        Job job = (Job) session.load(Job.class, new Integer(job_id));

        Bid bid = new Bid();
        bid.setBidder(bidder);
        bid.setJob(job);
        bid.setBidded_price(bidded_price);
        bid.setTime_of_completion(toc);
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

    public void fromBiddedToAccepted(String status, int bid_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Bid bid = (Bid) session.load(Bid.class, new Integer(bid_id));
        bid.setStatus(status);
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

    public List getBidByBidder(int bidderId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List bidList = session.createQuery("from Bid bid where bid.bidder.bidder_id=" + bidderId).list();
        session.getTransaction().commit();
        return bidList;

    }

    public Map fromAcceptedToApproved(int bid_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Bid bid = (Bid) session.get(Bid.class, new Integer(bid_id));
        bid.setStatus(SystemAttributes.BidderStatuses.APPROVED);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("job_id", bid.getJob().getJob_id());
        map.put("bidder_id", bid.getBidder().getBidder_id());
        map.put("time", bid.getTime_of_completion());
        map.put("price", bid.getBidded_price());
        session.update(bid);
        session.getTransaction().commit();
        return map;
    }

}
