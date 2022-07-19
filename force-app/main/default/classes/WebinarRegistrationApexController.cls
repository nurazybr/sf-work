/**
 * Created by ynurazkhan on 11.07.2022.
 */

public with sharing class WebinarRegistrationApexController {
    @AuraEnabled
    public static List<Webinar__c> searchForWebinars(String approvalStatus, String type){
        return [SELECT Id, Status__c, Name, Cost__c, Approval_Status__c FROM Webinar__c WHERE Approval_Status__c LIKE :approvalStatus AND Type__c LIKE :type];
    }

    @AuraEnabled
    public static void registerUser(String webinarId, String userId){
        Webinar_Team_Member__c member = new Webinar_Team_Member__c(Related_Webinar__c = webinarId, Related_User__c = userId);
        System.debug('.... '+member);
        insert member;
    }
}