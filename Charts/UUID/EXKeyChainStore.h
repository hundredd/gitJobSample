//
//  EXKeyChainStore.h
//  Charts
//
//  Created by Eleven on 16/8/11.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXKeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end
