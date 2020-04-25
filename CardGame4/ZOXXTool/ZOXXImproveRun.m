

#import "ZOXXImproveRun.h"
#import "ZOXXLogPlayer.h"

@implementation ZOXXImproveRun

+ (BOOL)ZOXX_improveRunGame{
    
    BOOL flag = NO;
    
    //每10天清除一下沙盒的游戏缓存
    // 获取cache目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSString *remember = @"gameStartTime";
    NSString *rememberFilePath = [cachesDir stringByAppendingPathComponent:remember];
    NSError * error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:rememberFilePath]) {
        //有读取时间
        NSString *firstTime = [NSString stringWithContentsOfFile:rememberFilePath encoding:NSUTF8StringEncoding error:&error];
        NSTimeInterval timeLine = [firstTime floatValue];
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
//        24 *60 * 60 *10   10天
        if ((nowTime - timeLine) > 24 *60 * 60 *10) {
            //超过十天
            //清楚某一文件下的内容
            [ZOXXLogPlayer clearCaches];
            flag = YES;
        }
    }else{
        NSString * firstTime = [NSString stringWithFormat:@"%lf",[[NSDate date] timeIntervalSince1970]];
        [firstTime writeToFile:rememberFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
    return flag;
    
}
@end
