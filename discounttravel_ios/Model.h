//
//  Model.h
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ModelDelegate
- (void)dataUpdated;
@end
@interface Model : NSObject
@property (nonatomic, strong) NSArray* toursList;
@property (nonatomic, strong) NSArray* countriesList;
- (void)setDelegate:(id<ModelDelegate>)delegate;
- (void)removeDelegate:(id<ModelDelegate>)delegate;
@end
