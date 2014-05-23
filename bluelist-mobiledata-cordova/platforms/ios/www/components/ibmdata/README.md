Mobile Data service SDK for IBM Bluemix
===

BlueMix supports IBM's MobileFirst strategy by allowing you as a mobile developer to quickly incorporate pre-built, managed, and scalable cloud services into your mobile applications without relying on IT involvement. You can focus on building your mobile applications rather than the complexities of managing the back end infrastructure.

When you create a Mobile Cloud Starter application, BlueMix provisions multiple services under a single application context. Your mobile application is given access to the following mobile services: Mobile Application Security, Push, and Mobile Data.

About
---

The Data Service SDK is a JavaScript SDK you can use inside a Web or Hybrid application.  You can also use the SDK inside a server-side [Node.js](http://nodejs.org) JavaScript module. The SDK manages all the communication and security integration with the Mobile Cloud Services in Bluemix.

## Download

### Node.js

Install the `ibmdata` package with the [`npm`](https://www.npmjs.org/) package manager , this will require [`node.js`](http://nodejs.org/download/) to be installed first.

Use the following command to install the SDK:

```bsd
npm install ibmdata
```

### Web or Hybrid

Install the `ibmdata` package with the [`bower`](http://bower.io/) package manager with the following command:

```
bower install https://hub.jazz.net/git/mobilec/ibmdata/.git
```

## Loading

After the SDK is installed, you can use the SDK within your app.

### Node.js
```javascript
var ibmdata = require('ibmdata')
```

### Web or Hybrid

If you want to load the SDK in a Web or Hybrid application, you can reference your bower component with a `<script>` tag. When the SDK is loaded this way, a global namespace called `IBMData` is created.


```html
<script src="www/components/ibmdata/js/IBMData.min.js"></script>
```

### RequireJS

You can also use the SDK within a [RequireJS](http://requirejs.org) app.

```html
<script src="www/components/requirejs/requirejs.js"></script>

<script>
    require.config({
        baseUrl: ".",
        paths: {
            ibmdata: 'www/components/ibmdata/IBMData'
        }
    });
</script>
```

## Initializing

You need to initialize the SDK before you can use it.

### Node.js

```javascript
// Initilize the main SDK and the supporting service.
var ibmdata = require('ibmdata');
var data = ibmdata.initializeService();
```

### Web or Hybrid app

Initialize with the static approach:
```javascript
IBMData.initializeService();
var listItem = IBMData.Object.ofType("listItem", {name: "Apples", quantity: 10});
```

Initialize with an asynchronous module definition [(AMD)](http://en.wikipedia.org/wiki/Asynchronous_module_definition) approach:

```javascript
<script>
    require(["ibmdata"],
        function(ibmdata) {
			ibmdata.initializeService();

			var listItem = ibmdata.Object.ofType("listItem", {name: "Apples", quantity: 10});

        });
    });
</script>
```

Using
---
You can start using Mobile Data service SDK for IBM Bluemix to persit your data in the Mobile Data service.

```javascript
// Create a new save a new item
var item = data.Object.ofType("Item", {name: "Apples", quantity: 10});
item.save.then(function(savedItem){
  console.log("Item Saved:"+JSON.stringify(savedItem));
});

// Retrieve all the items
var query = data.Query.ofType("Item");
query.find().done(function(items) {
    items.forEach(function(item) {
        //Print out each person
        console.log("Item:"+JSON.stringify(item))
    });
});
```

Services
--

Each of the services for the JavaScript SDK is in a separate module that you can add to your project individually.

This allows maximum flexibility to the developer to individually pick and choose the services that are key to the application. The JavaScript SDK contains the following services.

- [ibmcloudcode](https://hub.jazz.net/project/mobilec/ibmcloudcode/overview)
- [ibmdata](https://hub.jazz.net/project/mobilec/ibmdata/overview)
- [ibmpush](https://hub.jazz.net/project/mobilec/ibmpush/overview)

Each one of these services can be added to your project.

SDK Developer Guide
--

To find out more information about using the SDK, see the
[Mobile Cloud Services SDK Developer Guide](http://mbaas-gettingstarted.ng.bluemix.net/).
