import { LightningElement } from 'lwc';
export default class ParentComponent extends LightningElement {
 pvalue='';
 changeHandler(event){
    this.pvalue = event.target.value;
 }
}