
import com.assignment.elance.modelManager.JobManager;
import com.assignment.elance.modelManager.MessageManager;
import com.assignment.elance.models.Job;

/*
 * To change thhooBidols | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author EyeWeb005
 */
public class NewClass {

    public static boolean checkPictureFileType(String fileName) {
        int dotIndex = fileName.indexOf(".");
        String fileActualName = fileName.substring(0, dotIndex);
        String fileType = fileName.substring(dotIndex + 1);
        return fileType.equalsIgnoreCase("JPG");
    }

    public static void main(String[] args) {
        MessageManager mm = new MessageManager();
        mm.insert(9, "hehe", true);
//        mm.fetchByJobId(1);

    }

}
