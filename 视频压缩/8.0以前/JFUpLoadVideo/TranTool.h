//
//  TranTool.h
//  JFUpLoadVideo
//
//  Created by hun on 2017/10/30.
//  Copyright © 2017年 Jessonliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranTool : NSObject

+ (void) convertVideoWithModel:(NSString *)filePath
              andProccessBlock:(void(^)(float process))ProcessBlock
                andFinishBlock:(void(^)(NSData *data,NSString *filePath))finishBlock
                      andError:(void(^)(NSError *error)) errorBlock;

@end
