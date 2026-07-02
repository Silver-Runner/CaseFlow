import { LightningElement, track } from 'lwc';
import getTotalOptyCount from '@salesforce/apex/OpportunityHandler.getTotalOptyCount';
import getPageBasedOpportunity from '@salesforce/apex/OpportunityHandler.getPageBasedOpportunity';
export default class TestPaginationCompoenet extends LightningElement {

@track Opportunities;
totalfetchedOptyCount;
pageSize = 20;
pageNumber = 1;
@track error;
total_Pages;

columns = [
    {label: 'Opty Id', fieldName: 'Id'},
    {label: 'Opty Name', fieldName: 'Name'},
    {label: 'Opty StageName', fieldName: 'StageName'},
    {label: 'Opty Amount', fieldName: 'Amount'},
    {label: 'Opty Expected Revenue', fieldName: 'ExpectedRevenue'},
];

connectedCallback() {
    this.fetchTotalOptyCount();
    this.fetchPageBasedOpportunity();
}

fetchTotalOptyCount(){
    getTotalOptyCount()
    .then(result => {
        this.totalfetchedOptyCount = result;
        this.total_Pages = Math.ceil(this.totalfetchedOptyCount/this.pageSize);
    }).catch(error => {
        this.error = error;
    })
}

fetchPageBasedOpportunity(){
    getPageBasedOpportunity({vpageSize : this.pageSize, vpageNumber : this.pageNumber})
    .then(result => {
        this.Opportunities = result;
        this.error = undefined;
    }).catch(error => {
        this.error = error;
    })
}

nextHandler(){
    if(this.pageNumber < this.total_Pages){
        this.pageNumber++;
        this.fetchPageBasedOpportunity();
    }
}

prevHandler(){
    if(this.pageNumber > 1){
        this.pageNumber--;
        this.fetchPageBasedOpportunity();
    }
}

get disableNext() {
    return this.pageNumber === this.total_Pages;
}

get disablePrev() {
    return this.pageNumber === 1;
}
}