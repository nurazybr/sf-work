/**
 * Created by ynurazkhan on 05.07.2022.
 */

public with sharing class DeactivateAccountIfActive {
    public void DeactivateAndUpdate(List<Account> accounts){
        for (Account account: accounts){
            if (!account.ActiveChkbox__c){
                for(Contact contact : account.Contacts){
                    contact.Title = account.Description;
                    contact.isActive__c = false;
                }
                Database.update(account.Contacts, false);
            }
        }
    }
}