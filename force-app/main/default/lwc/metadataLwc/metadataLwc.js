import { LightningElement, track, wire } from 'lwc';
import getRelatedContacts from '@salesforce/apex/MetadataInspectorController.getRelatedContacts';
import getFieldsFromMetadata from '@salesforce/apex/MetadataInspectorController.getFieldsFromMetadata';
import getFieldValue from '@salesforce/apex/MetadataInspectorController.getFieldValue';
import getAccounts from '@salesforce/apex/MetadataInspectorController.getAccounts';

export default class MetadataLwc extends LightningElement {
    accountId;
    contactId;
    fieldName;
    resultValue;
    
    @track accountOptions = [];
    @track contactOptions = [];
    @track fieldOptions = [];

    @wire(getFieldsFromMetadata)
    wiredFields({ error, data }) {
        if (data) this.fieldOptions = data;
    }

    connectedCallback() {
        getAccounts()
            .then(result => {
                this.accountOptions = result.map(acc => ({ label: acc.Name, value: acc.Id }));
            })
            .catch(error => console.error('Loading err', error));
    }

    handleAccountChange(event) {
        const selectedAccountId = event.detail.value;
        this.accountId = selectedAccountId;
        this.contactOptions = []; 
        this.contactId = null;    
        this.fieldName = null;    
        this.resultValue = null;  

        getRelatedContacts({ accountId: selectedAccountId })
            .then(result => {
                console.log('Контакты получены для ' + selectedAccountId, result);
                this.contactOptions = [...result]; 
            })
            .catch(error => {
                console.error('Ошибка при получении контактов:', error);
            });
    }

    handleContactChange(event) {
        this.contactId = event.detail.value;
        this.fieldName = null;
        this.resultValue = null;
    }

    handleFieldChange(event) {
        this.fieldName = event.detail.value;
        if (this.contactId && this.fieldName) {
            getFieldValue({ recordId: this.contactId, fieldName: this.fieldName })
                .then(result => {
                    this.resultValue = result;
                })
                .catch(error => {
                    console.error('Err', error);
                });
        }
    }
}