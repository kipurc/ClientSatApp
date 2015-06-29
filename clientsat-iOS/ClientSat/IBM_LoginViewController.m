//
//  IBM_ViewController.m
//
//  Created by Kirsty Purcell on 22/05/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import "IBM_LoginViewController.h"
#import "IBM_User.h"
#import "IBM_AppDelegate.h"
#import "RNEncryptor.h"

@interface IBM_LoginViewController ()

@end

@implementation IBM_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPress:(id)sender {

    [self.activityIndicator startAnimating];
    NSString *username = _txtUsername.text;
    
    NSString* salt = [@"com.ibm.clientsatapp" stringByAppendingString:username];
    NSData* data = [salt dataUsingEncoding:NSUTF8StringEncoding];
    NSData* key = [RNCryptor keyForPassword:_txtPassword.text salt:data settings:kRNCryptorAES256Settings.keySettings];
   
    IBMQuery *qry = [IBM_User query];
    [qry whereKey:@"uid" equalTo:username];
    [qry whereKey:@"password" equalTo:key];
    
    [[qry find] continueWithBlock:^id(BFTask *task) {
        NSArray *result = task.result;
        if(task.error) {
            NSLog(@"listItems failed with error: %@", task.error);
        } else {
            if ([result count] == 0) {
                //Failed
                [self.activityIndicator stopAnimating];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Login"
                                                                    message:@"Invalid Username/Password. Try again. If you have not registered your details, contact an admin."
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [alertView show];
            } else if ([username isEqualToString:@"clientsatadmin@au1.ibm.com"]) {
                [self.activityIndicator stopAnimating];
                [self performSegueWithIdentifier:@"admin_success" sender:self];
            } else {
                IBM_User *user = (IBM_User*) result[0];
                IBM_AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                appDelegate.user = user.name;
                appDelegate.uid = user.uid;
                [self performSegueWithIdentifier:@"login_success" sender:self];

            }
        }
        return nil;
    }];
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end