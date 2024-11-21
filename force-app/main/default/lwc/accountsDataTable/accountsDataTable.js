import {track, LightningElement } from 'lwc';
import getAllAccountData from '@salesforce/apex/AccountsDataTableController.getAllAccountData';
import updateAccountData from '@salesforce/apex/AccountsDataTableController.updateAccountData';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class AccountsDataTable extends LightningElement {
    @track tableData = []; //master data holder
    @track columns = []; //hold columns details
    @track currentPage = 1; // Current page number
    @track pageSize = 10; // Number of records per page
    @track paginatedData = []; // Data to show on the current page
    @track totalRecords = 0; // Total number of records (for pagination)
    @track draftValues = []; //hold data to be updated

    @track searchKey = ''; //search input 
    @track filteredData = []; //filter data on input handling

    //for sorting.
    @track sortBy;
    @track sortDirection;


    connectedCallback() {
        this.loadLatestData();
    }

    loadLatestData() {
        getAllAccountData()
            .then((data) => {
                console.log('wiredData-->' + JSON.stringify(data));

                // Set the table data (account records)
                this.tableData = data.accountData;
                this.filteredData = data.accountData;
                this.totalRecords = this.tableData.length;

                // Create columns from columnInfo
                this.columns = data.columnInfo.map(column => ({
                    label: column.columnName,
                    fieldName: column.columnApiName,
                    editable: column.columnApiName === 'AnnualRevenue' ? true : false,
                    sortable: true

                }));

                // Update paginated data when the data is fetched
                this.updatePagination();
            })
            .catch((error) => {
                this.errorMessage = error.body.message;
                this.showToast('Error', this.errorMessage, 'error');
            });
    }

    updatePagination() {
        const startIndex = (this.currentPage - 1) * this.pageSize;
        const endIndex = startIndex + this.pageSize;
        this.paginatedData = this.filteredData.slice(startIndex, endIndex);
    }

    // Get the total number of pages
    get totalPages() {
        return Math.ceil(this.totalRecords / this.pageSize);
    }

    // Handle page change
    handlePageChange(event) {
        const page = event.detail.pageNumber;
        this.currentPage = page;
        this.updatePagination();
    }

    // Computed properties for disabling the buttons
    get isFirstPage() {
        return this.currentPage === 1;
    }

    get isLastPage() {
        return this.currentPage === this.totalPages;
    }

    // Handle Previous button click
    handlePrevious() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.updatePagination();
        }
    }

    // Handle Next button click
    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.updatePagination();
        }
    }

    //update values logic
    // Handle the Save button click
    handleSave(event) {
        this.draftValues = event.detail.draftValues;
        // Check if there are draft values
        if (this.draftValues.length > 0) {
            updateAccountData({
                    modifiedRec: this.draftValues
                })
                .then(() => {
                    // Clear the draft values after successful save
                    this.draftValues = [];
                    this.loadLatestData();
                    // Optionally, refresh the data or show a success message
                    this.showToast('Success', 'Records updated successfully', 'success');
                })
                .catch((error) => {
                    this.showToast('Error', error.body.message, 'error');
                });
        }
    }

    handleSearch(event) {
        this.searchKey = event.target.value.toLowerCase(); // Normalize search input
        console.log('searchKey-->', this.searchKey);
        if (this.searchKey) {
            console.log('inside search logic');
            // Filter the tableData based on the searchKey
            this.filteredData = this.tableData.filter(record => {
                return Object.values(record).some(value =>
                    value && String(value).toLowerCase().includes(this.searchKey)
                );
            });
            console.log('filteredData->' + JSON.stringify(this.filteredData));
        } else {
            // Reset to show all records when search is cleared
            this.filteredData = [...this.tableData];
        }

        // Update pagination based on the filtered data
        this.totalRecords = this.filteredData.length;
        this.currentPage = 1; // Reset to the first page
        this.updatePagination();
    }

    //sorting
    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
    let parseData = JSON.parse(JSON.stringify(this.filteredData));

    let keyValue = (a) => {
        return a[fieldname];
    };

    let isReverse = direction === 'asc' ? 1 : -1;

    parseData.sort((x, y) => {
        // Convert both x and y to lowercase for case-insensitive comparison
        x = keyValue(x) ? String(keyValue(x)).toLowerCase() : '';
        y = keyValue(y) ? String(keyValue(y)).toLowerCase() : '';

        return isReverse * ((x > y) - (y > x)); // sorting based on direction
    });

    this.filteredData = parseData;
    this.updatePagination();
    }   

    // generic toast messages method.
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}