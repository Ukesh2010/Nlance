/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.helper;

import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author EyeWeb005
 */
public class SystemMethods {

    public static boolean checkPictureFileType(String fileName) {
        int dotIndex = fileName.indexOf(".");
        if (dotIndex < 1) {
            return false;
        }
        String fileActualName = fileName.substring(0, dotIndex);
        String fileType = fileName.substring(dotIndex + 1);
        return fileType.equalsIgnoreCase("JPG");
    }

    private static int convertMiliToDay(long mili) {
        return (int) mili / (1000 * 60 * 60 * 24);
    }

    public static int subtractDate(Date initial_date, Date final_date) {
        return convertMiliToDay(final_date.getTime() - initial_date.getTime());
    }

    public static String getStatus(int stat) {
        return stat == 0 ? "Requested" : (stat == 1 ? "Accepted" : (stat == 2 ? "Rejected" : ""));
    }
}
