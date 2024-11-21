import { api, LightningElement } from "lwc";

//1. Import reference to the Object and fields

import ACCOUNT_OBJECT from "@salesforce/schema/Account";

import ID_FIELD from "@salesforce/schema/Account.Id";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";

//2. Import the named import updateRecord
import { updateRecord } from "lightning/uiRecordApi";

export default class ExploreUpdateRecord extends LightningElement {
    
  //3. If I need to update a record then I should have access
  // to the recordId(make sure you use the adaptor @api).    
  @api
  recordId;
  
  name;
  industry;
  rating;

  handleChange(e) {
    if (e.target.name === "name") {
    
      //this is name input textbox
      this.name = e.target.value;
      console.log(this.name);
    } else if (e.target.name === "industry") {
    
      //this is industry input textbox
      this.industry = e.target.value;
      console.log(this.industry);
    } else if (e.target.name === "rating") {
    
      //this is rating input textbox
      this.rating = e.target.value;
      console.log(this.rating);
    }
  }

  handleClick() {
      //4. map the data to the fields
    const fields = {};

    fields[ID_FIELD.fieldApiName] = this.recordId;
    fields[NAME_FIELD.fieldApiName] = this.name;
    fields[INDUSTRY_FIELD.fieldApiName] = this.industry;
    fields[RATING_FIELD.fieldApiName] = this.rating;
        
        //5. Create a config object that had info about fields. 
        //Quick heads up here we are not providing Object API Name
    const recordInput = {
      fields: fields
    };

        //6. Invoke the method updateRecord()
    updateRecord(recordInput).then((record) => {
      console.log(record);
    });
  }
}