//
//  IBM_ListViewController.swift
//  bluelist-mobiledata-swift
//
//  Created by todd on 8/11/14.
//  Copyright (c) 2014 todd. All rights reserved.
//

import Foundation
import UIKit



class IBM_ListViewController : UITableViewController {
    
    // swift conversion!
    /*
        https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/BuildingCocoaApps/WritingSwiftClassesWithObjective-CBehavior.html
        Working with Outlets and Actions
    */
    //IBOutlets from view
    //@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
    @IBOutlet weak var addButton: UIBarButtonItem!

    
    /*

        https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html
        Array Literals
    */
    // Items in list
    //@property NSMutableArray *itemList;
    var itemList: NSMutableArray = []    // create as empty array?
    
    
    // If edit was trig((gered, th(e cell b != nil)e != nil)ing edited != nil).
    //@property UITableViewCell *editedCell;
    var editedCell : UITableViewCell?;
   
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    //#pragma mark - View initialization and refreshing
    override func loadView()
    {
        super.loadView();
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        //self.itemList = [[NSMutableArray alloc]init];
    
        // Setting up the refresh control
        //self.refreshControl = [[UIRefreshControl alloc]init];
        //self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Loading Items"];
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading Items");
        
        //[self.refreshControl addTarget:self action:@selector(handleRefreshAction) forControlEvents:UIControlEventValueChanged];
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged);
    
        // Load initial set of items
        //[self.refreshControl beginRefreshing];
        self.refreshControl.beginRefreshing();
        //[self listItems:^{
            //[self.refreshControl endRefreshing];
        //}];
        self.listItems({self.refreshControl.endRefreshing() });
    }
    
    override func viewWillAppear(animated:Bool)
    {
        super.viewWillAppear(animated);
        self.listItems({});
    }
    
    func handleRefreshAction()
    {
        self.listItems({
            // not supported in swift
            // hold off impl.. http://stackoverflow.com/questions/24126261/swift-alternative-to-performselectoronmainthread
            //self.refreshControl.performSelectorOnMainThread(aSelector: "endRefreshing:", withObject: nil!, waitUntilDone: false);
            self.refreshControl.endRefreshing();
        });
    }
    
    func myCustomSort(s1: AnyObject!, s2: AnyObject!) -> NSComparisonResult {
        
        
        var itemOne = s1 as IBMDataObject;
        var itemTwo = s2 as IBMDataObject;
        
        var nameOne = itemOne.objectForKey("name") as NSString;
        var nameTwo = itemTwo.objectForKey("name") as NSString;
        return nameOne.localizedCaseInsensitiveCompare(nameTwo);
    }
    
    func reloadLocalTableData()
    {
        //https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-XID_154
        println("reloadLocalTableData() printing out items list");
        println(self.itemList);
        
        var tmpList = itemList.sortedArrayUsingComparator(myCustomSort) ;
        self.itemList = NSMutableArray(array: tmpList) ;
        
        //self.itemList = sorted(self.itemList, {(item1:IBM_Item,item2:IBM_Item) -> Bool in
        //    return item1.name.caseInsensitiveCompare(item2.name) == NSComparisonResult.OrderedAscending
        //})
        
        
        
        // TODO:  Need to implement this
        //[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        self.tableView.reloadData();
    }
    

    override func setEditing (editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated:animated);
        self.tableView.setEditing(editing, animated:true);
    
        // Disable add button in edit mode
        if (editing) {
            self.addButton.enabled = false;
        } else {
            self.addButton.enabled = true;
        }
    }
    
    
    func listItems(callback :() -> Void)
    {
        
        var qry: IBMQuery = IBMQuery (forClass: "Item");
        var foo = qry.find().continueWithBlock{ task in
            if((task.error()) != nil) {
                    println("listItems failed with error: %@", task.error);
            } else {
                self.itemList = task.result() as NSMutableArray;
                self.reloadLocalTableData();
                if(callback !=  nil){
                    callback();
                }
            }
            return nil;
        }
    }
  
    func createItem(item : IBMDataObject)
    {
        self.itemList.addObject(item);
        self.reloadLocalTableData();
        
        //IBMDataObject *obj = [IBMDataObject objectOfClass:@"Restaurant"];
        //[[item save] continueWithBlock:^id(BFTask *task) {
        item.save().continueWithBlock{ task in
            if((task.error()) != nil) {
                println("createItem failed with error: %@", task.error);
            }
            return nil;
        }
    }
    
    
    
    func updateItem(item : IBMDataObject)
    {
        self.editedCell!.textLabel.text = item.objectForKey("name") as NSString;
        
        //[[item save] continueWithBlock:^id(BFTask *task) {
        item.save().continueWithBlock{ task in
            if(task.error() != nil) {
                println("updateItem failed with error: %@", task.error);
            }
            return nil;
        }
    }
    
    func deleteItem(item : IBMDataObject)
    {
        self.itemList.removeObject(item);
        self.reloadLocalTableData();
        
        
        item.delete().continueWithBlock{ task in
            if(task.error() != nil){
                println("deleteItem failed with error: %@", task.error);
            } else {
                self.listItems({});
            }
            return nil;
        }
        // Exit edit mode to avoid need to click Done button
        self.setEditing(false, animated: true);
    }
        
    override func numberOfSectionsInTableView (tableView : UITableView) -> NSInteger
    {
        println("numberOfSectionsInTableView entered");
        return 1;
    }
        
