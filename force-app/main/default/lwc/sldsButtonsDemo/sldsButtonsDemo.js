import { LightningElement } from 'lwc';
export default class SldsButtonsDemo extends LightningElement {

    clickedButtonLabel;
    clickedButtonLabel2;

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
    }

    handleClick2(event){
        this.clickedButtonLabel2 = event.target.value;
    }
}