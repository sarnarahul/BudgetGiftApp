//
//  BrainModel.m
//  BudgetGift
//
//  Created by Rahul Sarna on 15/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "BrainModel.h"

@interface BrainModel(){
    
}


@end

@implementation BrainModel

-(NSMutableArray *) brainResults{
    
    if(_brainResults == nil){
        _brainResults = [[NSMutableArray alloc] init];
    }
    
    return _brainResults;
}

//-(Combo *)combo{
//    
//    if(!_combo)
//        
//        _combo = [[Combo alloc] init];
//    
//    return _combo;
//    
//}

-(NSMutableArray *) getResults{
    
    NSString *myUrl = [[NSString alloc] initWithFormat:@"http://api.zappos.com/Search/term/gifts?limit=51&sort={\"price\":\"asc\"}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
    
    NSURL *url = [NSURL URLWithString:[myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //    NSURL *url = [NSURL URLWithString:@"http://api.zappos.com/Statistics?type=topStyles&filters={\"brand\":{\"name\":\"Nike\"}}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
        
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    
    NSHTTPURLResponse *response = nil;
    
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
//    for(NSString *key in [json allKeys]) {
//        
//        NSLog(@"Keys: %@",key);
//        
//        NSLog(@"%@",[json objectForKey:key]);
//    }
    
    _brainResults = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"results"]];
    
    for(id key in _brainResults) {
        
        NSLog(@"%g",[[[key objectForKey:@"price"] substringFromIndex:1] floatValue]);
        
    }
    
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithArray:[self getMyCombos]];
    
    

//    [self getMyCombos];
    
//    return _brainResults;
    
    return myArray;
    
}

-(NSMutableArray *) getMyCombos{
    
//    int j=0;
    
    NSMutableArray *myList = [[NSMutableArray alloc] init];
    
    Combo *myCombo = [[Combo alloc] init];
    
    for(int i=1;i<=_brainResults.count;i++){
        
        [myCombo.comboList addObject:[_brainResults objectAtIndex:i-1]];
        
        myCombo.totalValue =[NSNumber numberWithFloat:[[[[_brainResults objectAtIndex:i-1] objectForKey:@"price"] substringFromIndex:1] floatValue] + [myCombo.totalValue floatValue]];
        
        
        if(i%3==0){
            
            [myList addObject:myCombo];
            
            myCombo = [[Combo alloc] init];
            
        }
        
    }
    
    [self print:myList];
    
    return myList;
    
}

-(void)print: (NSMutableArray *) display{
    
    for(int i=0; i < display.count; i++){
        
        NSLog(@"%@, %d",[[display objectAtIndex:i] totalValue], [[[display objectAtIndex:i] comboList] count]);
        
        for(int j=0;j < [[[display objectAtIndex:i] comboList] count];j++ ){
            NSLog(@"%@", [[[[display objectAtIndex:i] comboList] objectAtIndex:j] objectForKey:@"styleId"]);
        }
        
    }
    
    NSLog(@"%d",display.count);
    
}

-(NSComparisonResult) compareTotal: (Combo *)otherObject {
    
    return [self.totalCost compare:otherObject.totalValue];
}



//NSSortDescriptor *sortDescriptor;
//sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalCost"
//                                             ascending:YES];
//NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//NSArray *sortedArray;
//sortedArray = [drinkDetails sortedArrayUsingDescriptors:sortDescriptors];

-(void) differentCombinations: (NSMutableArray *) results :(float) amount :(int) quantity{
    
    int comboSize = 0;
    float total = 0;
    
    NSMutableArray *myList = [[NSMutableArray alloc] init];
    
    int i = 0;
    
    do {
        
        if(amount - [[[[results objectAtIndex:i] objectForKey:@"price"] substringFromIndex:1] floatValue]<=8){ // change 8 to something done dynamically from the website
            
            return;
        }
        else{
            
            Combo *combo = [[Combo alloc] init];
            
            [_combo.comboList addObject:[results objectAtIndex:i]];
            
            _combo.totalValue = [[NSNumber alloc] initWithFloat: [[[[results objectAtIndex:i] objectForKey:@"price"] substringFromIndex:1] floatValue]];
            
            if(total == 0){
               [myList addObject:combo];
                
                total += [[[[results objectAtIndex:i] objectForKey:@"price"] substringFromIndex:1] floatValue];
            }
            else if(total > 0){
                
               NSArray *sorted = [myList sortedArrayUsingSelector:@selector(compareTotal:)];
                
                [myList removeAllObjects];
                
                myList = [NSMutableArray arrayWithArray:sorted];
                
                
//                NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalCost" ascending:YES];
//                [myList sortUsingDescriptors:[NSArray arrayWithObject:aSortDescriptor]];
                
                for(id key in myList){
                    
                    if([[[results objectAtIndex:i] objectForKey:@"styleId"] isEqualToString:[key objectForKey:@"styleId"]]){
                        break;
                    }
                    else{
                        
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        
        
        
    } while (amount >=0 || quantity == comboSize);
    
    
}

-(void) combinations: (NSMutableArray *) results{
    
    
    //    NSMutableArray *combiantions = [[NSMutableArray alloc] init];
    
    _totalQuantity = [[NSNumber alloc] initWithInt:3];
    
    _totalCost = [[NSNumber alloc] initWithInt:150];
    
    float amountCalculated = 0;
    
    int quantityCalculated = 0;
    
    for(id key in _brainResults) {
        
        NSLog(@"%g",[[[key objectForKey:@"price"] substringFromIndex:1] floatValue]);
        
        if(amountCalculated == 0){
            
            [_combinations addObject:key];
            
            amountCalculated += [[[key objectForKey:@"price"] substringFromIndex:1] floatValue];
            
            quantityCalculated++;
            
        }
        else{
            if(quantityCalculated>=1){
                
                [_combinations addObject:key];
                
                amountCalculated += [[[key objectForKey:@"price"] substringFromIndex:1] floatValue];
                
            }
            if (amountCalculated>150) {
                
                //                id removeKey = [_combinations lastObject];
                
                
                
                
            }
            
            
            
        }
        
    }
    
    
}



@end
