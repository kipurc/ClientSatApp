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

#import "IBM_PushDelegate.h"

#define DEVICE_ALREADY_REGISTERED @"FPWSE0002E"

// Constants used in Push device.  You may change these are dynamically create them.
#define CONSUMER_ID @"MBaaSListApp"
#define DEVICE_ALIAS  @"TargetDevice"


@implementation IBM_PushDelegate

-(id) initWithDeviceToken:(NSString *)deviceToken
{
    self = [super init];
    if(self){
        if(deviceToken && ![deviceToken isEqualToString:@""]){
            _deviceToken = [NSString stringWithString:deviceToken];
        }else{
            [NSException raise:@"InvalidPushDeviceToken" format:@"Device token was nil"];
        }
    }
    return self;
}

-(void) onSuccess :(NSMutableDictionary*) response
{
    NSLog(@"onSuccess: %@", response);
}

-(void) onFailure :(NSMutableDictionary*) response
{
    if(![[response objectForKey:@"code"] isEqualToString: DEVICE_ALREADY_REGISTERED]){
        // We ignore device already registered errors as this is expected on the second call
        NSLog(@"onFailure: %@", response);
    }
}

-(void) registerDevice
{
    
    // Register Device to receive Push Notifications
    IBMPush *pushService = [IBMPush service];
    
    // Call the push service to register the device and listener
    [pushService registerDevice:DEVICE_ALIAS withConsumerId:CONSUMER_ID withDeviceToken:self.deviceToken withDelegate:self];
}

@end
