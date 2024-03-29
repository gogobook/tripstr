//
//  TravelPlanObject.m
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "TravelPlanObject.h"

@implementation TravelPlanObject

-(instancetype)initWithJSONdata:(NSDictionary *)data
{
    
    if (self = [super init]) {
        self.cityImagePath = data[@"cityImagePath"];
        self.title = data[@"title"];
        self.cityName = data[@"cityName"];
        self.content = data[@"content"];
    }
    return self;
}

@end