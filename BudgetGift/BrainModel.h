//
//  BrainModel.h
//  BudgetGift
//
//  Created by Rahul Sarna on 15/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrainModel : NSObject


@property (strong , nonatomic) NSMutableArray *brainResults;
@property (strong , nonatomic) NSNumber *totalCost;
@property (strong , nonatomic) NSNumber *totalQuantity;


-(NSMutableArray *) getResults;


@end
