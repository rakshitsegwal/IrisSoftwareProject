import { LightningElement } from 'lwc';
import TRAILHEADWG_LOGO from '@salesforce/resourceUrl/trailheadlogo';

export default class SetterExampleandStaticResource extends LightningElement {

    trailheadLogoUrl = TRAILHEADWG_LOGO;
    _privateVariable;

    get publicVariable() {
        return this._privateVariable;
    }

    set publicVariable(value) {
        this._privateVariable = value;
    }

    handleButtonClick(event) {
        this.publicVariable = 'New value'; // setting the public variable using the setter
        console.log(this.publicVariable); // getting the public variable using the getter
    }
}