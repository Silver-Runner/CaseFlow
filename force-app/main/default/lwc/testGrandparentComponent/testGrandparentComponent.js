import { LightningElement } from 'lwc';
export default class TestGrandparentComponent extends LightningElement {

    displayMsg = "No Data Recived From Grand Child Component";

    btnClickhandler(event){

        this.displayMsg = event.detail;
        console.log('Grand Parent Comp Handler Got Called');
    }
}