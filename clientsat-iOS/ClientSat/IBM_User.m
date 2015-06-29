//
//  IBM_User.m
//  ClientSat
//
//  Created by Kirsty Purcell on 17/06/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import "IBM_User.h"

@implementation IBM_User

@dynamic uid;
@dynamic name;
@dynamic password;

+(void) initialize
{
    [self registerSpecialization];
}

+(NSString*) dataClassName
{
    return @"IBM User";
}

@end
