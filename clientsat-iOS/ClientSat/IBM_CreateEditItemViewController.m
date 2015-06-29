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

#import "IBM_CreateEditItemViewController.h"
#import "IBM_ClientIssueRecord.h"
#import "IBM_AppDelegate.h"

@interface IBM_CreateEditItemViewController () <UITextFieldDelegate, UIPickerViewDelegate>

// IBOutlets from View
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property NSArray *brandBUData;
@property NSArray *esu;
@property NSArray *cxName;
@property NSArray *status;

-(void) addAction: (NSString *) action;

@end

@implementation IBM_CreateEditItemViewController

#pragma mark - View initialization
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize Data
    _brandBUData = @[@"", @"List Systems SW", @"Systems HW", @"GBS Consulting", @"GBS AMS", @"GTS SO", @"GTS ITS", @"GTS TSS", @"Cloud SW", @"Cloud Services", @"Buisness Analytics", @"Social", @"Commerce", @"Watson", @"Security", @"IGF"];
    _status = @[@"", @"Open", @"Closed"];
    _cxName = @[@"Amy Chhour/Australia/Contr/IBM", @"Amy Zammit/Australia/IBM", @"Audrey Rangel/Australia/IBM", @"Ben Teague/New Zealand/IBM", @"Bob Morton/Australia/IBM", @"Brett Ling/Australia/IBM", @"Brian Silver/Australia/IBM", @"Bridget Luke/Australia/IBM", @"Catherine Gullo/Australia/IBM", @"Chek Kiu Chan/Australia/Contr/IBM", @"Chloe Hayes/Australia/IBM", @"Chris Foster/New Zealand/IBM", @"Christian Jones/New Zealand/IBM", @"Chrystie Klein/Australia/IBM", @"Ciaran Ivory/Australia/IBM", @"Courtney Howe/Australia/Contr/IBM", @"Damandeep Mongia/Australia/IBM", @"Dane Gambrill/Australia/IBM", @"Daniel Skirving/Australia/IBM", @"Daryl Fowles/New Zealand/IBM", @"David Worth/New Zealand/IBM", @"Dean Hughes/New Zealand/IBM", @"Dean King/Australia/IBM", @"Deborah Helleur/Australia/IBM", @"Di Morton/Australia/IBM", @"Garry D'Orazio/Australia/IBM", @"Gloria Gao/Australia/Contr/IBM", @"Gordon Miles/Australia/IBM", @"Graeme P Muddle/Australia/IBM", @"Haidee Kozman/Australia/IBM", @"Ingrid van Uden/Australia/IBM", @"James Delooze/Australia/IBM", @"Jason Pradun/Australia/IBM", @"Jeffrey Klinge/Australia/IBM", @"Jo Northey/Australia/IBM", @"John Twine/Australia/IBM", @"Kelly Bilton/Australia/IBM", @"Kim Moleta/New Zealand/IBM", @"Kirsty M Simpson/Australia/IBM", @"Lay Chin Wan/New Zealand/IBM", @"Leanne McLennan/Australia/IBM", @"Lisa Umlauff/Australia/IBM", @"Lori-Lee Walker/Australia/IBM", @"Lucas Neira Sarmiento/Australia/IBM", @"Lynda Bartlett/Australia/IBM", @"Lynn S Currie/Australia/IBM", @"Maciek Kiernikowski/Australia/IBM", @"Malcolm De Silva/Australia/IBM", @"Mark D Osborne/Australia/IBM", @"Mark Hayden/New Zealand/IBM", @"Mark Rugless/Australia/IBM", @"Marleese Attilakos/Australia/IBM", @"Matthew Finch/Australia/IBM", @"Mesut Barkoren/Australia/IBM", @"Michael Kinnane/Australia/IBM", @"Michele Adams/New Zealand/IBM", @"Michelle Romanin/Australia/IBM", @"Nancy Mendez/Australia/IBM", @"Norika Miles/Australia/IBM", @"Pat Cullen/New Zealand/IBM", @"Patricia Caris Silk/Australia/IBM", @"Rachael Franklin/Australia/IBM", @"Rashad Evans/Australia/IBM", @"Robyn C Nott/Australia/IBM", @"Roula Psomiadis/Australia/IBM", @"Ruban Stephens/Australia/IBM", @"Rupina Menzagopian1/Australia/IBM", @"Sally Zhou/Australia/Contr/IBM", @"Sam Raffaele/Australia/IBM", @"Samanali Polwatte Gallage/Australia/IBM", @"Samantha Karpin/Australia/IBM", @"Scot Rogers/Australia/IBM", @"Scott Cowans/Australia/IBM", @"Sharon Hinde/New Zealand/IBM", @"Simon Groves/Australia/IBM", @"Stewart McDonald/Australia/IBM", @"Tania Jollie/Australia/IBM", @"Vanessa Boyer/Australia/IBM", @"Veronica Fryga/Australia/IBM", @"Vicki Blackwell/Australia/IBM", @"Vinod Dhingra/India/IBM"];
    _esu = @[@"", @"QLD", @"WA", @"SA",@"VIC",@"NZ", @"NSW1", @"NSW2", @"MM"];
    
    _IBM_BrandBU.delegate = self;
    _IBM_Status.delegate = self;
    _IBM_ESU.delegate = self;
    _IBM_CXName.delegate = self;
    
    // is edit so initialize the text field with the item title
    if(self.record){
        self.IBM_ClientName.text = self.record.name;
        self.IBM_SalesConnect.text = self.record.salesconnect;
        self.IBM_BrandTextField.text = self.record.brandBU;
        self.IBM_StatusTextField.text = self.record.status;
        self.IBM_ESUTextField.text = self.record.esu;
        self.IBM_CXTextField.text = self.record.cxname;
        self.IBM_Issue.text = self.record.idescription;
        self.IBM_ClientContact.text = self.record.clientContact;
        self.IBM_OtherBrand.text = self.record.buOther;
        self.IBM_BUPersonnel.text = self.record.buPersonnel;
        self.IBM_IssueImpact.text = self.record.issueImpact;
        self.IBM_Resolution.text = self.record.resolution;
    }
    
    //Initialise text fields
    [self.IBM_ClientName becomeFirstResponder];
    [self.IBM_ClientName setDelegate:self];
    [self.IBM_SalesConnect becomeFirstResponder];
    [self.IBM_SalesConnect setDelegate:self];
    [self.IBM_BrandTextField setDelegate:self];
    [self.IBM_BrandTextField becomeFirstResponder];
    [self.IBM_StatusTextField setDelegate:self];
    [self.IBM_StatusTextField becomeFirstResponder];
    [self.IBM_ESUTextField setDelegate:self];
    [self.IBM_ESUTextField becomeFirstResponder];
    [self.IBM_CXTextField setDelegate:self];
    [self.IBM_CXTextField becomeFirstResponder];
    [self.IBM_IssueImpact setDelegate:self];
    [self.IBM_IssueImpact becomeFirstResponder];
    [self.IBM_Issue setDelegate:self];
    [self.IBM_Issue becomeFirstResponder];
    [self.IBM_Actions setDelegate:self];
    [self.IBM_Actions becomeFirstResponder];
    [self.IBM_ClientContact setDelegate:self];
    [self.IBM_ClientContact becomeFirstResponder];
    [self.IBM_OtherBrand setDelegate:self];
    [self.IBM_OtherBrand becomeFirstResponder];
    [self.IBM_BUPersonnel setDelegate:self];
    [self.IBM_BUPersonnel becomeFirstResponder];
    [self.IBM_Resolution setDelegate:self];
    [self.IBM_Resolution becomeFirstResponder];
    
    //Remove pickers from superview, or else app will crash
    [self.IBM_BrandBU removeFromSuperview];
    [self.IBM_Status removeFromSuperview];
    [self.IBM_ESU removeFromSuperview];
    [self.IBM_CXName removeFromSuperview];
    
    //Creating toolbar for pickerView
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.tintColor = [UIColor blueColor];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
        style:UIBarButtonItemStyleBordered target:self action:@selector(closePickerView:)];
    toolbar.items = @[barButtonDone];
    barButtonDone.tintColor=[UIColor blackColor];
    
    //Make textfield input a UIPickerView for required sections
    self.IBM_BrandTextField.inputView = _IBM_BrandBU;
    self.IBM_BrandTextField.inputAccessoryView = toolbar;
    self.IBM_StatusTextField.inputView = _IBM_Status;
    self.IBM_StatusTextField.inputAccessoryView = toolbar;
    self.IBM_ESUTextField.inputView = _IBM_ESU;
    self.IBM_ESUTextField.inputAccessoryView = toolbar;
    self.IBM_CXTextField.inputView = _IBM_CXName;
    self.IBM_CXTextField.inputAccessoryView = toolbar;
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender != self.cancelButton){
        // save the value from the text field back to the item
        self.record.name = self.IBM_ClientName.text;
        self.record.salesconnect = self.IBM_SalesConnect.text;
        self.record.brandBU = self.IBM_BrandTextField.text;
        self.record.esu = self.IBM_ESUTextField.text;
        self.record.cxname = self.IBM_CXTextField.text;
        self.record.idescription = self.IBM_Issue.text;
        self.record.clientContact = self.IBM_ClientContact.text;
        self.record.buOther = self.IBM_OtherBrand.text;
        self.record.buPersonnel = self.IBM_BUPersonnel.text;
        self.record.issueImpact = self.IBM_IssueImpact.text;
        self.record.resolution = self.IBM_Resolution.text;
        
        //add to action record
        NSString *currentAction = [NSString stringWithFormat: @"%@", self.IBM_Actions.text];
        [self addAction: currentAction];
        if ([self.record.status isEqualToString:@"Closed"]){
            [self addAction:@"Closed"];
        }
    }
}

