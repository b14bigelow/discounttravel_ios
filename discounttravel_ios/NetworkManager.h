//
//  NetworkManager.h
//  RSSReader
//
//  Created by yuriy sych on 11/9/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (void)sendRequest:(NSString *)request complitionHandler:(void(^)(NSData *data))handler showErrors:(BOOL)showError;

@end
