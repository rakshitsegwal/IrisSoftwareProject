// apexWireMethodWithParams.js
import { LightningElement, wire, api } from 'lwc';
import findContacts from '@salesforce/apex/ContactController.findContacts';

/** The delay used when debouncing event handlers before invoking Apex. */
const DELAY = 300;
export default class ApexWireMethodWithParams extends LightningElement {
    searchKey = '';
    showData = false;
    finalData = [];

    //simple wire to call apex and get search results
    @wire(findContacts, { searchKey: '$searchKey' })
    contacts;

   
   /* import { adapterId } from 'adapterModule';
@wire(adapterId, adapterConfig)
propertyOrFunction;*/
    handleKeyChange(event) {
        console.log('inside change' + event.target.value.length);
       if(event.which === 13){
      console.log('inside enter button click' + event.target.value.length);
      this.searchKey = event.target.value;
            console.log('results->' + JSON.stringify(this.contacts));
            this.showData = true;

           
    }
          
           if(event.target.value.length == 0){
                this.showData = false;
            }  
          
    }


    openContact(event){
        console.log('inside click method');
        console.log('id-->' + event.currentTarget.dataset.id);
        
        window.open(window.location.origin+'/'+event.currentTarget.dataset.id);

    }
}