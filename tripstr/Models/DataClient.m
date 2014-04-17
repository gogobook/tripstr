//
//  DataClient.m
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "DataClient.h"

#import "TravelPlanObject.h"
#import "ConnectionsObject.h"

@implementation DataClient

-(void)parseFromTravelPlanJSONWithComplete:(CompleteBlock)complete andFail:(FailBlock)fail
{
    NSLog(@"parseFromTravelPlan");
    
    NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/travelplan.json"];
    
    NSData* data = [NSData dataWithContentsOfFile:filePath
                                          options:NSDataReadingMappedIfSafe error:nil];
    NSError* error = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (!error) {
        NSMutableArray* returnArray = @[].mutableCopy;
        [jsonData enumerateObjectsUsingBlock:^(NSDictionary* data, NSUInteger idx, BOOL *stop) {
            
            TravelPlanObject* travelPlan = [[TravelPlanObject alloc] initWithJSONdata:data];
            NSLog(@"%@",travelPlan.title);
            [returnArray addObject:travelPlan];
        }];
        //Call block (check if block exists)
        if (complete) {
            complete(returnArray.copy);//因為丟回去接的是個普通的陣列
        }
        
    } else {
        
        if (fail) {
            fail(error);
        }
    }
     
}

-(void)parseFromConnectionJSONWithComplete:(CompleteBlock)complete andFail:(FailBlock)fail
{
    NSLog(@"parseFromConnection");
    
    NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/connection.json"];
    
    NSData* data = [NSData dataWithContentsOfFile:filePath
                                          options:NSDataReadingMappedIfSafe error:nil];
    NSError* error = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"jsonData: \n %@",jsonData);
    if (!error) {
        NSMutableArray* returnArray = @[].mutableCopy;
        [jsonData enumerateObjectsUsingBlock:^(NSDictionary* data, NSUInteger idx, BOOL *stop) {
            
//            SpeakerObject* speaker = [[SpeakerObject alloc] initWithJSONdata:data];
//            NSLog(@"%ld",(long)speaker.speakerID);
//            [returnArray addObject:speaker];
        }];
        
        //Call block (check if block exists)
//        if (complete) {
//            complete(returnArray.copy);//因為丟回去接的是個普通的陣列
//        }
        
    } else {
        
        if (fail) {
            fail(error);
        }
        
    }
}
@end
