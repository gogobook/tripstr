//
//  PostModel.m
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "PostModel.h"


@implementation PostModel

-(instancetype) initWithObjectData: (id)data andObjId: (NSString*) objId
{
    self = [super init];
    self.postId = objId;
    self.headline = data[@"headline"];
    self.content = data[@"content"];
    self.location = data[@"location"];
    self.photoURLString = data[@"photoURLString"];
    self.authorId = data[@"authorId"];
    self.photo = data[@"photo"];
    
//    PFUser* author = data[@"author"];
//    [author fetchIfNeeded];
//    self.authorName = author[@"name"];
    return self;
}

+(instancetype) postWithObjData: (id)data andObjId: (NSString*) objId
{
    return [[self alloc] initWithObjectData:data andObjId: (NSString*) objId];
}


-(void)fetchPostListAll
{
    NSMutableArray* postArray = @[].mutableCopy;
    PFQuery* query = [PFQuery queryWithClassName:@"postData"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
           
            if ([self.delegate respondsToSelector:@selector(failToFetchDataAll:)]) {
                [self.delegate failToFetchDataAll:error];
            } else {
                NSLog(@"PostModel|fetchPostListAll|failToFetchDataAll: not implemented \n %@",error);
            }
            
        } else {
            [objects enumerateObjectsUsingBlock:^(PFObject* obj, NSUInteger idx, BOOL *stop) {
                PostModel* post = [PostModel postWithObjData:obj andObjId: obj.objectId];
                [postArray addObject:post];
            }];
            
            if ([self.delegate respondsToSelector:@selector(didFetchDataAll:)]) {
                [self.delegate didFetchDataAll:postArray];
            } else {
                NSLog(@"PostModel|fetchPostListAll|didFetchDataAll: not implemented");
            }
        }
        
    }];
    // PFQuery works asynchronously, codes after this line will be executed immediately after query is called.
}

-(void)fetchPostListMe
{
    NSMutableArray* postArray = @[].mutableCopy;
    PFQuery *postQuery = [PFQuery queryWithClassName:@"postData"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    
    // Run the query
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [objects enumerateObjectsUsingBlock:^(PFObject* obj, NSUInteger idx, BOOL *stop) {
                PostModel* post = [PostModel postWithObjData:obj andObjId: obj.objectId];
//                NSLog(@"%@",post.authorName);
                [postArray addObject:post];
                
                
                
                
                
            }];
            
            if ([self.delegate respondsToSelector:@selector(didFetchDataAll:)]) {
                [self.delegate didFetchDataAll:postArray];
            } else {
                NSLog(@"PostModel|fetchPostListMe|didFetchDataAll: not implemented");
            }
        }
    }];

}

@end
