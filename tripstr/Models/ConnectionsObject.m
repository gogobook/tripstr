//
//  ConnectionsObject.m
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "ConnectionsObject.h"

@implementation ConnectionsObject

-(instancetype)initWithJSONdata:(NSDictionary *)data
{
    if (self= [super init]) {
        
        self.userImagePath = data[@"userImagePath"];
        self.userName = data[@"userName"];
        self.userMessage = data[@"userMessage"];
        self.userStatus = data[@"userStatus"];
    }
    return self;
}

@end
