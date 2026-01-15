@isTest
private class AccountHandlerTest {
    
    @isTest
    static void testCreateAccounts() {
        // 1. Подготовка данных (в данном случае не нужна)
        
        // 2. Запуск тестируемого метода
        Test.startTest();
        AccountHandler.createAccounts(5); // Просим создать 5 аккаунтов
        Test.stopTest();
        
        // 3. Проверка результата (Asserts)
        List<Account> accts = [SELECT Id FROM Account WHERE Name LIKE 'Account %'];
        System.assertEquals(5, accts.size(), 'Должно быть создано ровно 5 аккаунтов');
    }
}