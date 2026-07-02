import { LightningElement } from 'lwc';
import diplayAllHigherOpportunities  from '@salesforce/apex/OpportunityHandler.diplayAllHigherOpportunities';
export default class ApexWireMethodUsingButton extends LightningElement {

    oppties; error;
    stageVal;
    changeHandler(event){
        this.stageVal = event.target.value;
    }
     // functionName()
        // .then(result => {
        //     //save the result in an array/variable
        // }).catch(err => {
        //     //save the error in an array/variable
        // })

    handleClick(){
        diplayAllHigherOpportunities({SName : this.stageVal})
        .then(result => {
            this.oppties = result;
            this.error = undefined;
        }).catch(err => {
            this.oppties = undefined;
            this.error = err;
        })
    }
}