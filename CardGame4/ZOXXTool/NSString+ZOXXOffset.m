
#import "NSString+ZOXXOffset.h"

#define Offset 10

@implementation NSString (ZOXXOffset)

- (NSString *)string1Offset2{
    NSMutableString *mustr = [NSMutableString string];
    unsigned char css[self.length];
    memcpy(css, [self cStringUsingEncoding:NSUTF8StringEncoding], self.length);
    for (int i = 0; i < sizeof(css); i++) {
        [mustr appendFormat:@"%d,",css[i] + i * Offset];
    }
    return [mustr copy];
}

- (NSString *)string2Offset1{
    NSMutableString *mustr = [NSMutableString string];
    NSArray *strings = [self componentsSeparatedByString:@","];
    for (int i = 0; i < strings.count - 1; i++) {
        [mustr appendFormat:@"%c",((NSString *)strings[i]).intValue - i * Offset];
    }
    return [mustr copy];
}

@end
