//
//  PostModel.h
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostModel;
@protocol PostModelDelegate <NSObject>

-(void) didFetchDataAll: (NSMutableArray*) postList;
-(void) failToFetchDataAll: (NSError*) error;

@end


@interface PostModel : NSObject

@property (nonatomic,strong) NSString* postId;
@property (nonatomic,strong) NSString* headline;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,strong) NSString* location;
@property (nonatomic,strong) NSString* photoURLString;
@property (nonatomic,strong) NSString* authorId;

@property (nonatomic,strong) id <PostModelDelegate> delegate;

-(void) fetchPostListAll;


@end
