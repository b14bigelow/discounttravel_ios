//
//  Tour+CoreDataProperties.h
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Tour+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tour (CoreDataProperties)

+ (NSFetchRequest<Tour *> *)fetchRequest;

@property (nonatomic) int32_t id;
@property (nonatomic) int32_t state;
@property (nullable, nonatomic, copy) NSString *catid;
@property (nullable, nonatomic, copy) NSString *created;
@property (nullable, nonatomic, copy) NSString *modified;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *introtext;
@property (nullable, nonatomic, copy) NSString *images;
@property (nullable, nonatomic, copy) NSString *gallery;
@property (nullable, nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
