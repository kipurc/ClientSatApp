BlueList sample app utlizing IBM's MBaaS Services written using Bootstrap and Angular.

Prerequisites
----

Before running the app you must have Node, Grunt, Bower already installed:

- Node - [Install Node](http://nodejs.org/download/)
- Grunt  - [Install Grunt](http://gruntjs.com/getting-started)
- Bower - [Bower](http://bower.io/)


Setting up Project
----

To run the application you'll have to first install the npm and bower packages (this only needs to be done once).

```
git clone https://hub.jazz.net/git/mahuffma/bluelist_web
cd bluelist_web
npm install
bower install
```


Running Application
----

Once the dependencies are brought down, you'll need to update the AppId:

In **<project_home>/app/scripts/app.js** update the `appId` field under the `MBAAS_CONFIG` constant to match your appId. 

Run the following command to view the application:

```
grunt serve
```


Viewing Code
----

This app was scaffolded out using the angular generator for [yeoman](http://yeoman.io/gettingstarted.html). All application contents are in **<project_home>/app**. The javascript source is located in **<project_home>/app/scripts** and the html views are located in **<project_home>/app/views**.

- **IBMBaaS.js** - This is the core component required for any application using the Mobile Services JavaScript SDK. This provides an `IBMBaaS` object that is used to initalize the SDK with your AppID using IBMBaaS.initializeSDK('<APP_ID'>);
- **IBMData.js** - This is the Mobile Data module and provides an `IBMData` object that can be used to perform CRUD operations and queries.
    - Creating an object: `IBMData.Object.ofType("Item", {"name": "Apples"}).save()`
    - Query objects of type 'Item':
    ```
    IBMData.Query.ofType("Item").find().then(
        function(items){
            console.log("items: %o", items)
        }
    );
    ```
- **app.js** - The driver that defines the Angular application. This defines the routes, constants, controllers, and their associated views. 
- **mainctrl.js** - This is the controller that is associated with the main view, located in `app/views/main.html`
- **services.js** - This defines utility functions that can be used across controllers.
