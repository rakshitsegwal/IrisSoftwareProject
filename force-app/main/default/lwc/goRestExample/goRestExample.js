import { LightningElement } from 'lwc';
import IntegrationExample from '@salesforce/apex/IntegrationExample.getIntegrationData';

export default class GoRestExample extends LightningElement {

        getData(){

                IntegrationExample()
                .then(result =>{
                        console.log('result--->' + JSON.stringify(JSON.parse(result)));
                })
                .catch(error =>{
                    this.error = error;
                });

        }

}