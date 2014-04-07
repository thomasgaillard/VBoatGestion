//
//  FacturationDetailsViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "FacturationDetailsViewController.h"

@interface FacturationDetailsViewController ()

@end

@implementation FacturationDetailsViewController

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
    [self rafraichir];
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)rafraichir{
    self.etatTxt.text=self.facture.etat;
    self.remarquesTxt.text=self.facture.remarque;
    self.prixTxt.text=[NSString stringWithFormat:@"%@ ",self.facture.prixTotal];
    NSLog(@"Compte : %lu",(unsigned long)[self.facture.locations count]);
    self.listeLocations=[self.facture.locations allObjects];
}

-(void)selectedFacture:(Facture *)facture
{
    self.facture=facture;
    [self rafraichir];
    [self.chaqueLocsFacture reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"COUNT : %lu",(unsigned long)[self.listeLocations count]);
    return [self.listeLocations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"HH:mm"];
    
    FacturationTableViewLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaLocPedalo" forIndexPath:indexPath];
    NSLog(@"coucou");
    Location * loc = [self.listeLocations objectAtIndex:indexPath.row];
    cell.nomEmbarcation.text=loc.embarcation.nom;
    cell.heureDebut.text=[formatter stringFromDate:loc.heureDebut];
    cell.heureFin.text=[formatter stringFromDate:loc.heureFin];
    cell.nbPersonnes.text=[loc getNbPlacesOuType];
    cell.remarques.text=loc.remarque;
    cell.prix.text=[NSString stringWithFormat:@"%@€",[loc calculerPrix]];
    //NSLog([NSString stringWithFormat:@"%@, %@ ",facture.locations,facture.etat]);
    
    return cell;
}

@end
