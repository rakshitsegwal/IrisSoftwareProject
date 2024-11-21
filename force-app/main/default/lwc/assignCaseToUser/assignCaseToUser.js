import { LightningElement , wire } from 'lwc';
import getAvailablePerson from '@salesforce/apex/AssignCaseToServicePersonnel.getAvailablePerson';
import assignUserToCase from '@salesforce/apex/AssignCaseToServicePersonnel.assignUserToCase';
const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'On Duty', fieldName: 'On_Duty__c', type: 'boolean' },
    { label: 'Current Case Count', fieldName: 'Current_Assignments__c', type: 'number' }
];

export default class AssignCaseToUser extends LightningElement {

    allPersons = [];
    data = [];
    columns = columns;

    @wire (getAvailablePerson)
	wiredAccounts({data, error}){
		if(data) {
			this.allPersons =data;
            console.log('returned-->' + JSON.stringify(this.allPersons));
			this.error = undefined;
		}else {
			this.accounts =undefined;
			this.error = error;
        }
		}

}