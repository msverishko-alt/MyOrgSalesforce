/**
 * @description Handles Account creation logic for the training project.
 */

 // comments for 0.2.0 NEXT  version 
public with sharing class AccountHandler {

    /**
     * @description Creates a specified number of test accounts.
     * @param numAccounts The number of accounts to create.
     */
    public static void createAccounts(Integer numAccounts) {
        List<Account> addAccounts = new List<Account>();

        for (Integer n = 0; n < numAccounts; n++) {
            Account acct = new Account();
            acct.Name = 'Account ' + n;
            addAccounts.add(acct);
        }

        if (!addAccounts.isEmpty()) {
            insert as user addAccounts;
        }
    }
}