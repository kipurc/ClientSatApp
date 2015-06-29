//
//  IBM_DetailViewController.m
//  ClientSat
//
//  Created by Kirsty Purcell on 31/05/2015.
//  Copyright (c) 2015 International Business Machines. All rights reserved.
//

#import "IBM_DetailViewController.h"
#import "IBM_ClientIssueRecord.h"

@interface IBM_DetailViewController() <UITextViewDelegate>

@end

@implementation IBM_DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.IBM_ClientName.text = self.record.name;
    self.IBM_SalesConnect.text = self.record.salesconnect;
    self.IBM_BrandBU.text = self.record.brandBU;
    self.IBM_Status.text = self.record.status;
    self.IBM_ESU.text = self.record.esu;
    self.IBM_CXName.text = self.record.cxname;
    self.IBM_IssueDescription.text = self.record.idescription;
    self.IBM_Actions.text = self.record.actionRecord;
    self.IBM_ClientContact.text = self.record.clientContact;
    self.IBM_BrandOther.text = self.record.buOther;
    self.IBM_BUPersonnel.text = self.record.buPersonnel;
    self.IBM_IssueImpact.text = self.record.issueImpact;
    self.IBM_Resolution.text = self.record.resolution;
    
    [self.IBM_Actions setScrollEnabled:YES];
    [self.IBM_Actions setUserInteractionEnabled:YES];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;  // Hide both keyboard and blinking cursor.
}

@end