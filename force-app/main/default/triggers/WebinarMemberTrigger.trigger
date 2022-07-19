/**
 * Created by ynurazkhan on 06.07.2022.
 */

trigger WebinarMemberTrigger on Webinar_Team_Member__c (before insert, before update, before delete, after insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        WebinarMemberTriggerHandler.handleContactAssignment(Trigger.new);
        WebinarMemberTriggerHandler.handleContactOrUser(Trigger.new);
    }

    else if (Trigger.isBefore && Trigger.isUpdate) {
        WebinarMemberTriggerHandler.handleContactAssignment(Trigger.new);
        WebinarMemberTriggerHandler.handleContactOrUser(Trigger.new);
    }

}