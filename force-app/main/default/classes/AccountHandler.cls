/**
 * @description Handles Account creation logic for the training project.
 */
public with sharing class AccountHandler {

    /**
     * @description Creates a specified number of test accounts.
     * @param numAccounts The number of accounts to create.
     */
    public static void createAccounts(Integer numAccounts) {
        List<Account> addAccounts = new List<Account>();

        // Исправлена ошибка Naming Convention: 'N' заменено на 'i' или 'n'
        for (Integer n = 0; n < numAccounts; n++) {
            Account acct = new Account();
            acct.Name = 'Account ' + n;
            addAccounts.add(acct);
        }

        // Исправлена ошибка Security (CRUD): Добавлено 'as user'
        if (!addAccounts.isEmpty()) {
            insert as user addAccounts;
        }
    }
}