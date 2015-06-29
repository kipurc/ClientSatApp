Client Sat Application
===
The Client Satisfaction Tracher is designed to assis E&MM sellers and management to track progress on their client satisfaction issues. It's a native iOS application and the back-end functionality is hosted on BlueMix.

Creating the Mobile Cloud boilerplate application
---
1. Login to [IBM Bluemix](https://www.bluemix.net)
2. Click 'Catalog' or 'Create An App'
3. Under Boilerplates, select Mobile Cloud.
4. Enter in App Info & select 'Create'
5. You now have a mobile cloud backend, providing you with some mobile services on the cloud!

Downloading the Dependencies
---

You can now download the dependencies for this sample using cocoapods!
This will enable you to skip the SDK download instructions in the article below.

First, install CocoaPods using the following command:

      sudo gem install cocoapods

Next, go to the folder containing clientsat-iOS.  Then, install the
dependencies listed in your podfile using the following command:

      pod install

Keep in mind that when using cocoapods, you must use the app's .xcworkspace file, and not
the .xcodeproj file.  This file will be generated on pod install.


