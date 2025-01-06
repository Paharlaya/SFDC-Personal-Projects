import { LightningElement,api, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import Name from '@salesforce/schema/Account.Name';



export default class AccountChildComp extends LightningElement {

@track Name;

handleNameChange(event){
    if(event.target.label==='Name'){
        this.Name = event.target.value;
    }

    const customEvent = new CustomEvent('inputnameevent',{
        detail :{
            AccName : this.Name
        }
    });

    this.dispatchEvent(customEvent);
}




}