import { api, LightningElement, track } from 'lwc';

export default class ChildY extends LightningElement {

    @track trackParam ="trackvalue";
    @api apiParam  ="apiValue";
    nonReactiveParam = "nonReactive";

    handleParamValues(){

        this.trackParam = "value changed from trackparam";
        this.apiParam = "value changed from api param";
        this.nonReactiveParam = "value changed from non reactive param";
    }
}