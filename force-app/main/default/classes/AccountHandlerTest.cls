/**
 * @description Test class for AccountHandler logic.
 */
@isTest
private class AccountHandlerTest {

    /**
     * @description Positive test case: verify that the correct number of accounts is created.
     */
    @isTest
    static void testCreateAccounts() {     
        Integer numAccts = 5;

        Test.startTest();
        AccountHandler.createAccounts(numAccts);
        Test.stopTest();

        List<Account> accts = [
            SELECT Name 
            FROM Account 
            WHERE Name LIKE 'Account %'];
            
        Assert.areEqual(numAccts, accts.size(), 'The exact number of accounts should be created');
    }
}