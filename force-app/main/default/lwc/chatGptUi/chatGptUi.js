import { LightningElement } from 'lwc';
import searchAI from '@salesforce/apex/ChatGptIntegration.searchAI';
export default class ChatGptUi extends LightningElement {
    responseValue;
    get searchedQuestion(){
        return 'sample question';
    }

    getResult(event){
        console.log('keyword-->' + event.target.value);
            searchAI({question : 'what is google'})
            .then(result => {
                console.log('result-->' + JSON.stringify(JSON.parse(result)));
                console.log('typeof-->' + typeof result);
                this.responseValue = JSON.parse(result).choices[0].text;
            })
            .catch(error => {
                console.log('inside error' + JSON.stringify(error));
                //this.error = error;
            });
    }

}