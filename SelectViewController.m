//
//  SelectViewController.m
//  BudgetGift
//
//  Created by Rahul Sarna on 11/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController (){
    
    NSNumber *quant;
    NSNumber *cost;
    
    NSNumber *average;
    
}

@property (nonatomic, strong) BrainModel *brain;

@end

@implementation SelectViewController


-(BrainModel *)brain{
    
    if(!_brain)
        
        _brain = [[BrainModel alloc] init];
    
    return _brain;
       
    
}

- (IBAction)quantityField:(id)sender {
    
    
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    quant = [f numberFromString:_quantiy.text];
    
    cost = [f numberFromString:_amount.text];
    
    if(quant == 0){
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Zero Quantity"
                                                              message:@"Put Quanity More Than Zero"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else{
        average = [NSNumber numberWithFloat:[cost floatValue]/[quant floatValue]];
    }
    
    [sender resignFirstResponder];
    
    
    
}

- (IBAction)amountField:(id)sender {
    
    
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) myBrain{
    
    
    
    // 
    
    NSString *myUrl = [[NSString alloc] initWithFormat:@"http://api.zappos.com/Search/term/gifts?limit=50&sort={\"productPopularity\":\"desc\",\"price\":\"asc\"}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
    
    NSURL *url = [NSURL URLWithString:[myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //    NSURL *url = [NSURL URLWithString:@"http://api.zappos.com/Statistics?type=topStyles&filters={\"brand\":{\"name\":\"Nike\"}}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    
    NSHTTPURLResponse *response = nil;
    
    NSError *error = nil;
    
    _responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    _json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    
//    for(NSString *key in [_json allKeys]) {
//        
//        NSLog(@"Keys: %@",key);
//        
//        NSLog(@"%@",[_json objectForKey:key]);
//    }
    
    // });
//    _myResults = [[NSMutableArray alloc] initWithArray:[_json objectForKey:@"results"]];

            _myResults = self.brain.getResults;
    
    //    [self.displayResults reloadData];
    
    NSLog(@"%d",[_myResults count]);

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _displayResults.dataSource = self;
    _displayResults.delegate = self;
    
    _quantiy.delegate = self;
    _amount.delegate = self;
}

- (IBAction)buttonBudgetMe:(id)sender {
    
     [self myBrain];
    
    [self.displayResults reloadData];
    
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
    return _myResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.productName.text = [[_myResults objectAtIndex:indexPath.row] objectForKey:@"productName"];
    cell.productPrice.text = [[_myResults objectAtIndex:indexPath.row] objectForKey:@"price"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_myResults objectAtIndex:indexPath.row] objectForKey:@"thumbnailImageUrl"]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.productImage.image = img;
        });
    });
//    cell.productImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_myResults objectAtIndex:indexPath.row] objectForKey:@"thumbnailImageUrl"]]]];
    
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_amount resignFirstResponder];
    [_quantiy resignFirstResponder];
}

@end
