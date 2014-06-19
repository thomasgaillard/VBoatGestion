//
//  ComptaTableViewCell.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 19/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComptaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextField *nbLocs;
@property (weak, nonatomic) IBOutlet UITextField *montantCb;
@property (weak, nonatomic) IBOutlet UITextField *montantEspèces;
@property (weak, nonatomic) IBOutlet UILabel *total;
@end
