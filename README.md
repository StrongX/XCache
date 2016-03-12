# XCache
一个对内存进行操作的简单工具

Compute application cache and clean cache
```
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


```
