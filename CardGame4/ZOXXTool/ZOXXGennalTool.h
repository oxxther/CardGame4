

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXGennalTool : NSObject

+ (instancetype)sharedSingleton;

// ---以下是keychain

+ (void)keychain_saveKey:(NSString *)serviceKey dataValue:(id)dataValue;

+ (id)keychain_loadValue:(NSString *)serviceKey;

+ (void)keychain_deleteValue:(NSString *)serviceKey;

// ---设备型号
+ (NSString *)ZOXXget_iphoneType;

// ---idfa
+ (NSString *)ZOXXget_idfa;

// ---BundleID
+ (NSString *)ZOXXget_BundleID;

// ---AppName
+ (NSString *)ZOXXget_AppName;

// ---Version
+ (NSString *)ZOXXget_Version;

@end

NS_ASSUME_NONNULL_END
