//
//  IBM_AdminViewController.h
//  ClientSat
//
//  Created by Kirsty Purcell on 23/06/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBM_AdminViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *userActivity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *passwordActivity;
@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *changePassword;
- (IBAction)changePassword:(id)sender;
- (IBAction)addUser:(id)sender;
- (IBAction)deleteUser:(id)sender;

@end
