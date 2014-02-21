//
//  Combo.m
//  BudgetGift
//
//  Created by Rahul Sarna on 18/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "Combo.h"

@implementation Combo


-(NSMutableArray *) comboList{
    
    if(_comboList == nil){
        _comboList = [[NSMutableArray alloc] init];
    }
    
    return _comboList;
}


-(NSNumber *) totalValue{
    
    if(_totalValue == nil){
        _totalValue = [[NSNumber alloc] init];
    }
    
    return _totalValue;
}

@end
