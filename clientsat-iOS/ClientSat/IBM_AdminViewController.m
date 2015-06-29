//
//  IBM_AdminViewController.m
//  ClientSat
//
//  Created by Kirsty Purcell on 23/06/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import "IBM_AdminViewController.h"
#import "IBM_User.h"
#import "IBM_AppDelegate.h"
#import "RNEncryptor.h"

@interface IBM_AdminViewController ()

@end

@implementation IBM_AdminViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    NSString* uid = @"clientsatadmin@au1.ibm.com";
    [qry whereKey:@"uid" equalTo:uid];
    
    [[qry find] continueWithBlock:^id(BFTask *task) {
        NSArray *result = task.result;
        if(task.error) {
            NSLog(@"changePassword failed with error: %@", task.error);
        } else {
            IBM_User *user = (IBM_User*) result[0];
            NSString* salt = [@"com.ibm.clientsatapp" stringByAppendingString:uid];
            NSData* data = [salt dataUsingEncoding:NSUTF8StringEncoding];
            NSData* key = [RNCryptor keyForPassword:_changePassword.text salt:data settings:kRNCryptorAES256Settings.keySettings];
            
            user.password = key;
            
            [[user save] continueWithBlock:^id(BFTask *task) {
                if(task.error) {
                    NSLog(@"changePassword failed with error: %@", task.error);
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

- (IBAction)addUser:(id)sender {
    [self.userActivity startAnimating];
    NSString *username = _txtUsername.text;
    NSString *fullname = _fullName.text;
    
    if (username.length < 12 || fullname.length == 0){
        [self.userActivity stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid"
                                                            message:@"Must complete all fields."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    if (_txtPassword.text.length < 8) {
        [self.userActivity stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Password"
                                                            message:@"Password must be at least 8 characters."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    
    IBMQuery *qry = [IBM_User query];
    [qry whereKey:@"uid" equalTo:username];
    
    [[qry find] continueWithBlock:^id(BFTask *task) {
        if(task.error) {
            [self showError];
        } else if([(NSArray*) task.result count] == 0){
            IBM_User *user = [[IBM_User alloc] init];
            user.uid = username;
            user.name = fullname;
            [self addOrUpdateUser:user];
        } else {
            IBM_User *user = task.result[0];
            user.uid = username;
            user.name = fullname;
            [self addOrUpdateUser:user];
            [self.userActivity stopAnimating];
        }
        return nil;
    }];

}

-(void) addOrUpdateUser:(IBM_User*) user {
    NSString* salt = [@"com.ibm.clientsatapp" stringByAppendingString:user.uid];
    NSData* data = [salt dataUsingEncoding:NSUTF8StringEncoding];
    NSData* key = [RNCryptor keyForPassword:_txtPassword.text salt:data settings:kRNCryptorAES256Settings.keySettings];
    
    user.password = key;
    
    
    [[user save] continueWithBlock:^id(BFTask *task) {
        if(task.error) {
            [self showError];
        }
        else {
            [self.userActivity stopAnimating];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                message:@"User Added."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
        return nil;
    }];

}

- (IBAction)deleteUser:(id)sender {
    [self.userActivity startAnimating];
    NSString* username = _txtUsername.text;
    
    IBMQuery *qry = [IBM_User query];
    [qry whereKey:@"uid" equalTo:username];
    
    [[qry find] continueWithBlock:^id(BFTask *task) {
        NSArray *result = task.result;
        if(task.error) {
            [self.userActivity stopAnimating];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"User not found."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            IBM_User *user = (IBM_User*) result[0];
            
            [[user delete] continueWithBlock:^id(BFTask *task) {
                if(task.error) {
                    NSLog(@"deleteUser failed with error: %@", task.error);
                }
                else {
                    [self.userActivity stopAnimating];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                        message:@"User Deleted."
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

-(void) showError {
    [self.userActivity stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                        message:@"Task failed, try again later."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];

}
@end