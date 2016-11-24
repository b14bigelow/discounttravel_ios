//
//  NetworkManager.m
//  RSSReader
//
//  Created by yuriy sych on 11/9/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"

@implementation NetworkManager

+ (void)sendRequest:(NSString *)urlAddress complitionHandler:(void (^)(NSData *))handler showErrors:(BOOL)showError{
    
        if(!urlAddress){
            return;
        }
    
        if(showError && ![AppDelegate checkNetworkStatus]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [getAppDelegate() showError:NSLocalizedString(@"check network", nil)];
                });
            return;
        }
        
        NSURL *url = [[NSURL alloc] initWithString:urlAddress];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                if(showError){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [getAppDelegate() showError:error.localizedDescription];
                    });
                }
            } else {
                handler(data);
            }
        }];
        [task resume];
}

@end
