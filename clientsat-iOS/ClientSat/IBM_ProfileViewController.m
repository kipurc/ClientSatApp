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


#import "IBM_ProfileViewController.h"
#import "IBM_AppDelegate.h"
#import "IBM_User.h"
#import "RNEncryptor.h"

@interface IBM_ProfileViewController ()

@property (nonatomic) IBM_AppDelegate *applicationDelegate;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *changePassword;

@end

@implementation IBM_ProfileViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self populateProfileContent];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self populateProfileContent];
}

-(void) populateProfileContent
{
    self.applicationDelegate = [[UIApplication sharedApplication] delegate];
    self.displayName.text = self.applicationDelegate.user;
    self.emailAddress.text = self.applicationDelegate.uid;
}

- (IBAction)changePassword:(id)sender {
    [self.passwordActivity startAnimating];
    
    if (_changePassword.text.length < 8) {
        [self.passwordActivity stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Password"
                                                            message:@"Password must be at least 8 characters."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

    }
    
    IBMQuery *qry = [IBM_User query];
    NSString *uid = self.applicationDelegate.uid;
    [qry whereKey:@"uid" equalTo:uid];
    
    [[qry find] continueWithBlock:^id(BFTask *task) {
        NSArray *result = task.result;
        if(task.error) {
            NSLog(@"listItems failed with error: %@", task.error);
        } else {
            IBM_User *user = (IBM_User*) result[0];
            NSString* salt = [@"com.ibm.clientsatapp" stringByAppendingString:uid];
            NSData* data = [salt dataUsingEncoding:NSUTF8StringEncoding];
            NSData* key = [RNCryptor keyForPassword:_changePassword.text salt:data settings:kRNCryptorAES256Settings.keySettings];
            user.password = key;
                
            [[user save] continueWithBlock:^id(BFTask *task) {
                    if(task.error) {
                        NSLog(@"updateItem failed with error: %@", task.error);
                    }
                    else {
                        [self.passwordActivity stopAnimating];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                            message:@"Password Changed."
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                    return nil;
                }];
            }
        return nil;
    }];

    
}
@end
