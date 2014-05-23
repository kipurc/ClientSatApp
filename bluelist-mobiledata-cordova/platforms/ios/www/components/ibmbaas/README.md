Mobile Cloud Services JavaScript SDK for IBM Bluemix
===

BlueMix supports IBM's MobileFirst strategy by allowing you as a mobile developer to quickly incorporate pre-built, managed, and scalable cloud services into your mobile applications without relying on IT involvement. You can focus on building your mobile applications rather than the complexities of managing the back end infrastructure.

When you create a Mobile Cloud Starter application, BlueMix provisions multiple services under a single application context. Your mobile application is given access to the following mobile services: Mobile Application Security, Push, and Mobile Data.

About
---

The Mobile Cloud Services SDK is a JavaScript SDK you can use inside a Web or Hybrid application.  You can also use the SDK inside a server-side [Node.js](http://nodejs.org) JavaScript module. The SDK manages all the communication and security integration with the Mobile Cloud Services in Bluemix.

##Download

### Node.js

Install the `ibmbaas` package with the [`npm`](https://www.npmjs.org/) package manager , this will require [`node.js`](http://nodejs.org/download/) to be installed first.

Use the following command to install the SDK:

```
npm install ibmbaas
```

### Web or Hybrid

Install the `ibmbaas` package with the [`bower`](http://bower.io/) package manager with the following command:

```
bower install https://hub.jazz.net/git/mobilec/ibmbaas/.git
```

## Loading

After the SDK is installed, you can use the SDK within your app.

### Node.js
```javascript
var ibmbaas = require('ibmbaas')
```

### Web or Hybrid

If you want to load the SDK in a Web or Hybrid application, you can reference your bower component with a `<script>` tag. When the SDK is loaded this way, a global namespace called `IBMBaaS` is created.


```javascript
<script src="www/components/ibmbaas/js/IBMBaaS.min.js"></script>
```

### RequireJS

You can also use the SDK within a [RequireJS](http://requirejs.org) app.

```javascript
<script src="www/components/requirejs/requirejs.js"></script>

<script>
    require.config({
        baseUrl: ".",
        paths: {
            ibmbaas: 'www/components/ibmbaas/IBMBaaS'
        }
    });
</script>
```

## Initializing

You need to initialize the SDK before you can use it.

### Node.js

```
var ibmbaas = require('ibmbaas');
ibmbaas.initializeSDK('1c3379ce-9ebb-4b91-8f82-434fef078f9e')

var appId = ibmbaas.getApplicationId()
```

### Web or Hybrid

Initialize with the static approach:
```javascript
IBMBaas.initializeSDK(applicationId);
var appId = IBMBaaS.getApplicationId();
```

Initialize with an asynchronous module definition [(AMD)](http://en.wikipedia.org/wiki/Asynchronous_module_definition) approach:

```javascript
require(["ibmbaas"],
    function(ibmbaas) {
        ibmbaas.initializeSDK('1c3379ce-9ebb-4b91-8f82-434fef078f9e');
        var appId = ibmbaas.getApplicationId();

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
