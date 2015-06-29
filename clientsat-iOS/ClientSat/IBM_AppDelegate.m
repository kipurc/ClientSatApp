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

#import <IBMBluemix/IBMBluemix.h>
#import <IBMData/IBMData.h>
#import "IBM_AppDelegate.h"
#import "IBM_TIMERUIApplication.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@implementation IBM_AppDelegate


@synthesize window = _window;
UIViewController *controller;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];

    [Fabric with:@[CrashlyticsKit]];
    
    [self.window makeKeyAndVisible];

    controller = [[UIStoryboard storyboardWithName:@"main" bundle:NULL] instantiateViewControllerWithIdentifier:@"Login"];
    
    NSString *applicationId = nil;
    NSString *applicationSecret = nil;
    NSString *applicationRoute = nil;
    
    BOOL hasValidConfiguration = YES;
    NSString *errorMessage = @"";
    
    // Read the applicationId from the plist.
    NSString *configurationPath = [[NSBundle mainBundle] pathForResource:@"clientsat" ofType:@"plist"];
    if(configurationPath){
        NSDictionary *configuration = [[NSDictionary alloc] initWithContentsOfFile:configurationPath];
        applicationId = [configuration objectForKey:@"applicationId"];
        if(!applicationId || [applicationId isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the clientsat.plist and set the applicationId to the Bluemix applicationId";
        }
        applicationSecret = [configuration objectForKey:@"applicationSecret"];
        if(!applicationSecret || [applicationSecret isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the clientsat.plist and set the applicationSecret with your Bluemix application's secret";
        }
        applicationRoute = [configuration objectForKey:@"applicationRoute"];
        if(!applicationRoute || [applicationRoute isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the clientsat.plist and set the applicationRoute to the Bluemix application's route";
        }
    }
    if(hasValidConfiguration){
        // Initialize the SDK and Bluemix services
        [IBMBluemix initializeWithApplicationId:applicationId  andApplicationSecret:applicationSecret andApplicationRoute:applicationRoute];
        [IBMData initializeService];
    }else{
        [NSException raise:@"InvalidApplicationConfiguration" format: @"%@", errorMessage];
    }
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([activeController isKindOfClass:[UINavigationController class]]) {
        activeController = [(UINavigationController*) activeController visibleViewController];
    }
    [activeController presentViewController:controller animated:YES completion:nil];
}


-(void)applicationDidTimeout:(NSNotification *) notif
{
    NSLog (@"time exceeded!!");    
    UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([activeController isKindOfClass:[UINavigationController class]]) {
        activeController = [(UINavigationController*) activeController visibleViewController];
    }
    [activeController presentViewController:controller animated:YES completion:nil];
}


@end
