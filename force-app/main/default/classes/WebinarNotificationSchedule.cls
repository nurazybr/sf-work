/**
 * Created by ynurazkhan on 14.07.2022.
 */

global with sharing class WebinarNotificationSchedule implements Database.Batchable<SObject>, Schedulable {
    private static final String BATCH_CLASS_NAME = 'WebinarNotifications';
    public void execute(Database.BatchableContext param1, List<Webinar_Team_Member__c> records) {
        List<FeedItem> feedItemsToInsert = new List<FeedItem>();
        for (Webinar_Team_Member__c webinarTeamMember : records) {
            if (webinarTeamMember.Related_User__c != null) {
                FeedItem post = new FeedItem();
                post.ParentId = webinarTeamMember.Related_User__c; //eg. Opportunity id, custom object id..
                post.Body = 'You have a new webinar coming up in 2 hours.';
                feedItemsToInsert.add(post);
            } else {
                System.debug('User is null');
            }
        }
        insert feedItemsToInsert;
    }
    public void finish(Database.BatchableContext param1) {
    }
    public Database.QueryLocator start(Database.BatchableContext param1) {
        Datetime now = Datetime.now();
        Integer offset = UserInfo.getTimeZone().getOffset(now);
        Datetime local = now.addSeconds(offset/1000);
        Datetime targetTime = local.addHours(2);
        Datetime currentTimePlusOne = local.addHours(1);
        return Database.getQueryLocator('SELECT Id, Related_User__c, Related_Webinar__c ' +
                                        'FROM Webinar_Team_Member__c ' +
                                        'WHERE Related_Webinar__r.Start_Date__c <= :targetTime ' +
                                        'AND Related_Webinar__r.Start_Date__c < :currentTimePlusOne');
    }
    // For a Schedulable
    global void execute(SchedulableContext sc) {
        Object batchObject = Type.forName(BATCH_CLASS_NAME).newInstance();
        if (batchObject instanceof Database.Batchable<SObject>) {
            Database.Batchable<SObject> batchClass = (Database.Batchable<SObject>) batchObject;
            Database.executeBatch(batchClass);
        }
    }
}