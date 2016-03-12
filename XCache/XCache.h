//
//  XCache.h
//  XCache
//
//  Created by xlx on 16/3/12.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCache : NSObject
/**
 *  查询手机剩余内存
 *
 */
+ (long long) freeDiskSpaceInBytes;
/**
 *  查询缓存大小   单位MB
 *
 */
+(NSString *)returnCacheSize;
/**
 *  计算单个文件大小
 *
 *  @param path 文件地址
 *
 */
+(long long)returnFileSize:(NSString *)path;
/**
 *  清理缓存
 *
 */
+(void)cleanCache:(void(^)())complete;
/**
 *  删除单个文件
 *
 */
+(void)deleteFile:(NSString *)path;
/**
 *  生成大量垃圾数据
 */
+(void)createLargeCache;

@end
