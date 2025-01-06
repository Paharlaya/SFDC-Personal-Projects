import { LightningElement, wire,api,track } from 'lwc';
import getRelatedContactsByFilter from '@salesforce/apex/ContactController.getRelatedContactsByFilter';
import {showToastEvent} from 'lightning/platformShowToastEvent';

import { subscribe,unsubscribe,MessageContext } from 'lightning/messageService';
import filterContactsLMS from '@salesforce/messageChannel/FilterContactsMessageChannel__c';

const COLUMNS= [
    {label: 'Name', fieldName : 'Name'},
    {label : 'Phone', fieldName : 'Phone', type : 'phone' },
    {label : 'Email', fieldName: 'Email', type : 'email' }

];


export default class LmsRelatedContacts extends LightningElement {

subscription = null;
@wire(MessageContext)
MessageContext;

@api recordId; //gets account record id from account record page

@track columns = COLUMNS;
@track data;

connectedCallback(){
    if(!this.subscription) {
        this.subscription = subscribe (
            this.MessageContext,
             filterContactsLMS,
             (message) => this.handleFilterKeySubmit(message)
        );
    }
        this.loadRelatedContacts("");
}

disconnectedCallback(){
    unsubscribe(this.subscription);
    this.subscription = null;
}

loadRelatedContacts(filterKey){
   getRelatedContactsByFilter({accountId : this.recordId, key:filterKey})
   .then(results=>{
    this.data = results;
   })
   .catch(error=>{
    this.dispatchEvent(
        new showToastEvent({
            title: 'Error',
            message: error.body.message,
            variant: 'error'
        })
    );

   });

}

handleFilterKeySubmit(message){
    const filterKey = message.filterKey;
    this.loadRelatedContacts(filterKey);
}


}