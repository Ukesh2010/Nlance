
import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.modelManager.BidManager;
import com.assignment.elance.modelManager.BidderManager;
import com.assignment.elance.modelManager.JobManager;
import com.assignment.elance.models.Job;
import java.util.Iterator;

/*
 * To change thhooBidols | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author EyeWeb005
 */
public class NewClass {

    public static void main(String[] args) {
//        EmployerManager em = new EmployerManager();
//        em.login("sd", "dsf");
//        BidderManager bd = new BidderManager();
//        bd.login("Ukesh", "Ukesh");

//        SkillManager sm = new SkillManager();
//       Iterator iterator= sm.fetch().iterator();
//       while(iterator.hasNext()){
//           System.out.println(((Skill)iterator.next()).getSkill_name());
//       }
//        CategoryManager cm = new CategoryManager();
//        cm.insert();
//        JobManager jm = new JobManager();
//        jm.insert();
//        JobManager bm = new JobManager();
//        Iterator bids = bm.fetchJobsByEmployerId(1).iterator();
//        while (bids.hasNext()) {
//            System.out.println(((Bid) bids.next()).getBid_id());
//        }
//        System.out.println(new SkillManager().fetchById(1).getSkill_name());
//        JobManager jm = new JobManager();
//        Iterator iterator = jm.fetchJobsByEmployerId(1).iterator();
//        while (iterator.hasNext()) {
//            Job job = (Job) iterator.next();
//
//            System.out.println(job.getJob_title());
//        }
//        BidManager bm = new BidManager();
//        bm.changeStatus(SystemAttributes.BidderStatuses.ACCEPTED, 1);
//        BidderManager bidderManager = new BidderManager();
//        bidderManager.preRegisterCheck("sdf");
      
        JobManager jm = new JobManager();
        jm.addBidder(1, 8);

    }

}
