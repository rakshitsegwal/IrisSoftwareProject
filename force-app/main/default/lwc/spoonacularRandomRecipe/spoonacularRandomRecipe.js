import { LightningElement } from 'lwc';
import getRecipe from '@salesforce/apex/SpoonacularApi.getRandomRecipe';
export default class SpoonacularRandomRecipe extends LightningElement {


    recipe = [];
    response;
    recipeData = {};
    gotRecipe = false;


    constructor(){
        super();
        console.log('inside constructor');
    }

    connectedCallback(){
        console.log('inside connected callback');
    }

    renderedCallback(){
        console.log('inside rendered callback');
    }

   
    getRecipe(){
        console.log('button is clicked');

        getRecipe()
        .then(result => {
            this.response = JSON.parse(result);
            this.recipe = this.response.recipes;
                    console.log('response->' + this.recipe);
                    this.generateData(this.recipe);
        })
        .catch(error =>{
                console.log('inside error' + JSON.stringify(error));
        });
    }

   

    generateData(recipeArray){
        this.gotRecipe = false;
        console.log('insidemathodcall');
        console.log('credit->'+ JSON.stringify(recipeArray[0].creditsText));
        const rData = recipeArray[0];
        this.gotRecipe = true;
        this.recipeData.title = rData.title;
        this.recipeData.summary = rData.summary;
        this.recipeData.imgurl = rData.image;
        this.recipeData.instructions = rData.instructions;

        console.log('data-->' + JSON.stringify(this.recipeData));
    }
}