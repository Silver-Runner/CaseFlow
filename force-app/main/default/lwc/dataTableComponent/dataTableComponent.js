import { LightningElement,wire } from 'lwc';
import getAllAccount from "@salesforce/apex/AccountHandler.getAllAccount";
export default class DataTableComponent extends LightningElement {

    @wire(getAllAccount) allAccounts;

    columns = [
        {label:"Account Id" , fieldName:"Id"},
        {label:"Account Annual Revenue", fieldName:"AnnualRevenue"},
        {label:"Account isActive" , fieldName:"Active__c"},
        {label:"Account Name" , fieldName:"Name"},
    ];
    
}