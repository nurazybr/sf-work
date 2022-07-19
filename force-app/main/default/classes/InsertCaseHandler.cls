/**
 * Created by ynurazkhan on 07.07.2022.
 */

public with sharing class InsertCaseHandler {
    public static void updateCase(Case myCase) {
        if (myCase.Status == 'Open') {
            myCase.Priority = 'Low';
        } else {
            myCase.Priority = 'Medium';
        }
        update myCase;
    }
}