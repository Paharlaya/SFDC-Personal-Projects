import { LightningElement } from 'lwc';

export default class DemoLWC extends LightningElement {

firstname='';
lastName='';

handleClick(event){
    var input = this.template.querySelectorAll("lightning-input");

    input.forEach(function(element){
        if(element.name == 'fname')
        this.firstName = element.value;

        
        else if(element.name == 'lname')
        this.lastName = element.value;
    },this);
}
    
}