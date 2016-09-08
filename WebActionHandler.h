//
//  WebActionHandler.h
//  Communication
//
//  Created by lkeg on 16/9/4.
//  Copyright © 2016年 com.lemontree.muzhi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebActionHandler : NSObject
@property (nonatomic, assign) BOOL enableLog;
+ (instancetype)shareHandler;
- (BOOL)handleURL:(NSURL *)url;
@end
