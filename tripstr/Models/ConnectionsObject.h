//
//  ConnectionsObject.h
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionsObject : NSObject

@property (nonatomic,strong) NSString* userImagePath;
@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userMessage;
@property (nonatomic,strong) NSString* userStatus;

-(instancetype) initWithJSONdata: (NSDictionary*) data;

@end
