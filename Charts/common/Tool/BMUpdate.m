//
//  BMUpdate.m
//  特种车调度
//
//  Created by 王鑫 on 16/3/23.
//
//

#import "BMUpdate.h"

@implementation BMUpdate

+ (void) versionUpdate{
    
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    NSLog(@"%@", currentVersion);
    //请求服务器数据
    BMRequest *request = [BMRequest requestWithPath:@"checkVersion"];
    request.params = @{@"plat" : @"iOS", @"role" : kRole, @"versionCode" : currentVersion};
    [[BMHttpTool sharedInstance] postWith:request finish:^(BMResponse *response, NSError *error) {
        if (response.status == kResultOK) {
            NSString *content = response.rawResult[@"content"];
            BOOL forceUpdate = response.rawResult[@"forceUpdate"];
            BOOL status = response.rawResult[@"status"];
            NSString *title = response.rawResult[@"title"];
            NSString *type = response.rawResult[@"type"];
            NSInteger versionCode = response.rawResult[@"versionCode"];
            NSString *versionUrl = response.rawResult[@"versionUrl"];
            if (forceUpdate) {
//                <#statements#>
            }else{
                
            }
        }
    }];
    
}


@end
