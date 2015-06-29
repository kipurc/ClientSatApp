//
//  IBM_TIMERUIApplication.h
//  ClientSat
//
//  Created by Kirsty Purcell on 26/06/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import <Foundation/Foundation.h>

//the length of time before your application "times out". This number actually represents seconds, so we'll have to multiple it by 60 in the .m file
#define kApplicationTimeoutInMinutes 2

//the notification your AppDelegate needs to watch for in order to know that it has indeed "timed out"
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface TIMERUIApplication : UIApplication
{
    NSTimer     *myidleTimer;
}

-(void)resetIdleTimer;

@end