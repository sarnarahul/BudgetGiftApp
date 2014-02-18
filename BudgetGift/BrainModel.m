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

-(NSMutableArray *) getResults{
    
    NSString *myUrl = [[NSString alloc] initWithFormat:@"http://api.zappos.com/Search/term/gifts?limit=20&sort={\"productPopularity\":\"desc\"}&key=52ddafbe3ee659bad97fcce7c53592916a6bfd73"];
    
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
    
    return _brainResults;
    
}


-(void) combinations: (NSMutableArray *) results{
    
    
    NSMutableArray *combiantions = [[NSMutableArray alloc] init];
    
    
    
    for(id key in results) {

        NSLog(@"%@",[key objectForKey:@"price"]);
        
    }
    
    
    
}


@end
