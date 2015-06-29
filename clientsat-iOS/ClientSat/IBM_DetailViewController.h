//
//  IBM_DetailViewController.h
//  ClientSat
//
//  Created by Kirsty Purcell on 31/05/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBM_ClientIssueRecord;

@interface IBM_DetailViewController : UIViewController
@property (nonatomic) IBM_ClientIssueRecord *record;
@property (weak, nonatomic) IBOutlet UITextField *IBM_ClientName;
@property (weak, nonatomic) IBOutlet UITextField *IBM_SalesConnect;
@property (weak, nonatomic) IBOutlet UITextField *IBM_BrandBU;
@property (weak, nonatomic) IBOutlet UITextField *IBM_CXName;
@property (weak, nonatomic) IBOutlet UITextField *IBM_IssueDescription;
@property (weak, nonatomic) IBOutlet UITextView *IBM_Actions;
@property (weak, nonatomic) IBOutlet UITextField *IBM_Status;
@property (weak, nonatomic) IBOutlet UITextField *IBM_ClientContact;
@property (weak, nonatomic) IBOutlet UITextField *IBM_ESU;
@property (weak, nonatomic) IBOutlet UITextField *IBM_BrandOther;
@property (weak, nonatomic) IBOutlet UITextField *IBM_BUPersonnel;
@property (weak, nonatomic) IBOutlet UITextField *IBM_IssueImpact;
@property (weak, nonatomic) IBOutlet UITextView *IBM_Resolution;


@end
