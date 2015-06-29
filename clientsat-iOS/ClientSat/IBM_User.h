//
//  IBM_User.h
//  ClientSat
//
//  Created by Kirsty Purcell on 17/06/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IBMData/IBMData.h>

@interface IBM_User : IBMDataObject <IBMDataObjectSpecialization>

@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSData *password;


@end
