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
//    NSString *myUrl = [[NSString alloc] initWithFormat:@"http://api.zappos.com/Search/term/gifts?limit=50&sort={\"productPopularity\":\"desc\",\"price\":\"asc\"}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
//    
//    NSURL *url = [NSURL URLWithString:[myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    //    NSURL *url = [NSURL URLWithString:@"http://api.zappos.com/Statistics?type=topStyles&filters={\"brand\":{\"name\":\"Nike\"}}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//    [request setHTTPMethod:@"GET"];
//    
//    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
//    
//    NSHTTPURLResponse *response = nil;
//    
//    NSError *error = nil;
//    
//    _responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    _json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    
    _myResults = self.brain.getResults;
    
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
    
    _quantiy.tag = 1;
    _amount.tag = 2;
}

- (IBAction)buttonBudgetMe:(id)sender {
    
    [self getData];
  
    
}

-(void) getData{
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    quant = [f numberFromString:_quantiy.text];
    
    cost = [f numberFromString:_amount.text];
    
        if(quant == 0 || cost == 0){
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Zero Error"
                                                                  message:@"Put Quanity/Cost More Than Zero"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
    
            [myAlertView show];
    
        }
        else{
            
            [self myBrain];
            
            [self.displayResults reloadData];
        }
    
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
    
//    cell.productName.text = [[_myResults objectAtIndex:indexPath.row] objectForKey:@"productName"];
//    cell.productPrice.text = [[_myResults objectAtIndex:indexPath.row] objectForKey:@"price"];
//    cell.productImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_myResults objectAtIndex:indexPath.row] objectForKey:@"thumbnailImageUrl"]]]];
//    cell.productImage.image = [UIImage imageWithData:[NSURL URLWithString:[[[[self.myResults objectAtIndex:indexPath.row] comboList] objectAtIndex:1] objectForKey:@"thumbnailImageUrl"]]];
//[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_myResults objectAtIndex:indexPath.row] objectForKey:@"thumbnailImageUrl"]]]];    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[[self.myResults objectAtIndex:indexPath.row] comboList] objectAtIndex:1] objectForKey:@"thumbnailImageUrl"]]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.productImage.image = img;
        });
    });
    
    cell.productName.text = [NSString stringWithFormat:@"Combination: %d",indexPath.row+1];
    cell.productPrice.text = [NSString stringWithFormat:@"%@",[[self.myResults objectAtIndex:indexPath.row] totalValue]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"displayCombo"]){
        
        DisplayViewController *dvc = (DisplayViewController *)segue.destinationViewController;
        
        dvc.myResults = [[self.myResults objectAtIndex:self.displayResults.indexPathForSelectedRow.row] comboList];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([textField isEqual:_quantiy] && _quantiy.tag == 1)
        [_amount becomeFirstResponder];
    else{
        [textField resignFirstResponder];
        [self getData];
    }
    
    
    
    return NO;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_amount resignFirstResponder];
    [_quantiy resignFirstResponder];
}

@end
