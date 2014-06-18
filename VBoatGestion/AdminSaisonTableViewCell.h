//
//  AdminSaisonTableViewCell.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminSaisonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nomLoc;
@property (weak, nonatomic) IBOutlet UILabel *heureFin;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *remise;
@property (weak, nonatomic) IBOutlet UILabel *remarque;

@end
