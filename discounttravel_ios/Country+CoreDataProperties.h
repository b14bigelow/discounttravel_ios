//
//  Country+CoreDataProperties.h
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Country+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest;

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, copy) NSString *alias;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *published;

@end

NS_ASSUME_NONNULL_END
