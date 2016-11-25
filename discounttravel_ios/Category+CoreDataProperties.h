//
//  Category+CoreDataProperties.h
//  discounttravel_ios
//
//  Created by yuriy sych on 11/25/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Category+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Category (CoreDataProperties)

+ (NSFetchRequest<Category *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *alias;
@property (nonatomic) int32_t category_id;
@property (nullable, nonatomic, copy) NSString *published;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
