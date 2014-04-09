//
//  FacturationTableViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "FacturationTableViewController.h"
#import "Facture.h"
#import "AppDelegate.h"
#import "FacturationTableViewCell.h"
#import "Location.h"

@interface FacturationTableViewController ()

@end

@implementation FacturationTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    [self reloadFactures];
}

-(void)reloadFactures
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.facturesArray = [[appDelegate getAllFactsEnCours] mutableCopy];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.facturesArray.count == 0) {
        
    }else
    {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionBottom];
        Facture *selectedFacture = [self.facturesArray objectAtIndex:[NSIndexPath indexPathForRow:0 inSection:0].row];
        if (self.delegate) {
        [self.delegate selectedFacture:selectedFacture :self.tableView :[NSIndexPath indexPathForRow:0 inSection:0].row :self.facturesArray];
        }
    }
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self reloadFactures];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.facturesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FacturationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaLigneFacture" forIndexPath:indexPath];
    
    Facture * facture = [self.facturesArray objectAtIndex:indexPath.row];
    
    if([facture.locations count]==1){
        Location *loc = [facture.locations anyObject];
        cell.labelFacture.text = [NSString stringWithFormat:@"%@ ",loc.embarcation.nom];
        NSLog([NSString stringWithFormat:@"%@ ",loc.heureFin]);
        NSLog([NSString stringWithFormat:@"%@ ",loc.embarcation.nom]);
    } else {
        cell.labelFacture.text = @"Locations multiples";
    }
    //NSLog([NSString stringWithFormat:@"%@, %@ ",facture.locations,facture.etat]);
    
    
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Facture *selectedFacture = [self.facturesArray objectAtIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate selectedFacture:selectedFacture :tableView :indexPath.row :self.facturesArray];
    }
}

@end
