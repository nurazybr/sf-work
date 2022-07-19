/**
 * Created by ynurazkhan on 07.07.2022.
 */
@IsTest
public with sharing class TEST_Webinar_Trigger {

    @IsTest
    private static void testWebinarLessThan(){
        Webinar__c testWebinarLess = TEST_Data_Factory.createTestWebinarCount(true);
        System.assert(testWebinarLess != null);
        Test.startTest();
        Database.SaveResult result = Database.insert(testWebinarLess, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'could not insert the data');
        List<Webinar__c> testWebinarLesst = [SELECT Id, Approval_Status__c FROM Webinar__c WHERE Cost__c = 50];
        System.assertEquals('Approved', testWebinarLesst[0].Approval_Status__c, 'Status is not Approved!');
    }


    @IsTest
    private static void testWebinarMoreThan(){
        Webinar__c testWebinarLess = TEST_Data_Factory.createTestWebinarCount(false);
        System.assert(testWebinarLess != null);
        Test.startTest();
        Database.SaveResult result = Database.insert(testWebinarLess, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'could not insert the data');
        List<Webinar__c> testWebinarLesst = [SELECT Id, Approval_Status__c FROM Webinar__c WHERE Cost__c = 150];
        System.assertEquals(null, testWebinarLesst[0].Approval_Status__c, 'Status is not Approved!');
    }

    @IsTest
    private static void testWebinarRejectionCheck(){
        Webinar__c testWebinarLess = new Webinar__c( Name = 'qwerty');
        insert testWebinarLess;
        testWebinarLess.Approval_Status__c = 'Rejected';
        System.debug(testWebinarLess.Status__c);
        System.assert(testWebinarLess != null);
        Test.startTest();
        Database.SaveResult result = Database.update(testWebinarLess, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'could not update the data');
        List<Webinar__c> testWebinarLesst = [SELECT Id, Status__c FROM Webinar__c WHERE Name = 'qwerty'];
        System.assertEquals('Cancelled', testWebinarLesst[0].Status__c, 'Status is not Cancelled!');
    }

    @IsTest
    private static void testWebinarRejectionCorrect(){
        Webinar__c testWebinarLess = new Webinar__c( Name = 'qwerty1');
        insert testWebinarLess;
        testWebinarLess.Approval_Status__c = 'Approved';
        System.debug(testWebinarLess.Status__c);
        System.assert(testWebinarLess != null);
        Test.startTest();
        Database.SaveResult result = Database.update(testWebinarLess, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'could not update the data');
        List<Webinar__c> testWebinarLesst = [SELECT Id, Status__c FROM Webinar__c WHERE Name = 'qwerty1'];
        System.assertNotEquals('Cancelled', testWebinarLesst[0].Status__c, 'Status is not Cancelled!');
    }

    @IsTest
    private static void testNumberOfSeatsIncorrect(){
        Webinar__c testWebinar = new Webinar__c(Name = 'qwerty1', Number_of_Participants__c = 50, Total_Number_of_seats__c = 40);
        System.assert(testWebinar != null);
        Test.startTest();
        Database.SaveResult result = Database.insert(testWebinar, false);
        Test.stopTest();
        System.assert(!result.isSuccess(), 'Data was inserted');
        System.assertEquals('number of participants cant exceed number of seats!', result.getErrors()[0].getMessage(), 'Status is not Approved!');
    }

    @IsTest
    private static void testNumberOfSeatsCorrect(){
        Webinar__c testWebinar = new Webinar__c(Name = 'qwerty1', Number_of_Participants__c = 30, Total_Number_of_seats__c = 40);
        System.assert(testWebinar != null);
        Test.startTest();
        Database.SaveResult result = Database.insert(testWebinar, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'Data was not inserted');
    }

    @IsTest
    private static void testAutomaticPriceHandlerCorrect(){
        Webinar__c testWebinar = new Webinar__c(Name = 'qwerty2', Price_per_participant__c = null, Cost__c = 5000, Number_of_Participants__c = 5);
        System.assert(testWebinar != null);
        Test.startTest();
            Database.SaveResult result = Database.insert(testWebinar, false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'Data was not inserted');
        List<Webinar__c> testWebinarLesst = [SELECT Id, Price_per_participant__c FROM Webinar__c WHERE Name = 'qwerty2'];
        System.assertEquals(1000, testWebinarLesst[0].Price_per_participant__c, 'price per participant is not equal!');
    }

}