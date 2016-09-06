//
//  WebActionHandler.h
//  Communication
//
//  Created by lkeg on 16/9/4.
//  Copyright © 2016年 com.baidu.muzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebActionHandler : NSObject
+ (instancetype)shareHandler;
- (BOOL)handleURL:(NSURL *)url;
@end
