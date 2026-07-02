import { LightningElement } from 'lwc';
export default class TestComponent_one extends LightningElement {

    empName = 'Rishabh';
    changeHandler (event){
        this.empName = event.target.value;
    }
}