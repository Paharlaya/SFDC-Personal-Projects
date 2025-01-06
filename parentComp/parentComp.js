import { LightningElement, track } from 'lwc';

export default class ParentComp extends LightningElement {

  @track  parentValue = "I am from parent component";

  handleEvent(event){
    alert('custom event fired');
    this.parentValue = "Custom Event";
    alert('parameter from child' +event.detail.firstParam);
    alert('second parameter from child' + event.detail.secondParam);
  }

  /*handleChange(){
    this.parentValue = "Third Value from method";
  }

   handleCall(){
    var childCompVar = this.template.querySelector('c-child-comp');
    var sendParam = {'firstName' : 'Paharlaya'};
    childCompVar.testChildmethod(sendParam);
   }*/
    
}