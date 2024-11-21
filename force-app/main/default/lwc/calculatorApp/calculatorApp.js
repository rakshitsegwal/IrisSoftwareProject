import { LightningElement , track , api} from 'lwc';

export default class CalculatorApp extends LightningElement {

    @track firstNumber;
    @track secondNumber;

    captureInput(event){
        
        console.log('first-->' + event.target.title);
        if(event.target.title === "first"){
            this.firstNumber = event.target.value;
        }
        else if(event.target.title === "second"){
            this.secondNumber = event.target.value;
        }
    }
}