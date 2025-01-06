import { LightningElement,api } from 'lwc';

export default class ChildComp extends LightningElement {
    
   @api parentData;

    @api testChildmethod(parentParam){
        alert('this is child method' +parentParam.firstName);
    }

    handleMe(){
        const childEvent = new CustomEvent('buttonclick',{
            detail : {
                firstParam : 'first value',
                secondParam : 'second value'
            }
        });
        this.dispatchEvent(childEvent);
    }


}