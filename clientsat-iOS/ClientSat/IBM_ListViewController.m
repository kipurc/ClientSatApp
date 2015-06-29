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

#import "IBM_ListViewController.h"
#import "IBM_CreateEditItemViewController.h"
#import "IBM_ClientIssueRecord.h"

@interface IBM_ListViewController ()

//IBOutlets from view
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *profileButton;

// Items in list
@property NSMutableArray *recordList;

//Sections
@property NSMutableDictionary *sellerDict;
@property NSMutableDictionary *brandDict;
@property NSMutableDictionary *esuDict;

//Views
@property NSArray *brandBUData;
@property NSArray *esu;
@property NSArray *cxName;

// If edit was triggered, the cell being edited.
@property UITableViewCell *editedCell;

//View
@property NSString *segmentedView;

@end

@implementation IBM_ListViewController

@synthesize segmentedControl;

#pragma mark - View initialization and refreshing
-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.recordList = [[NSMutableArray alloc]init];
    self.segmentedView = @"seller";
    
    // Initialize Data
    _brandBUData = @[@"List Systems SW", @"Systems HW", @"GBS Consulting", @"GBS AMS", @"GTS SO", @"GTS ITS", @"GTS TSS", @"Cloud SW", @"Cloud Services", @"Buisness Analytics", @"Social", @"Commerce", @"Watson", @"Security", @"IGF"];
    _cxName = @[@"Amy Chhour/Australia/Contr/IBM", @"Amy Zammit/Australia/IBM", @"Audrey Rangel/Australia/IBM", @"Ben Teague/New Zealand/IBM", @"Bob Morton/Australia/IBM", @"Brett Ling/Australia/IBM", @"Brian Silver/Australia/IBM", @"Bridget Luke/Australia/IBM", @"Catherine Gullo/Australia/IBM", @"Chek Kiu Chan/Australia/Contr/IBM", @"Chloe Hayes/Australia/IBM", @"Chris Foster/New Zealand/IBM", @"Christian Jones/New Zealand/IBM", @"Chrystie Klein/Australia/IBM", @"Ciaran Ivory/Australia/IBM", @"Courtney Howe/Australia/Contr/IBM", @"Damandeep Mongia/Australia/IBM", @"Dane Gambrill/Australia/IBM", @"Daniel Skirving/Australia/IBM", @"Daryl Fowles/New Zealand/IBM", @"David Worth/New Zealand/IBM", @"Dean Hughes/New Zealand/IBM", @"Dean King/Australia/IBM", @"Deborah Helleur/Australia/IBM", @"Di Morton/Australia/IBM", @"Garry D'Orazio/Australia/IBM", @"Gloria Gao/Australia/Contr/IBM", @"Gordon Miles/Australia/IBM", @"Graeme P Muddle/Australia/IBM", @"Haidee Kozman/Australia/IBM", @"Ingrid van Uden/Australia/IBM", @"James Delooze/Australia/IBM", @"Jason Pradun/Australia/IBM", @"Jeffrey Klinge/Australia/IBM", @"Jo Northey/Australia/IBM", @"John Twine/Australia/IBM", @"Kelly Bilton/Australia/IBM", @"Kim Moleta/New Zealand/IBM", @"Kirsty M Simpson/Australia/IBM", @"Lay Chin Wan/New Zealand/IBM", @"Leanne McLennan/Australia/IBM", @"Lisa Umlauff/Australia/IBM", @"Lori-Lee Walker/Australia/IBM", @"Lucas Neira Sarmiento/Australia/IBM", @"Lynda Bartlett/Australia/IBM", @"Lynn S Currie/Australia/IBM", @"Maciek Kiernikowski/Australia/IBM", @"Malcolm De Silva/Australia/IBM", @"Mark D Osborne/Australia/IBM", @"Mark Hayden/New Zealand/IBM", @"Mark Rugless/Australia/IBM", @"Marleese Attilakos/Australia/IBM", @"Matthew Finch/Australia/IBM", @"Mesut Barkoren/Australia/IBM", @"Michael Kinnane/Australia/IBM", @"Michele Adams/New Zealand/IBM", @"Michelle Romanin/Australia/IBM", @"Nancy Mendez/Australia/IBM", @"Norika Miles/Australia/IBM", @"Pat Cullen/New Zealand/IBM", @"Patricia Caris Silk/Australia/IBM", @"Rachael Franklin/Australia/IBM", @"Rashad Evans/Australia/IBM", @"Robyn C Nott/Australia/IBM", @"Roula Psomiadis/Australia/IBM", @"Ruban Stephens/Australia/IBM", @"Rupina Menzagopian1/Australia/IBM", @"Sally Zhou/Australia/Contr/IBM", @"Sam Raffaele/Australia/IBM", @"Samanali Polwatte Gallage/Australia/IBM", @"Samantha Karpin/Australia/IBM", @"Scot Rogers/Australia/IBM", @"Scott Cowans/Australia/IBM", @"Sharon Hinde/New Zealand/IBM", @"Simon Groves/Australia/IBM", @"Stewart McDonald/Australia/IBM", @"Tania Jollie/Australia/IBM", @"Vanessa Boyer/Australia/IBM", @"Veronica Fryga/Australia/IBM", @"Vicki Blackwell/Australia/IBM", @"Vinod Dhingra/India/IBM"];
    _esu = @[@"QLD", @"WA", @"SA",@"VIC",@"NZ", @"NSW1", @"NSW2", @"MM"];

    // Setting up the refresh control
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Loading Items"];
    [self.refreshControl addTarget:self action:@selector(handleRefreshAction) forControlEvents:UIControlEventValueChanged];
    
    // Load initial set of items
    [self.refreshControl beginRefreshing];
    [self listItems:^{
        [self.refreshControl endRefreshing];
    }];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self listItems:nil];
}

