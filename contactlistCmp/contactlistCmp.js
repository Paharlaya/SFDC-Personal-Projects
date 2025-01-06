import { LightningElement, track, wire,api } from 'lwc';
import getContactList from '@salesforce/apex/contactListCtrl.getContactList';


export default class ContactlistCmp extends LightningElement {

   
    @track conList;
    
   // @wire (getContactList) conList;  //this is binding to a property

   /**@wire(getContactList)  //another way of binding wire with a function
   contactList(data,error){
        if(data){
            this.conList = data;
        }else if(error){
            console.log('error #'+error);
        }
   }  **/


   //Now using imperative call



getList(){
    
    getContactList().then(result=>{
        this.conList = result;
       })
    
       .catch(error=>{
      this.error = error;
    
       });

   
}


}