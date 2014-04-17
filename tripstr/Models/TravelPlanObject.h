//
//  TravelPlanObject.h
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelPlanObject : NSObject

@property (nonatomic,strong) NSString* cityImagePath;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* cityName;
@property (nonatomic,strong) NSString* content;

-(instancetype) initWithJSONdata: (NSDictionary*) data;

@end
