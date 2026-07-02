import { LightningElement, api } from 'lwc';
export default class TestHeadless extends LightningElement {

    @api invoke(){
        alert("HeadLess Action Executed from lightning action");
    }
}