public with sharing class WebinarMemberTriggerHandler {

    public static void handleContactAssignment(List<Webinar_Team_Member__c> newList) {
        allowContactAssignment(newList);
    }

    public static void handleContactOrUser(List<Webinar_Team_Member__c> newList){
        memberContactOrUser(newList);
    }


    private static void allowContactAssignment(List<Webinar_Team_Member__c> webinarMembers) {
        for (Webinar_Team_Member__c webinarMember : webinarMembers) {
            if (webinarMember.Related_Webinar__r.Type__c != 'External' && webinarMember.Related_Contact__c != null) {
                webinarMember.addError('To Assign the contact, Webinar type should be External!');
            }
        }
    }

    private static void memberContactOrUser(List<Webinar_Team_Member__c> webinarTeamMembers) {
        for (Webinar_Team_Member__c webinarTeamMember : webinarTeamMembers) {
            if (webinarTeamMember.Related_Contact__c != null && webinarTeamMember.Related_User__c != null) {
                webinarTeamMember.addError('Webinar member should be either Contact OR User!');
            }
        }
    }
}