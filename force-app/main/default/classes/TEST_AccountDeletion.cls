/**
 * Created by ynurazkhan on 07.07.2022.
 */

@IsTest
public with sharing class TEST_AccountDeletion {
    @TestSetup
    private static void testSetup() {
        Account testAccount = TEST_Data_Factory.createAccount();
        List<Opportunity> testOpportunities = TEST_Data_Factory.createOpportunity();
        insert testAccount;
        for (Opportunity opportunity : testOpportunities) {
            opportunity.AccountId = testAccount.Id;
        }
        insert testOpportunities;
    }
    @IsTest
    private static void testDeletion() {
        List<Account> testAccount = [SELECT Id, Name FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity)];
        System.assert(!testAccount.isEmpty());
        Test.startTest();
        Database.DeleteResult result = Database.delete(testAccount[0], false);
        Test.stopTest();
        System.assert(result.isSuccess(), 'Couldnt delete account related to oportunities');
    }
}