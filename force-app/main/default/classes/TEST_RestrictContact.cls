/**
 * Created by ynurazkhan on 07.07.2022.
 */
@IsTest
public with sharing class TEST_RestrictContact {
    @IsTest
    private static void testDeletion() {
        Contact testContact = TEST_Data_Factory.createContact();
        System.assert(testContact != null);
        Test.startTest();
        Database.SaveResult result = Database.insert(testContact, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
    }
}