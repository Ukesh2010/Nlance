/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.helper;

/**
 *
 * @author EyeWeb005
 */
public class SystemAttributes {

    // location to store file uploaded
    public static final String UPLOAD_DIRECTORY = "upload";

    public static final class BidderStatuses {

        public static final String BIDED = "bided";
        public static final String ACCEPTED = "accepted";
        public static final String APPROVED = "approved";
    }

    public static final class BidControllerType {

        public static final int INSERTBID = 0;
        public static final int ACCEPT = 1;
        public static final int APPROVE = 2;

    }

    public static final class JobStatuses {

        public static final String OPEN = "open";
        public static final String INPROGRESS = "inprogress";
        public static final String CLOSED = "closed";
        public static final String S_CLOSED = "s_closed";

    }

    public static final class MileStoneStatuses {

        public static final int REQUEST = 0;
        public static final int ACCEPT = 1;
        public static final int REJECT = 2;

    }
}
