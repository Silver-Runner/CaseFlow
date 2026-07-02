import { LightningElement, wire} from 'lwc';
import diplayAllOpportunities  from '@salesforce/apex/OpportunityHandler.diplayAllOpportunities';
export default class TestApexWireMethodOne extends LightningElement {

    @wire(diplayAllOpportunities) allOppties;
}