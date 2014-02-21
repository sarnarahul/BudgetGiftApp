//
//  SelectViewController.h
//  BudgetGift
//
//  Created by Rahul Sarna on 11/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "BrainModel.h"
#import "DisplayViewController.h"


#define ZKEY @"52ddafbe3ee659bad97fcce7c53592916a6bfd73"
#define APIWEB @"http://api.zappos.com/Statistics?type=latestStyles"
#define STATAPI @"/Statistics?type=topStyles&filters={\"brand\":{\"name\":\"Nike\"}}"
#define ZAPI @"http://api.zappos.com"

@interface SelectViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *quantiy;
@property (strong, nonatomic) IBOutlet UITextField *amount;
@property (strong, nonatomic) IBOutlet UITableView *displayResults;


@property (strong, nonatomic) NSString *latestUrl;
@property (strong, nonatomic) NSData *responseData;

@property (strong, nonatomic) NSDictionary *json;

@property (strong, nonatomic) NSMutableArray *myResults;

@property (strong, nonatomic) NSMutableArray *myBrands;

@end
