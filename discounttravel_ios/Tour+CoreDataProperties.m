//
//  Tour+CoreDataProperties.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/25/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Tour+CoreDataProperties.h"

@implementation Tour (CoreDataProperties)

+ (NSFetchRequest<Tour *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Tour"];
}

@dynamic catid;
@dynamic created;
@dynamic gallery;
@dynamic tour_id;
@dynamic images;
@dynamic introtext;
@dynamic modified;
@dynamic state;
@dynamic title;
@dynamic type;

@end
