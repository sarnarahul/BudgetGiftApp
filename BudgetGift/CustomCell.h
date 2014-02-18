//
//  CustomCell.h
//  BudgetGift
//
//  Created by Rahul Sarna on 13/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productImage;

@property (strong, nonatomic) IBOutlet UILabel *productName;

@property (strong, nonatomic) IBOutlet UILabel *productPrice;


@end
