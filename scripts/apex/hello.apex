// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

// 1. Извлекаем настройки (используем только Target_Object__c и Contact_Field__c)
List<Field_Mapping_Configuration__mdt> metadataFields = [
    SELECT Contact_Field__r.QualifiedApiName 
    FROM Field_Mapping_Configuration__mdt
    WHERE Target_Object__c = 'Contact' // Фильтруем только по существующему полю
];

// 2. Собираем API-имена полей
List<String> fieldNames = new List<String>();
for (Field_Mapping_Configuration__mdt m : metadataFields) {
    if (m.Contact_Field__r.QualifiedApiName != null) {
        fieldNames.add(m.Contact_Field__r.QualifiedApiName);
    }
}

// Добавляем Id, чтобы запрос не был пустым
if (!fieldNames.contains('Id')) { fieldNames.add('Id'); }

// 3. Формируем и выполняем запрос
if (!fieldNames.isEmpty()) {
    String accountId = '001gL00000apbfAQAQ'; 
    
    // Собираем запрос
    String query = 'SELECT ' + String.join(fieldNames, ', ') + 
                   ' FROM Contact ' + 
                   ' WHERE AccountId = \'' + accountId + '\'';
    
    System.debug('Сгенерированный запрос: ' + query);

    List<Contact> contacts = Database.query(query);

System.debug('--- РЕЗУЛЬТАТЫ ПОИСКА ---');
for (Contact con : contacts) {
    System.debug('--- Контакт ID: ' + con.Id + ' ---');
    
    // Проходимся по всем полям, которые мы настроили в метаданных
    for (String fName : fieldNames) {
        Object value = con.get(fName); // Динамически получаем значение поля
        System.debug('Поле: [' + fName + '] - Значение: ' + (value == null ? 'ПУСТО' : value));
    }
}
    
}