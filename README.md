# IRIS Softwrae Project:

In this project i have created a LWC to fetch all the accounts in a data table using Apex. Features:
1. The columns are not hard coded for the table there is a custom metadata setting that controls the columns to show bassed on **API names of fields** in a comma seperation **no space should be given** for example you can use Name,Industry,AnnualRevenue,Rating.
2. Pagination on the data is done with navigation buttons and rcords count
3. search can be done on the table
4. Inline edit could be done and records could be edited on the table.
5. Sorting of columns is implemented.

# How to Deploy

1. This repo has only one branch named feature/AccountDataTable.
2. In your VS code set this as a active branch and set a default org in which you want to deploy it.
3. Once the above step is done navigate to package.xml file which resides inside manifest folder
4. right click on the file and click **Deploy This Source to Org**
5. Deployment SHould be done

If you do not use VS code you can simply deploy manually by finding files in the **/force-app** folder either via workbench or any other tool that you are comfortable with.

**List of components**
**Apex** AccountsDataTableController.cls
**LWC** accountsDataTable
**objects** Accounts_Data_Table_Fields__mdt.object-meta.xml
**Lightning Tab** Iris_Accounts_Table.tab-meta.xml

**IMPORTANT** Post deployment, The Tab Deployed is by default hidden please enable its visibility at profile level under the **Custom Tab Settings**. The Tab name is **Iris Accounts Table**

Once done simply click on the Waffle/App Drawer on the top left corner and type the tab name and it should show the table.



