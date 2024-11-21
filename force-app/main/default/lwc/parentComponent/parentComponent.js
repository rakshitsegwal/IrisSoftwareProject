import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class NavigationExampleLWC extends NavigationMixin(LightningElement){
    //buttonName
    picklistValueSelected;
    pickListSelected = false;
     get options() {
        return [
            { label: 'College Student', value: 'CollegeStudent' },
            { label: 'Fresher', value: 'Fresher' },
            { label: 'Experienced', value: 'Experienced' },
        ];
    }

    handleChangeOfPicklist(event){
            console.log('picklist value selected' + event.detail.value);
            /*this.picklistValueSelected = event.detail.value;
            this.pickListSelected = true;*/

            this.template.querySelector('c-child-Comp').changeMessage(event.detail.value);
    }
    handleChangeEvent(event){
        //this.template.querySelector('c-child-Comp').changeMessage(event.target.value);
        this.template.querySelector('c-child-Comp').itemName = event.target.value;
    }

    handleCustomEvent(event){

        console.log('parent has handled the custom event and got value from the child:' + event.detail);

        if(!event.detail.includes('Duplicate;')){
                 const event1 = new ShowToastEvent({
        title: event.detail,
        message: 'Toast Message',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(event1);
    console.log('from here we would navigate');

      // Navigate to View Account Page
   
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail,
                objectApiName: 'Form_Registration__c',
                actionName: 'view'
            },
        });
        }

        else{

            window.alert('already registered now navigating to registered record');
            console.log('event.detail----->' + event.detail);
            
            var duplicateId = event.detail.split(';')[1];

             this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: duplicateId,
                objectApiName: 'Form_Registration__c',
                actionName: 'view'
            },
        });

        }
       
    
    }


    
}