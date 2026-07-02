import { LightningElement } from 'lwc';
export default class TestChildComponent extends LightningElement {

    message = "Data From Child";

    handleClick(){
        console.log("The Button At The Child is Called");

        const evt = new CustomEvent("buttonClick",
        {
            bubbles : true,
            composed : true,
            details : this.message,
        });
        this.dispatchEvent(evt);
        console.log("Event is: "+evt);
    }
}