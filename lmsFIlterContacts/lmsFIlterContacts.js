import { LightningElement,api,track,wire } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

import { publish, MessageContext } from 'lightning/messageService';
import filterContactsLMS from '@salesforce/messageChannel/FilterContactsMessageChannel__c';



export default class LmsFIlterContacts extends LightningElement {

    @wire(MessageContext) 
    MessageContext;

    @track filterValue;
    @track submittedFilterValue;

    @api componentLabel;

    handleChange(event){
        this.filterValue = event.target.value; 
    }

    handleClick(event){
        let filterBox = this.template.querySelector("lightning-input");
        let filterKeyValue = filterBox.value;
        this.submittedFilterValue = filterKeyValue;

    this.dispatchEvent(
        new ShowToastEvent ({
            title : 'Event dispatched using LMS',
            message : 'Filter key : ' +this.submittedFilterValue,
            variant : 'success'
        })
    );

    const payload = {filterKey : this.submittedFilterValue};
    
    publish(this.MessageContext,filterContactsLMS,payload);

    }

}