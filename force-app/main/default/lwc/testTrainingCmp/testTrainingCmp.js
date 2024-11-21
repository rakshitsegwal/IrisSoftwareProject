// apexWireMethodToProperty.js
import { LightningElement, wire } from 'lwc';
//importing apex method
import AccountInfo from '@salesforce/apex/TestingCetpa.UserInfo';


export default class ApexWireMethodToProperty extends LightningElement {
   showDiv = false;
   userInfo;
    constructor(){
        super();
        console.log('inside constructor');
    }

    
       
    

    connectedCallback(){
        console.log('inside connected callback');
        this.showDiv = true;
           // var userInfo;
        //calling apex 
             AccountInfo()
            .then(result => {
                //this.contacts = result;
                this.userInfo = result;
                console.log('inside apex success with no stringiy--->' + JSON.stringify(this.userInfo));
                //console.log('inside apex success with stringify--->' + JSON.stringify(result));
            })
            .catch(error => {
                this.error = error;
            });

        //calling apex ends.
    }

    renderedCallback(){
        console.log('inside rendered callback');
    }

    handleOnClick(event){

        alert('button is clicked-->' + event.target.label);
       // this.showDiv = true;
        
    }
}