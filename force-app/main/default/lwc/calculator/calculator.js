import { LightningElement,track} from 'lwc';

export default class Calculator extends LightningElement {
   @track num1;
   @track  num2;
  @track num3;
   @track result;

   handlechange(event){
const currentname = event.target.name;
const currentvalue = event.target.value;
if(currentname==='number1')
{
this.num1=currentvalue;
   }
if(currentname==='number2')
{

    this.num2=currentvalue;
   }
if(currentname==='number3'){
    this.num3=currentvalue;
   }

}

    handleonadd(event){
        console.log('inside click method' + window.location.origin +'/'+ event.currentTarget.dataset.id);
        console.log('id-->' + event.currentTarget.dataset.id);
        console.log('firstnumber-->' + this.num1 + 'num2-->' + this.num2 + 'num3-->' + this.num3);
        this.result=parseInt(this.num1)+parseInt(this.num2)+parseInt(this.num3);
        console.log('sum' +parseInt(this.num1) + parseInt(this.num2) + parseInt(this.num3));
       // parseint is use to avoid concatenation
    
    }
    handleonsub(event){
        this.result=parseInt(this.num1)-parseInt(this.num2);
        //ent(this.num3);
    
    }
    handleonmulti(event){
        this.result=parseInt(this.num1)*parseInt(this.num2);
        parent(this.num3);
    
    }
    handleondiv(event){
        this.result=parseInt(this.num1)/parseInt(this.num2);
        parent(this.num3);
    
    }
}