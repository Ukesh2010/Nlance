package com.assignment.elance.modelManager;

import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Bidder;
import java.util.List;
import org.hibernate.Session;

public class BidderManager {

    public boolean preRegisterCheck(String email) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List bidderEmailCheck = session.createQuery("from Bidder b where b.email='" + email + "'").list();
        session.getTransaction().commit();
        return bidderEmailCheck.size() <= 0;
    }

    public void register(String username, String password, String email) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Bidder bidder = new Bidder();
        bidder.setUsername(username);
        bidder.setEmail(email);
        bidder.setPassword(password);

        session.save(bidder);
        session.getTransaction().commit();
    }

    public Bidder login(String username, String password) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List result = session.createQuery("from Bidder bidder where bidder.email='" + username + "' AND bidder.password='" + password + "'").list();
        session.getTransaction().commit();
        if (result.size() > 0) {
            return (Bidder) result.get(0);

        } else {
            return null;
        }

    }

    public Bidder getBidderById(int id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List result = session.createQuery("from Bidder b where b.bidder_id=" + id).list();
        session.getTransaction().commit();
        return (Bidder) result.get(0);
    }

}
