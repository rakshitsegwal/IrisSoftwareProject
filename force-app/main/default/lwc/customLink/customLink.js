import { LightningElement, track } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountController.fetchAccounts';
const COLUMNS = [
    {
        label: 'Name', fieldName: 'AccountURL', type: 'url',
        typeAttributes: {
            label: {
                fieldName: 'Name'
            }
        }
    },
    {label: 'Type', fieldName: 'Type', type: 'text'},
    {label: 'Phone', fieldName: 'Phone', type: 'phone', 
        cellAttributes: { 
            iconName: 'utility:phone_portrait' 
        }
    }
];

export default class CustomLink extends LightningElement {
    @track lstAccounts;
    lstColumns = COLUMNS;

    connectedCallback(){
        fetchAccounts().then(response => {
            this.lstAccounts = response;
            if(this.lstAccounts){
                this.lstAccounts.forEach(item => item['AccountURL'] = '/lightning/r/Account/' +item['Id'] +'/view');
                
            }

            console.log('working-->' + JSON.stringify(this.lstAccounts));
            console.log('columnsss->' + JSON.stringify(this.lstColumns));
        }).catch(error => {
            console.log('Error: ' +error);
        });
    }
}