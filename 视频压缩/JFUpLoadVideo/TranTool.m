//
//  TranTool.m
//  JFUpLoadVideo
//
//  Created by hun on 2017/10/30.
//  Copyright © 2017年 Jessonliu. All rights reserved.
//

#import "TranTool.h"
#import <AVKit/AVKit.h>
@implementation TranTool


/**
 转换

 @param filePath 传入文件路径
 */
+ (void) convertVideoWithModel:(NSString *)filePath
{
    //最后文件保存的名称
    NSString *filename = [NSString stringWithFormat:@"%ld.mp4",@"压缩后视频"];
    //保存至沙盒路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
    NSString * sandBoxFilePath = [pathDocuments stringByAppendingPathComponent:filename];
    NSLog([NSString stringWithFormat:@"存储路径,%@",sandBoxFilePath]);
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:sandBoxFilePath];
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.fileLengthLimit= 7* 1024* 1024;
    NSDate* tmpStartData = [NSDate date];
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        NSLog([NSString stringWithFormat:@"%d",exportStatus]);
        // 进度
        
        NSLog(@"%lf", exportSession.progress);
        
        // 状态 AVAssetExportSessionStatus
        
        NSLog(@"%ld", exportSession.status);
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"视频转码成功");
                //测试转码时间!
                double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
                NSLog(@"cost time = %f", deltaTime);
                NSData *data = [NSData dataWithContentsOfFile:sandBoxFilePath];
                NSLog([NSString stringWithFormat:@"转码后的视频大小,%lf",data.length]);
            }
        }
    }];
    
}

+(void)showTime
{
    NSDate* tmpStartData = [NSDate date];
    //You code here...
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
}

@end
