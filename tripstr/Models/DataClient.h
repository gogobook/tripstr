//
//  DataClient.h
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompleteBlock)(NSArray* returnArray);
typedef void (^FailBlock)(NSError* error);

@interface DataClient : NSObject

-(void) parseFromTravelPlanJSONWithComplete:(CompleteBlock) complete andFail: (FailBlock) fail;
-(void) parseFromConnectionJSONWithComplete:(CompleteBlock) complete andFail: (FailBlock) fail;

@end