-(void)addAction: (NSString*) action
{
    IBM_AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale* currentLocale = [NSLocale currentLocale];
    [dateFormat setDateFormat:@"dd/MM/yyyy 'at' HH:mm"];
    [dateFormat setLocale:(currentLocale)];
    NSString *timestamp = [dateFormat stringFromDate:date];
    NSString *actionRecordInstance = [NSString stringWithFormat: @"%@ \"%@\" by %@", timestamp, action, appDelegate.user];
    if (self.record.actionRecord) {
        self.record.actionRecord = [NSString stringWithFormat:@"%@\r%@", self.record.actionRecord, actionRecordInstance];
    }
    else {
        self.record.actionRecord = [NSString stringWithFormat:@"Created %@", actionRecordInstance];
    }
}

#pragma mark - Enablement of Save/Done
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // This is used to handle the done key being pressed on the keyboard
    /*if(textField.text.length > 0){
        [self performSegueWithIdentifier:@"DoneButtonSegue" sender:self];
        return YES;
    }*/
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Controls the enablement of the save button
    [self.saveButton setEnabled:textField.text.length - range.length + string.length > 0];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag == 1){
        return _brandBUData.count;
    }
    if(pickerView.tag == 2){
        return _status.count;
    }
    if(pickerView .tag == 3){
        return _esu.count;
    }
    if(pickerView .tag == 4){
        return _cxName.count;
    }
    else{
        return 0;
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 1){
    return _brandBUData[row];
    }
    if(pickerView.tag == 2){
        return _status[row];
    }
    if(pickerView.tag == 3){
        return _esu[row];
    }
    if(pickerView.tag == 4){
        return _cxName[row];
    }
    else{
        return nil;
    }
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag == 1){
        self.record.brandBU = [_brandBUData objectAtIndex:row];
        self.IBM_BrandTextField.text = self.record.brandBU;
    }
    if(pickerView.tag == 2){
        self.record.status = [_status objectAtIndex:row];
        self.IBM_StatusTextField.text = self.record.status;
    }
    if(pickerView.tag == 3){
        self.record.esu = [_esu objectAtIndex:row];
        self.IBM_ESUTextField.text = self.record.esu;
    }
    if(pickerView.tag == 4){
        self.record.cxname = [_cxName objectAtIndex:row];
        self.IBM_CXTextField.text = self.record.cxname;
    }
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

//Closes pickerView
-(void)closePickerView:(id)sender
{
    [self.IBM_BrandTextField resignFirstResponder];
    [self.IBM_StatusTextField resignFirstResponder];
    [self.IBM_ESUTextField resignFirstResponder];
    [self.IBM_CXTextField resignFirstResponder];
}

@end
