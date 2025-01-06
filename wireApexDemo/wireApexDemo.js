import { LightningElement, wire ,api } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts'; //getContacts is an identifier(method name)
import {getRecord} from 'lightning/uiRecordApi';


export default class WireApexDemo extends LightningElement {

@api recordId; 

@wire(getRecord,{recordId: '$recordId', fields: 'Account.Name'})
record;

@wire(getContacts, {accId : '$recordId'})  //everything will be returned in contacts property
contacts; //includes data and error //for fetching we have to write contact.data

get name(){
    return this.record.data.fields.Name.value;
}

}