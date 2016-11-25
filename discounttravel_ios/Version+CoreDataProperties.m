//
//  Version+CoreDataProperties.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/25/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Version+CoreDataProperties.h"

@implementation Version (CoreDataProperties)

+ (NSFetchRequest<Version *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Version"];
}

@dynamic versionCode;

@end
