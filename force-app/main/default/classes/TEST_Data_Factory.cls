/**
 * Created by ynurazkhan on 07.07.2022.
 */

@IsTest
public with sharing class TEST_Data_Factory {
    public static Account createAccount() {
        return createTestAccount();
    }

    public static List<Opportunity> createOpportunity() {
        return createTestOpportunity();
    }

    public static Contact createContact() {
        return createTestContact();
    }

    public static Webinar__c createTestWebinarCount(Boolean lessThan) {
        return createWebinarCount(lessThan);
    }

    public static Webinar__c createWebinarWithMembers() {
        return createWebinarWithMember();
    }


    private static Account createTestAccount() {
        Account testAcc = new Account(Name = 'test Name');
        return testAcc;
    }


    private static List<Opportunity> createTestOpportunity() {
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for (Integer i = 0; i < 4; i++) {
            testOpportunities.add(new Opportunity(Name = 'oppName' + i, StageName = 'stagename', CloseDate = Date.today()));
        }
        return testOpportunities;
    }

    private static Contact createTestContact() {
        Contact testContact = new Contact(LastName = 'INVALIDNAME', MailingStreet = 'Test street', MailingCity = 'Test city', MailingCountry = 'Taiwan', Email = 'testemail@email.com', Phone = '123123');
        return testContact;
    }

    private static Webinar__c createWebinarCount(Boolean isLessThan) {
        Webinar__c testWebinar = new Webinar__c();
        if (isLessThan) {
            testWebinar.Cost__c = 50;
        } else {
            testWebinar.Cost__c = 150;
        }
        return testWebinar;
    }

    private static Webinar__c createWebinarWithMember() {
        Webinar__c testWebinar = new Webinar__c();
        List<Webinar_Team_Member__c> members = new List<Webinar_Team_Member__c>();
        for (Integer i = 0; i < 4; i++) {
            testWebinar.Webinar_Team_Members__r[i] = new Webinar_Team_Member__c(Name = 'test' + i, Related_Contact__c = 'Ybrahmsultan Nurazkhan');
        }
        testWebinar.Type__c = 'Internal';
        return testWebinar;
    }
}