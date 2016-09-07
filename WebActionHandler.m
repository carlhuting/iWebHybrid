//
//  WebActionHandler.m
//  Communication
//
//  Created by lkeg on 16/9/4.
//  Copyright © 2016年 com.lemontree.muzhi. All rights reserved.
//

#import "WebActionHandler.h"

static NSString *const scheme = @"iWebHybrid";

@implementation WebActionHandler

+ (instancetype)shareHandler {
    static WebActionHandler *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[WebActionHandler alloc] init];
    });
    return shareInstance;
}

- (BOOL)handleURL:(NSURL *)url {
    if ([url.scheme isEqualToString:scheme]) {
        NSLog(@"handel url %@", url.absoluteString);
        return YES;
    }
    return NO;
}

@end