-(void) handleRefreshAction
{
    [self listItems:^{
        [self.refreshControl performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
    }];
}

-(void) reloadLocalTableData
{
    [self.recordList sortUsingComparator:^NSComparisonResult(IBM_ClientIssueRecord* item1, IBM_ClientIssueRecord* item2) {
        return [item1.name caseInsensitiveCompare:item2.name];
    }];
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    
    // Disable add button in edit mode
    if (editing) {
        self.addButton.enabled = NO;
    } else {
        self.addButton.enabled = YES;
    }
}
    
#pragma mark Methods to list, create, update, and delete items
- (void)listItems: (void(^)(void)) cb
{
    IBMQuery *qry = [IBM_ClientIssueRecord query];
    [[qry find] continueWithBlock:^id(BFTask *task) {
        if(task.error) {
            NSLog(@"listItems failed with error: %@", task.error);
        } else {
            self.recordList = [NSMutableArray arrayWithArray: task.result];
            
            NSMutableArray *sellerList = [[NSMutableArray alloc] init];
            NSMutableArray *brandList = [[NSMutableArray alloc] init];
            NSMutableArray *esuList = [[NSMutableArray alloc] init];
            
            self.sellerDict = [[NSMutableDictionary alloc] init];
            self.brandDict = [[NSMutableDictionary alloc] init];
            self.esuDict = [[NSMutableDictionary alloc] init];
            
            //Check each record for match to seller
            for (NSString *seller in self.cxName) {
                for(IBM_ClientIssueRecord *record in self.recordList) {
                    // get the seller
                    NSString *recordSeller = record.cxname;
                    if ([recordSeller isEqualToString: seller]) {
                        //add record to seller list
                        [sellerList addObject:record];
                    }
                }
                //Seller dictionary - add array of records
                if(sellerList.count > 0){
                    [self.sellerDict setObject:[sellerList copy] forKey:seller];
                    [sellerList removeAllObjects];
                }
            }
            
            //Check each record for match to brand
            for (NSString *brand in self.brandBUData) {
                for(IBM_ClientIssueRecord *record in self.recordList) {
                    // get the brand
                    NSString *recordBrand = record.brandBU;
                    if ([recordBrand isEqualToString: brand]) {
                        //add record to brand list
                        [brandList addObject:record];
                    }
                }
                //Brand dictionary - add array of records
                if(brandList.count > 0){
                    [self.brandDict setObject:[brandList copy] forKey:brand];
                    [brandList removeAllObjects];
                }
            }
            
            //Check each record for match to esu
            for (NSString *esu in self.esu) {
                for(IBM_ClientIssueRecord *record in self.recordList) {
                    // get the esu
                    NSString *recordEsu = record.esu;
                    if ([recordEsu isEqualToString: esu]) {
                        //add record to esu list
                        [esuList addObject:record];
                    }
                }
                //Esu dictionary - add array of records
                if(esuList.count > 0){
                    [self.esuDict setObject:[esuList copy] forKey:esu];
                    [esuList removeAllObjects];
                }
            }
            
            //Incase of accidental lost record...
            /*for(IBM_ClientIssueRecord *record in self.recordList) {
                if ((!record.cxname.length) || (!record.esu.length) ||(!record.brandBU.length)){
                    [noneList addObject:record];
                    [self.noneDict setObject:[noneList copy] forKey:@"None"];
                }
            }*/
            
            
            [self reloadLocalTableData];
            if(cb){
                cb();
            }
            
        }
        return nil;
        
    }];
}
- (void) createItem: (IBM_ClientIssueRecord*) record
{
    [self.recordList addObject: record];
    [self reloadLocalTableData];
    
    [[record save] continueWithBlock:^id(BFTask *task) {
        if(task.error) {
            NSLog(@"createItem failed with error: %@", task.error);
        }
        return nil;
    }];
    
}

- (void) updateItem: (IBM_ClientIssueRecord*) record
{
    self.editedCell.textLabel.text = record.name;
    self.editedCell.detailTextLabel.text = record.idescription;
    [[record save] continueWithBlock:^id(BFTask *task) {
        if(task.error) {
            NSLog(@"updateItem failed with error: %@", task.error);
        }
        return nil;
    }];
    
}

-(void) deleteItem: (IBM_ClientIssueRecord*) record
{
    [self.recordList removeObject: record];
    [self reloadLocalTableData];
    [[record delete] continueWithBlock:^id(BFTask *task) {
        if(task.error){
            NSLog(@"deleteItem failed with error: %@", task.error);
        } else {
            [self listItems: nil];
        }
        return nil;
    }];
    
    // Exit edit mode to avoid need to click Done button
    [self.tableView setEditing:NO animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.segmentedView isEqualToString:@"seller"]) {return self.sellerDict.count;}
    if ([self.segmentedView isEqualToString:@"esu"]) {return self.esuDict.count;}
    if ([self.segmentedView isEqualToString:@"brand"]) {return self.brandDict.count;}
    else {return 0;}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.segmentedView isEqualToString:@"seller"]) {
        NSString *key = [[self.sellerDict allKeys] objectAtIndex:section];
        NSArray *value = [self.sellerDict objectForKey:key];
        return value.count;
    }
    if ([self.segmentedView isEqualToString:@"esu"]) {
        NSString *key = [[self.esuDict allKeys] objectAtIndex:section];
        NSArray *value = [self.esuDict objectForKey:key];
        return value.count;
    }
    if ([self.segmentedView isEqualToString:@"brand"]) {
        NSString *key = [[self.brandDict allKeys] objectAtIndex:section];
        NSArray *value = [self.brandDict objectForKey:key];
        return value.count;
    }
    else {
        return self.recordList.count;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.enabled = YES;
    cell.detailTextLabel.enabled = YES;

    if ([self.segmentedView isEqualToString:@"seller"]) {
        NSString *key = [[self.sellerDict allKeys] objectAtIndex:indexPath.section];
        NSArray *value = [self.sellerDict objectForKey:key];
        cell.textLabel.text = ((IBM_ClientIssueRecord*)value[indexPath.row]).name;
        cell.detailTextLabel.text = ((IBM_ClientIssueRecord*)value[indexPath.row]).idescription;
        
        //Grey out Closed Issues
        if ([((IBM_ClientIssueRecord*)value[indexPath.row]).status isEqualToString:@"Closed"]) {
            cell.textLabel.enabled = NO;
            cell.detailTextLabel.enabled = NO;
        }
    }
    if ([self.segmentedView isEqualToString:@"esu"]) {
        NSString *key = [[self.esuDict allKeys] objectAtIndex:indexPath.section];
        NSArray *value = [self.esuDict objectForKey:key];
        cell.textLabel.text = ((IBM_ClientIssueRecord*)value[indexPath.row]).name;
        cell.detailTextLabel.text = ((IBM_ClientIssueRecord*)value[indexPath.row]).idescription;
        if ([((IBM_ClientIssueRecord*)value[indexPath.row]).status isEqualToString:@"Closed"]) {
            cell.textLabel.enabled = NO;
            cell.detailTextLabel.enabled = NO;
        }
    }
    if ([self.segmentedView isEqualToString:@"brand"]) {
        NSString *key = [[self.brandDict allKeys] objectAtIndex:indexPath.section];
        NSArray *value = [self.brandDict objectForKey:key];
        cell.textLabel.text = ((IBM_ClientIssueRecord*)value[indexPath.row]).name;
        cell.detailTextLabel.text = ((IBM_ClientIssueRecord*)value[indexPath.row]).idescription;
        if ([((IBM_ClientIssueRecord*)value[indexPath.row]).status isEqualToString:@"Closed"]) {
            cell.textLabel.enabled = NO;
            cell.detailTextLabel.enabled = NO;
        }
    }
    return cell;
}

