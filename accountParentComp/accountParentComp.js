import { api, LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import Name from '@salesforce/schema/Account.Name';
export default class AccountParentComp extends LightningElement {

@api Name;
@api accountId;

handleName(event){
    this.Name = event.detail.AccName;
}
createAccRecord(){
    const fields= {};
    fields[Name.fieldApiName] = this.Name;


    const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName,fields };

    createRecord(recordInput)
    .then(accountObj =>{
        this.accountId = accountObj.Id;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Account created Succesfully',
                variant: 'success',
            }),
        );
       
    })
    .catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Failed to Insert record',
                message: error.body.message,
                variant: 'error',
            }),
        );
        
    });
  

}

}