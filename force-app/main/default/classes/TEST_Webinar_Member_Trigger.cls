/**
 * Created by ynurazkhan on 07.07.2022.
 */
@IsTest
public with sharing class TEST_Webinar_Member_Trigger {
//    @TestSetup
//    private static void testSetUp(){
//        Webinar__c testWebinar = TEST_Data_Factory.createWebinarWithMembers();
//        insert testWebinar;
//    }
    @IsTest(SeeAllData = true)
    private static void contactAndUser(){
        List<User> user = [SELECT Id FROM User];
        List<Contact> contact = [SELECT Id FROM Contact];
        Webinar_Team_Member__c teamMember = new Webinar_Team_Member__c(Related_User__c = user[0].Id, Related_Contact__c = contact[0].Id);
        System.debug(Webinar_Team_Member__c.Related_User__c);
        Test.startTest();
        Database.SaveResult result = Database.insert(teamMember, false);
        Test.stopTest();
        System.assert(!result.isSuccess(), 'Data was added successfully');
        System.assertEquals('Webinar member should be either Contact OR User!', result.getErrors()[0].getMessage());
    }

    @IsTest(SeeAllData = true)
    private static void testContactOnly(){
        List<Contact> contact = [SELECT Id FROM Contact];
        Webinar_Team_Member__c teamMember = new Webinar_Team_Member__c( Related_Contact__c = contact[0].Id);
        System.debug(Webinar_Team_Member__c.Related_User__c);
        System.debug(Webinar_Team_Member__c.Related_Contact__c);
        Test.startTest();
        Database.SaveResult result = Database.insert(teamMember, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'Data was not added successfully');
    }
}