/* For making Closed issue items not editable. */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.segmentedView isEqualToString:@"seller"]) {
        NSString *key = [[self.sellerDict allKeys] objectAtIndex:indexPath.section];
        NSArray *value = [self.sellerDict objectForKey:key];
        if ([((IBM_ClientIssueRecord*)value[indexPath.row]).status isEqualToString:@"Closed"]) {
            return nil;
        }

    }
    if ([self.segmentedView isEqualToString:@"esu"]) {
        NSString *key = [[self.esuDict allKeys] objectAtIndex:indexPath.section];
        NSArray *value = [self.esuDict objectForKey:key];
        if ([((IBM_ClientIssueRecord*)value[indexPath.row]).status isEqualToString:@"Closed"]) {
            return nil;
        }
        
    }
    if ([self.segmentedView isEqualToString:@"brand"]) {
        NSString *key = [[self.brandDict allKeys] objectAtIndex:indexPath.section];
        NSArray *value = [self.brandDict objectForKey:key];
        if ([((IBM_ClientIssueRecord*)value[indexPath.row]).status isEqualToString:@"Closed"]) {
            return nil;
        }
    }
    return indexPath;
}

#pragma mark - Navigation to/from Profile View
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

#pragma mark - Navigation to/from Create/Edit View
-(IBAction) updateListWithSegue: (UIStoryboardSegue *)segue
{
    IBM_CreateEditItemViewController *createEditController = [segue sourceViewController];
    if(createEditController.record.name && createEditController.record.name.length > 0){
        if(self.editedCell){
            // Is Update
            [self updateItem: createEditController.record];
        }else{
            // Is Add
            [self createItem: createEditController.record];
        }
    }
    self.editedCell = nil;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    if(segue.identifier && ([segue.identifier isEqualToString:@"AddItemToList"] || [segue.identifier isEqualToString:@"EditItemToList"] || [segue.identifier isEqualToString:@"ViewDetails"])){
        IBM_CreateEditItemViewController *createEditController = [[navigationController viewControllers] lastObject];
        if(sender == self.addButton){
            createEditController.record = [[IBM_ClientIssueRecord alloc] init];
        } else{
        
            // is edit so seed the item with the title
            self.editedCell = sender;
            NSIndexPath* indexPath = [self.tableView indexPathForCell: self.editedCell];
            if ([self.segmentedView isEqualToString:@"seller"]) {
                NSString *key = [[self.sellerDict allKeys] objectAtIndex:indexPath.section];
                NSArray *value = [self.sellerDict objectForKey:key];
                createEditController.record = value[indexPath.row];
            }
            if ([self.segmentedView isEqualToString:@"esu"]) {
                NSString *key = [[self.esuDict allKeys] objectAtIndex:indexPath.section];
                NSArray *value = [self.esuDict objectForKey:key];
                createEditController.record = value[indexPath.row];
            }
            if ([self.segmentedView isEqualToString:@"brand"]) {
                NSString *key = [[self.brandDict allKeys] objectAtIndex:indexPath.section];
                NSArray *value = [self.brandDict objectForKey:key];
                createEditController.record = value[indexPath.row];
            }
        }
    }
}

#pragma mark - Deleting items
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

//TODO
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Perform delete
        [self deleteItem: self.recordList[indexPath.row]];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.segmentedView isEqualToString:@"seller"]) {
       return [[self.sellerDict allKeys] objectAtIndex:section];
    }
    if ([self.segmentedView isEqualToString:@"esu"]) {
        return [[self.esuDict allKeys] objectAtIndex:section];
    }
    if ([self.segmentedView isEqualToString:@"brand"]) {
        return [[self.brandDict allKeys] objectAtIndex:section];
    }
    else {return @"";}
}

- (IBAction)segmentedChange:(id)sender {
    
    if(segmentedControl.selectedSegmentIndex == 0){
        self.segmentedView = @"seller";
        [self reloadLocalTableData];
    }
    if(segmentedControl.selectedSegmentIndex == 1){
        self.segmentedView = @"esu";
        [self reloadLocalTableData];
    }
    if(segmentedControl.selectedSegmentIndex == 2){
        self.segmentedView = @"brand";
        [self reloadLocalTableData];
    }
    
}
@end
