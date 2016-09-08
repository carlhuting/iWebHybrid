//
//  WebActionHandler.m
//  Communication
//
//  Created by lkeg on 16/9/4.
//  Copyright © 2016年 com.lemontree.iWebHyrid. All rights reserved.
//

#import "WebActionHandler.h"
#import "WXApiRequestHandler.h"

static NSString *const scheme = @"iwebhybrid"; // ignore case
static NSString *const shareHost = @"com.iwebhybirid.share";
static NSString *const logHost = @"com.iwebhybirid.log";
static NSString *const alertreHost = @"com.iwebhybirid.alert";

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
    
    if (self.enableLog) {
        NSLog(@"handle url= %@", url.absoluteString);
    }
    
    if ([url.scheme isEqualToString:scheme]) {
        NSString *param = [url.query copy];
        param = [param stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSError *error;
       id obj = [NSJSONSerialization JSONObjectWithData:[param dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        
        if ([url.host isEqualToString:shareHost]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *msg = (NSDictionary *)obj;
                [WXApiRequestHandler sendLinkURL:msg[@"url"] TagName:@"哈哈" Title:msg[@"title"] Description:msg[@"desc"] ThumbImage:[UIImage imageNamed:@"thumb"] InScene:WXSceneTimeline];
            }
            return YES;
        }
        
        if ([url.host isEqualToString:logHost]) {
            NSLog(@"%@", param);
            return YES;
        }
        
        if ([url.host isEqualToString:alertreHost]) {
            NSLog(@"%@", param);
            return YES;
        }
    }
    //TODO why not use runtime transfer to a method?
    return NO;
}

@end
