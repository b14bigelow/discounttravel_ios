//
//  Country+CoreDataProperties.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Country+CoreDataProperties.h"

@implementation Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Country"];
}

@dynamic id;
@dynamic alias;
@dynamic title;
@dynamic published;

@end
