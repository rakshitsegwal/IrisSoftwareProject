import { LightningElement, track, api } from 'lwc';
import insertFormInfo from '@salesforce/apex/FormRegistrationController.insertFormInfo';
export default class ChildComponent extends LightningElement {
     Message;
     @api itemName;
     showClgForm = false;
     ShowFresherFrom = false;
     ShowExpForm = false;

     firstField ='';
     secondField = '';
     thirdField = '';

   /*  connectedCallback(){
         console.log('itemname-->' + this.itemName);

        
         
     }*/
    @api
    changeMessage(strString) {
         //this.Message = strString.toUpperCase();
         console.log('attirbute value from parent-->' + strString);

          if(strString === 'CollegeStudent'){
             this.showClgForm =true;
             this.ShowFresherFrom =false;
             this.ShowExpForm =false;
         }

         if(strString === 'Fresher'){
             this.showClgForm =false;
             this.ShowFresherFrom =true;
             this.ShowExpForm =false;
         }

         if(strString === 'Experienced'){
             this.showClgForm =false;
             this.ShowFresherFrom =false;
             this.ShowExpForm =true;
         }


    }


    handleValueEntered(event){
        console.log('value entered--> ' + event.target.label);
        console.log('value entered--> ' + event.target.value);

        

        switch(event.target.label){

            case 'Student Name':
                this.firstField = event.target.value;
                break;

                case 'Department':
                this.secondField = event.target.value;
                break;

                case 'Phone':
                this.thirdField = event.target.value;
                break;
        }


        console.log('firstfield-->' + this.firstField);
        console.log('secondField-->' + this.secondField);
        console.log('thirdField-->' + this.thirdField);


            

        //calling apex ends.
    }


    insertFormRecords(event){
        //calling apex 
             insertFormInfo({ Name: this.firstField,
                Experience: this.secondField,
                Phone: this.thirdField
             })
            .then(result => {
               
                console.log('inside apex success with no stringiy--->' + JSON.stringify(result));

                      event.preventDefault();
       // const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: result
           
        });
       this.dispatchEvent(selectEvent);
                //console.log('inside apex success with stringify--->' + JSON.stringify(result));
            })
            .catch(error => {
                this.error = error;
            });
    }
}