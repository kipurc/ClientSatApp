Sample: bluelist-mobiledata-web
===
The bluelist-mobiledata-web sample demonstrates the BlueList sample app utilizing IBM's MBaaS Services written using Bootstrap and Angular.

This sample works with the Mobile Cloud, an application boilerplate that is available on [IBM Bluemix](https://www.ng.bluemix.net).  With this boilerplate, you can quickly incorporate pre-built, managed, and scalable cloud services into your mobile applications without relying on IT involvement. You can focus on building your mobile applications rather than the complexities of managing the back end infrastructure.

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

Once the dependencies are installed, you will need to update the Application Id value.

In **<project_home>/app/scripts/app.js** update the `appId` field under the `MBAAS_CONFIG` constant to match your Bluemix Application Id.

Run the following command to view the application:

```
grunt serve
```


Viewing Code
----

This app was scaffolded out using the angular generator for [yeoman](http://yeoman.io/gettingstarted.html). All application contents are in **<project_home>/app**. The JavaScript source is located in **<project_home>/app/scripts** and the html views are located in **<project_home>/app/views**.

- **IBMBaaS.js** - This is the core component required for any application using the Mobile Services JavaScript SDK. This provides an `IBMBaaS` object that is used to initialize the SDK with your AppID using IBMBaaS.initializeSDK('<APP_ID'>);
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
