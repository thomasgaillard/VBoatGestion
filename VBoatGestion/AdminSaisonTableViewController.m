//
//  AdminSaisonTableViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "AdminSaisonTableViewController.h"
#import "Facture.h"
#import "Embarcation.h"
#import "Location.h"
#import "AppDelegate.h"
#import "Journee.h"

@interface AdminSaisonTableViewController ()

@end

@implementation AdminSaisonTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //self.arrayFactProblemes = [appDelegate getAllFactsSuivies];
    
    NSArray *arrayJourneeEnCours = [appDelegate getAllJourneesEnCours];
    NSLog(@"J1 %lu", (unsigned long)[arrayJourneeEnCours count]);
    if ([arrayJourneeEnCours count]==0) {
        
    }else
    {
        Journee *journee = [arrayJourneeEnCours firstObject];
        self.arrayFactProblemes = [journee.factures allObjects];
    }
    
    [self.tableView reloadData];
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
    return [self.arrayFactProblemes count];
}


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    rAdminJourneeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uneFact" forIndexPath:indexPath];
    
    Facture * facture = [self.arrayFactProblemes objectAtIndex:indexPath.row];
    Location *loc = [facture.locations anyObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    if([facture.locations count]==1){
        cell.nomLoc.text = [NSString stringWithFormat:@"%@ ",loc.embarcation.nom];
    }else{
        cell.nomLoc.text = @"Locations multiples";
    }
    cell.heureFin.text = [NSString stringWithFormat:@"%@ ",[formatter stringFromDate: loc.heureFin]];
    cell.total.text= [NSString stringWithFormat:@"%@ €",facture.prixTotal];
    cell.remarque.text= [NSString stringWithFormat:@"%@ ",facture.remarque];
    if ([facture.etat  isEqual: @"remisee"]) {
        cell.remise.text= [NSString stringWithFormat:@"%@ €",facture.remise];
    }else {
        cell.remise.text= [NSString stringWithFormat:@"%@",facture.etat];
    }
    
    //NSLog([NSString stringWithFormat:@"%@, %@ ",facture.locations,facture.etat]);
    
    return cell;
}*/

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
@end