//    func numberOfRowsInSection (tableView : UITableView) -> NSInteger
//    {
//        println("numberOfRowsInSection entered -> %@", (self.itemList.count));
//        return self.itemList.count;
//    }
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println("tableView entered -> %@", (self.itemList.count));
        return self.itemList.count;
    }
    
    func cellForRowAtIndexPath(tableView : UITableView, indexPath : NSIndexPath) -> UITableViewCell!
    {
        println("cellForRowAtIndexPath entered");
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListItemCell", forIndexPath:indexPath) as UITableViewCell;
        if( cell != nil){
            tableView.dequeueReusableCellWithIdentifier("ListItemCell", forIndexPath: indexPath);
            cell.textLabel.text = self.itemList[indexPath.row].name  + "foo";
        }
        return cell;
    }
    
    
    
//    #pragma mark - Navigation to/from Create/Edit View
//    -(IBAction) updateListWithSegue: (UIStoryboardSegue *)segue
//    {
//      IBM_CreateEditItemViewController *createEditController = [segue sourceViewController];
//      if(createEditController.item.name && createEditController.item.name.length > 0){
//          if(self.editedCell){
//              // Is Update
//              [self updateItem: createEditController.item];
//          }else{
//          // Is Add
//              [self createItem: createEditController.item];
//          }
//      }
//      self.editedCell = nil;
//    }
    
    
    @IBAction func updateListWithSegue (segue : UIStoryboardSegue )
    {
        var createEditController : IBM_CreateEditItemViewController = segue.sourceViewController as IBM_CreateEditItemViewController;
        if(createEditController.item?.objectForKey("name") != nil){
            if(self.editedCell != nil){
                // Is Update
                self.updateItem(createEditController.item!);
            }else{
                        // Is Add
                self.createItem(createEditController.item!);
            }
        }
        self.editedCell = UITableViewCell();
    }
 
//    -(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//    {
//      UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
//      IBM_CreateEditItemViewController *createEditController = [[navigationController viewControllers] lastObject];
//      if(sender == self.addButton){
//          createEditController.item = [[IBM_Item alloc] init];
//      }else{
//          // is edit so seed the item with the title
//          self.editedCell = sender;
//          NSIndexPath* indexPath = [self.tableView indexPathForCell: self.editedCell];
//          createEditController.item = self.itemList[indexPath.row];
//      }
//    }
    
    override func prepareForSegue(segue : UIStoryboardSegue,  sender : AnyObject)
    {
        var navigationController = segue.destinationViewController as UINavigationController;
        var createEditController = navigationController.viewControllers.last as  IBM_CreateEditItemViewController ;
        if(sender as NSObject == self.addButton){
            println("creating IBMDataObject after click on plus button");
            createEditController.item = IBMDataObject(ofClass:"Item");
            println("returned from click");
        }else{
            // is edit so seed the item with the title
            self.editedCell = sender as UITableViewCell;
            var indexPath = self.tableView.indexPathForCell(self.editedCell);
            createEditController.item = self.itemList[indexPath.row] as IBMDataObject;
        }
    }
    
    func canEditRowAtIndexPath(tableView : UITableView, indexPath : NSIndexPath ) -> Bool
    {
        return true;
    }
   
    override func tableView (tableView : UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle,  forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            // Perform delete
            self.deleteItem (self.itemList[indexPath.row] as IBMDataObject);
        }
    }
 
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath:
            NSIndexPath!) -> UITableViewCell! {
            println("cellForRowAtIndexPath entered");
            let CellIndentifier: NSString = "ListItemCell";
            var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIndentifier) as UITableViewCell;
            cell.textLabel.text = self.itemList[indexPath.row].objectForKey("name") as NSString;
            return cell;
    }


}