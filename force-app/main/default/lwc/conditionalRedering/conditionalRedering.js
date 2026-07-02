import { LightningElement } from 'lwc';
export default class ConditionalRedering extends LightningElement {

    isChecked = false;
    empName = "";
    handleChange(event){
        this.isChecked = event.target.checked;
    }
    changeHandler(event){
        this.empName = event.target.value;
    }
}