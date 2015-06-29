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

#import <UIKit/UIKit.h>
@class IBM_ClientIssueRecord;

@interface IBM_CreateEditItemViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

// The item to be added/edited
@property (nonatomic) IBM_ClientIssueRecord *record;
@property (weak, nonatomic) IBOutlet UITextField *IBM_ClientName;
@property (weak, nonatomic) IBOutlet UITextField*IBM_SalesConnect;
@property (weak, nonatomic) IBOutlet UITextField *IBM_BrandTextField;
@property (weak, nonatomic) IBOutlet UITextField *IBM_CXTextField;
@property (weak, nonatomic) IBOutlet UITextField *IBM_StatusTextField;
@property (weak, nonatomic) IBOutlet UITextField *IBM_ESUTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *IBM_BrandBU;
@property (weak, nonatomic) IBOutlet UIPickerView *IBM_CXName;
@property (weak, nonatomic) IBOutlet UITextField *IBM_Issue;
@property (weak, nonatomic) IBOutlet UITextField *IBM_Actions;
@property (weak, nonatomic) IBOutlet UIPickerView *IBM_Status;
@property (weak, nonatomic) IBOutlet UITextField *IBM_ClientContact;
@property (weak, nonatomic) IBOutlet UIPickerView *IBM_ESU;
@property (weak, nonatomic) IBOutlet UITextField *IBM_OtherBrand;
@property (weak, nonatomic) IBOutlet UITextField *IBM_BUPersonnel;
@property (weak, nonatomic) IBOutlet UITextField *IBM_IssueImpact;
@property (weak, nonatomic) IBOutlet UITextField *IBM_Resolution;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)backgroundTap:(id)sender;
- (void)addAction:(NSString*) action;


@end 
