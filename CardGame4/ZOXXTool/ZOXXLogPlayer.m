//
//  ZOXXLogPlayer.m
//  CardGame4
//
//  Created by macos on 2020/4/25.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXLogPlayer.h"

@implementation ZOXXLogPlayer

+ (void)write2Caches:(NSString *)txt{
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSString *gameLog = @"gameLog";
    NSString *gameLogFilePath = [cachesDir stringByAppendingPathComponent:gameLog];
    NSError * error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:gameLogFilePath]) {
        NSString *log = [NSString stringWithContentsOfFile:gameLogFilePath encoding:NSUTF8StringEncoding error:&error];
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"**** yyyy-MM-dd HH:mm:ss ****\n";
        NSString *time =  [df stringFromDate:[NSDate date]];
        [log stringByAppendingFormat:@"%@\n%@",time,txt];
        [log writeToFile:gameLogFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }else{
        [txt writeToFile:gameLogFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
}

+ (void)clearCaches{
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSString *gameLog = @"gameLog";
    NSString *gameLogFilePath = [cachesDir stringByAppendingPathComponent:gameLog];
    NSError *error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:gameLogFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:gameLogFilePath error:&error];
    }
}

@end
