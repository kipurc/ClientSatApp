Mobile Cloud Services JavaScript SDK for IBM Bluemix
===

BlueMix supports IBM's MobileFirst strategy by allowing you as a mobile developer to quickly incorporate pre-built, managed, and scalable cloud services into your mobile applications without relying on IT involvement. You can focus on building your mobile applications rather than the complexities of managing the back end infrastructure.

When you create a Mobile Cloud Starter application, BlueMix provisions multiple services under a single application context. Your mobile application is given access to the following mobile services: Mobile Application Security, Push, and Mobile Data.

About
---

The Mobile Cloud Services SDK is a JavaScript SDK you can use inside a Web or Hybrid application.  You can also use the SDK inside a server-side [Node.js](http://nodejs.org) JavaScript module. The SDK manages all the communication and security integration with the Mobile Cloud Services in Bluemix.

##Download

### Node.js

Install the `IBMBluemix` package with the [`npm`](https://www.npmjs.org/) package manager , this will require [`node.js`](http://nodejs.org/download/) to be installed first.

Use the following command to install the SDK:

```bash
npm install ibmbluemix
```

### Web or Hybrid

Install the `IBMBluemix` package with the [`bower`](http://bower.io/) package manager with the following command:

```
bower install https://hub.jazz.net/git/bluemixmobilesdk/ibmbluemix-javascript/.git
```

SDK Getting Started Guide
--

To find out more information about using the SDK, see the
[Mobile Cloud Services SDK Developer Guide](http://mbaas-gettingstarted.ng.bluemix.net/).

Services
--

Each of the services for the JavaScript SDK is in a separate module that you can add to your project individually.

This allows maximum flexibility to the developer to individually pick and choose the services that are key to the application. The JavaScript SDK contains the following services.

- [ibmbluemix](https://hub.jazz.net/project/bluemixmobilesdk/ibmbluemix-javascript/overview)
- [ibmcloudcode](https://hub.jazz.net/project/bluemixmobilesdk/ibmcloudcode-javascript/overview)
- [ibmdata](https://hub.jazz.net/project/bluemixmobilesdk/ibmdata-javascript/overview)
- [ibmpush](https://hub.jazz.net/project/bluemixmobilesdk/ibmpush-javascript/overview)

Each one of these services can be added to your project.
