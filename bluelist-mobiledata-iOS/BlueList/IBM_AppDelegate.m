//-------------------------------------------------------------------------------
// Copyright 2014 IBM Corp. All Rights Reserved
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//-------------------------------------------------------------------------------

#import "IBM_AppDelegate.h"
#import <IBMBaaS/IBMBaaS.h>
#import <IBMData/IBMData.h>
#import <IBMCloudCode/IBMCloudCode.h>
#import <IBMPush/IBMPush.h>
#import "IBM_PushDelegate.h"

@interface IBM_AppDelegate ()

@property IBM_PushDelegate *pushDelegate;

@end

@implementation IBM_AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSString *applicationId = nil;
    NSString *hostName = nil;
    
    BOOL hasValidConfiguration = YES;
    NSString *errorMessage = @"";
    
    // Read the applicationId and applicationHostName from the configuration.plist.
    NSString *configurationPath = [[NSBundle mainBundle] pathForResource:@"configuration" ofType:@"plist"];
    if(configurationPath){
        NSDictionary *configuration = [[NSDictionary alloc] initWithContentsOfFile:configurationPath];
        applicationId = [configuration objectForKey:@"applicationId"];
        if(!applicationId || [applicationId isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the configuration.plist and set the applicationId to the BlueMix applicationId";
        }

        hostName = [configuration objectForKey:@"hostName"];
        if(!hostName || [hostName isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the configuration.plist and set the hostName to the BlueMix application name";
        }
    }
    
    if(hasValidConfiguration){
        // Initialize the SDK and BlueMix services
        [IBMBaaS initializeSDK: applicationId];
        [IBMData initializeService];
        [IBMCloudCode initializeService:hostName];
        [IBMPush initializeService];
        
        // Register application for push notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }else{
        [NSException raise:@"InvalidApplicationConfiguration" format: @"%@", errorMessage];
    }
    

    return YES;
}

#pragma mark - Methods for receiving device registration and notifications
-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.pushDelegate = [[IBM_PushDelegate alloc]initWithDeviceToken:deviceToken.description];
    [self.pushDelegate registerDevice];
}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // Handle remote Push notification by reloading the list and getting the latest data
    NSLog(@"Received Push Notification, updating list");
    [self.listViewController listItems: nil];
}

@end
