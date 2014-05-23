Sample: bluelist-cordova
===

The bluelist-cordova sample demonstrates how the bluelist app can be written using the hybrid development approach, building the user experience with HTML5, CSS3 technologies and running them inside a Cordova application shim.

This sample works with the Mobile Backend Starter, an application boilerplate that is available on [Codename: Bluemix](https://www.ng.bluemix.net). With this boilerplate, you can quickly incorporate pre-built, managed, and scalable cloud services into your mobile applications without relying on IT involvement. You can focus on building your mobile applications rather than the complexities of managing the back end infrastructure.

This sample uses [Cordova](http://cordova.apache.org/) to manage the native Mobile experience, within Cordova the [Ionicframework](https://ionicframework.com) is used for the mobile user experience and the  [AngularJS](https://angularjs.org/) as the controller framework. The app uses the Mobile Cloud Data Service SDK for JavaScript to manage the CRUD (Create, Read, Update and Delete) operations. This enable the storage of data in the cloud and that is backed by  [Cloudant](https://cloudant.com/).

Downloading this sample
---

You can clone this sample from DevOps with the following command:

    git clone https://hub.jazz.net/git/mobilecloud/bluelist-cordova


Prerequisite's
---
Before you can run the sample you need to install the prerequirsite software components.

Download and install the node.js runtime from http://nodejs.org/

Then install `cordova`
```bash
npm install -g cordova
```

Then install `ionic` utility.

```bash
$ npm install -g ionic
```

Then install `bower` utility.

```bash
$ npm install -g bower
```

Running this sample
---

To help with your setup we strongly recommend working through the following Platform guides.
- [Cordova Getting Started Guide for IOS](http://cordova.apache.org/docs/en/3.3.0/guide_platforms_ios_index.md.html#iOS%20Platform%20Guide)
- [Cordova Getting Started Guide for Android](http://cordova.apache.org/docs/en/3.3.0/guide_platforms_android_index.md.html#Android%20Platform%20Guide)

To test the app you need to have created a Mobile Cloud Boilerplate application with [Codename:Bluemix](http://bluemix.net) and you need to make a note of your application id.

### Configuration

To run the app locally you need to first modify the ```www/bluelist.json``` with your corresponding application id.

```json
{
  "applicationId"    : "APPLICATIONID"
}

```
### Testing the Sample
Modern mobile web applications are now built using dependency managers. The hybrid application sample uses   ```bower``` for the client side  components. This includes the pulling down of the latest levels of the Mobile Cloud SDKs from [Mobile Cloud SDKs](https://hub.jazz.net/user/mobilec)

1. From the sample app directory, run ```bower install```
2. To check the development runtime, make sure all existing copies of chrome have been shutdown.
3. Load chrome with web security turned off, this enables the mobile testing to avoid any Cross Origin.

_Mac_
```bash
open -a Google\ Chrome --args --disable-web-security
```
_Windows_
```bash
start chrome.exe --disable-web-security
```
3. From the app directory, run ```ionic serve```
4. The hybrid component should now be visible in chrome browser. The ionic tools support live reload, so if you edit the code you can see if refresh in the browser.
5. The sample app can be accessed using this local url. http://localhost:8100/#/tab/list

### Running in Emulator

You need to make sure you have the latest `xcode` and `android` development tools installed on your development environment.

1. From the sample app directory run the following command to build the sample for `ios`.
```bash
ionic build ios
```
2. To run it in the emulator you can run `emulate` command.
```bash
ionc emulate ios
```
3. You should now see the `bluelist-cordova` app now running inside the IOS Simulator.

> Notes.  
 - You can delete and edit items in a list by swiping the list item to the left. This reveals the options `delete` and `edit` options.
 - If you want to test with Android make sure you add the android platform to the project.
```bash
cordova platform add android
```  
