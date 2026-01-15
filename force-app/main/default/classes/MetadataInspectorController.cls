public with sharing class MetadataInspectorController {

    @AuraEnabled
    public static List<Map<String, String>> getRelatedContacts(Id accountId) {

        List<Map<String, String>> options = new List<Map<String, String>>();
        for (Contact con : [
            SELECT Name 
            FROM Contact 
            WHERE AccountId = :accountId 
            ORDER BY Name
        ]) {
            options.add(new Map<String, String>{
                'label' => con.Name,
                'value' => con.Id
            });
        }
        return options;
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getFieldsFromMetadata() {
        List<Map<String, String>> options = new List<Map<String, String>>();

        List<Field_Mapping_Configuration__mdt> metadataFields = [
            SELECT Contact_Field__r.Label, Contact_Field__r.QualifiedApiName 
            FROM Field_Mapping_Configuration__mdt
            WHERE Target_Object__c = 'Contact'
        ];

        for (Field_Mapping_Configuration__mdt m : metadataFields) {
            options.add(new Map<String, String>{
                'label' => m.Contact_Field__r.Label,
                'value' => m.Contact_Field__r.QualifiedApiName
            });
        }
        return options;
    }

    @AuraEnabled
    public static String getFieldValue(Id recordId, String fieldName) {
        String query = 'SELECT ' + String.escapeSingleQuotes(fieldName) +
                       ' FROM Contact WHERE Id = :recordId LIMIT 1';

        Contact con = Database.query(query);
        Object val = con.get(fieldName);
        return val != null ? String.valueOf(val) : 'No value';
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Name 
            FROM Account 
            ORDER BY Name 
            LIMIT 200];
    }
}