//
//  Tour+CoreDataProperties.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Tour+CoreDataProperties.h"

@implementation Tour (CoreDataProperties)

+ (NSFetchRequest<Tour *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Tour"];
}

@dynamic id;
@dynamic state;
@dynamic catid;
@dynamic created;
@dynamic modified;
@dynamic title;
@dynamic introtext;
@dynamic images;
@dynamic gallery;
@dynamic type;

@end
