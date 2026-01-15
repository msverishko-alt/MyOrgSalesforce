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
        // Arrange
        Integer numAccts = 5;

        // Act
        Test.startTest();
        AccountHandler.createAccounts(numAccts);
        Test.stopTest();

        // Assert
        List<Account> accts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Account %'];
        System.assertEquals(numAccts, accts.size(), 'The exact number of accounts should be created');
    }
}