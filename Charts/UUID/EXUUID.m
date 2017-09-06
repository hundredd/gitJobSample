//
//  EXUUID.m
//  Charts
//
//  Created by Eleven on 16/8/11.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXUUID.h"
#import "EXKeyChainStore.h"
@implementation EXUUID
+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[EXKeyChainStore load:@"com.company.app.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [EXKeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}
@end
