import { LightningElement, api } from 'lwc';
export default class ChildComponent extends LightningElement {
    childVal;
    isVisible = false;

    @api
    get val(){
        return this.childVal;
    }

    set val(value){
        this.childVal = Number(value);
        this.isVisible = (this.childVal <= 100);
    }
}