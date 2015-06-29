//
//  IBM_ViewController.h
//
//  Created by Kirsty Purcell on 22/05/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBM_LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)loginPress:(id)sender;

- (IBAction)backgroundTap:(id)sender;

@end
