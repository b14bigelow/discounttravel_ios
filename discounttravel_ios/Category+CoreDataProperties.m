//
//  Category+CoreDataProperties.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/25/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Category+CoreDataProperties.h"

@implementation Category (CoreDataProperties)

+ (NSFetchRequest<Category *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Category"];
}

@dynamic alias;
@dynamic category_id;
@dynamic published;
@dynamic title;

@end
