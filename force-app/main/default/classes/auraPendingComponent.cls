/**
 * Created by ynurazkhan on 08.07.2022.
 */

public with sharing class auraPendingComponent {
    @AuraEnabled
    public static List<Webinar__c> listWebinars() {
        return [SELECT Id, Status__c, Name, Cost__c, Approval_Status__c FROM Webinar__c WHERE Approval_Status__c = 'Pending'];
    }

    @AuraEnabled
    public static void changeStatus(String Id, String status) {
        Webinar__c webinar = [SELECT Id, Approval_Status__c FROM Webinar__c WHERE Id = :Id];
        System.debug('Webinars:' + webinar);
        if (status == 'reject') {
            webinar.Approval_Status__c = 'Rejected';
        } else if (status == 'approve') {
            webinar.Approval_Status__c = 'Approved';
        }
        System.debug('Webinar status: ' + webinar.Approval_Status__c);
        try {
            update webinar;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}