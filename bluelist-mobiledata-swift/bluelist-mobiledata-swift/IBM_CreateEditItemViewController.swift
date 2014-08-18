//
//  IBM_CreateEditItemViewController.swift
//  bluelist-mobiledata-swift
//
//  Created by todd on 8/12/14.
//  Copyright (c) 2014 todd. All rights reserved.
//

import Foundation
import UIKit


class IBM_CreateEditItemViewController : UIViewController, UITextFieldDelegate {

//@interface IBM_CreateEditItemViewController () <UITextFieldDelegate>
//
//// IBOutlets from View
//@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
//

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var item: IBMDataObject?

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    
//@end
//
//@implementation IBM_CreateEditItemViewController
//
//#pragma mark - View initialization
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    if(self.item.name){
//        // is edit so initialize the text field with the item title
//        self.itemTextField.text = self.item.name;
//    }
//    
//    [self.itemTextField becomeFirstResponder];
//    [self.itemTextField setDelegate:self];
//}

override func viewDidLoad()
{
    super.viewDidLoad();
    if((self.item?.objectForKey("name")) != nil){
        self.itemTextField.text = self.item?.objectForKey("name") as NSString;
    }
    self.itemTextField.becomeFirstResponder();
    self.itemTextField.delegate = self;

}





//
//#pragma mark - Navigation
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if(sender != self.cancelButton && self.itemTextField.text.length > 0){
//        // save the value from the text field back to the item
//        self.item.name = self.itemTextField.text;
//    }else{
//        self.item = nil;
//    }
//}

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if(sender as NSObject !=  self.cancelButton && !self.itemTextField.text.isEmpty){
            self.item?.setObject(self.itemTextField.text, forKey:"name");
        }
        else{
            //self.item.delete();
            self.item = nil;
        }
    }




//
//#pragma mark - Enablement of Save/Done
//-(BOOL) textFieldShouldReturn:(UITextField *)textField
//{
//    // This is used to handle the done key being pressed on the keyboard
//    if(self.itemTextField.text.length > 0){
//        [self performSegueWithIdentifier:@"DoneButtonSegue" sender:self];
//        return YES;
//    }
//    return NO;
//}

    func textFieldShouldReturn( textField : UITextField) -> Bool{
        if (!self.itemTextField.text.isEmpty){
            self.performSegueWithIdentifier("DoneButtonSegue", sender: self as AnyObject);
            return true;
        }
        else{
            return false;
        }
        
    }


//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    // Controls the enablement of the save button
//    [self.saveButton setEnabled:self.itemTextField.text.length - range.length + string.length > 0];
//    return YES;
//}
//
//@end
    

    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        if(!self.itemTextField.text.isEmpty && !string.isEmpty){
            self.saveButton.enabled = true;
        }
        return true;
    }

}
