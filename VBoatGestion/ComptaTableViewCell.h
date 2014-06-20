//
//  ComptaTableViewCell.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 19/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Journee;
@interface ComptaTableViewCell : UITableViewCell

@property (strong, nonatomic) Journee *jour;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextField *nbLocs;
@property (weak, nonatomic) IBOutlet UITextField *montantCb;
@property (weak, nonatomic) IBOutlet UITextField *montantEspèces;
- (IBAction)startEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *total;
@end
