//
//  FacturationDetailsViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "Facture.h"
#import "Embarcation.h"
#import "FacturationTableViewController.h"
#import "FacturationSelectionDelegate.h"
#import "FacturationTableViewLocationCell.h"

@interface FacturationDetailsViewController : UIViewController <FacturationSelectionDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UITableView *tableView;
@property NSUInteger *indexPath;
@property (nonatomic, strong) NSMutableArray *facturesArray;
@property (strong, nonatomic) Facture *facture;
@property (strong, nonatomic) NSArray *listeLocations;
@property (weak, nonatomic) IBOutlet UILabel *prixTxt;
@property (weak, nonatomic) IBOutlet UILabel *etatTxt;
@property (weak, nonatomic) IBOutlet UITextField *remarquesTxt;
@property (weak, nonatomic) IBOutlet UITableView *chaqueLocsFacture;
@property (weak, nonatomic) IBOutlet UILabel *paiementTxt;
@property (weak, nonatomic) IBOutlet UILabel *resteAPayerTxt;
@property (weak, nonatomic) IBOutlet UILabel *remiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *remiseTxt;
@property (weak, nonatomic) IBOutlet UIButton *especesBtn;
@property (weak, nonatomic) IBOutlet UIButton *cbBtn;
@property (weak, nonatomic) IBOutlet UIButton *eurosBtn;
@property (weak, nonatomic) IBOutlet UIButton *pcBtn;
@property (weak, nonatomic) IBOutlet UIButton *tempsBtn;
@property (weak, nonatomic) IBOutlet UIButton *clotureBtn;
@property (weak, nonatomic) IBOutlet UIView *noFactures;
@property (weak, nonatomic) IBOutlet UIImageView *noFacturesBg;
@property (weak, nonatomic) IBOutlet UILabel *aucuneFacturation;

- (IBAction)clicPaveNumerique:(id)sender;
- (IBAction)clicPaiement:(id)sender;
- (IBAction)clicRemise:(id)sender;
- (IBAction)clicRAZ:(id)sender;
- (IBAction)clicCloture:(id)sender;
- (IBAction)clicAnnuler:(id)sender;
-(void)rafraichir;
-(void)resteAPayer;
-(void)saveContext;
@end
