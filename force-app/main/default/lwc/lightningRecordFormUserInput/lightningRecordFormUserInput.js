import { LightningElement } from 'lwc';
export default class LightningRecordFormUserInput extends LightningElement {

    recordId=null;
    error;
    objectApiName = 'Account';
    showData = false;

    changeHandler(event){
        this.recordId = event.target.value;
        if(this.recordId == null){
            showData = false;
        }
    }

    handleClick(){
        if(this.recordId != null){
            this.showData = true;
            this.error = this.error ? this.error = null : this.error;
        }else{
            this.error = 'Please Enter a Valid AccountId';
        }
        
    }
}