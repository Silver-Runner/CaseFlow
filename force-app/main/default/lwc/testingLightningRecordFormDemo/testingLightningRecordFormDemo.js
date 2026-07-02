import { LightningElement, api } from 'lwc';
export default class TestingLightningRecordFormDemo extends LightningElement {

    @api recordId = '003gL00000S0fMPQAZ';
    @api objectApiName = 'Contact';
    fields = ['Id', 'Name', 'Title', 'Email'];
}