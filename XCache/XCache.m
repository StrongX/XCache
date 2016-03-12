//
//  XCache.m
//  XCache
//
//  Created by xlx on 16/3/12.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import "XCache.h"
#include <sys/param.h>
#include <sys/mount.h>
#import <UIKit/UIKit.h>

@implementation XCache

+ (long long) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace;
}

+(NSString *)returnCacheSize{
    return [NSString stringWithFormat:@"%lld",(
                                               [XCache folderSizeAtPath:[NSString stringWithFormat:@"%@/tmp",NSHomeDirectory()]] +
                                               [XCache folderSizeAtPath:[NSString stringWithFormat:@"%@/Library",NSHomeDirectory()]])
                                                /(1024*1024)];
}

+(long long)returnFileSize:(NSString *)path{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    return [[manager attributesOfItemAtPath :path error : nil ]fileSize];
}

+(long long) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [XCache returnFileSize:fileAbsolutePath];
    }
    return folderSize;
}

+(void)cleanCache:(void (^)())complete{
    [XCache deleteFile:[NSString stringWithFormat:@"%@/tmp",NSHomeDirectory()]];
    [XCache deleteFile:[NSString stringWithFormat:@"%@/Library",NSHomeDirectory()]];
    complete();
}

+(void)deleteFile:(NSString *)path{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :path] objectEnumerator];
    
    NSString * fileName;

    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [path stringByAppendingPathComponent :fileName];
        [manager removeItemAtPath:fileAbsolutePath error:nil];
    }

}

+(void)createLargeCache{
    for (int j = 0; j<40; j++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            long long freespace = [XCache freeDiskSpaceInBytes];
            for (long long i = freespace*j; freespace>0; i++) {
                NSData *cacheData = UIImagePNGRepresentation([UIImage imageNamed:@"1.jpg"]);
                [cacheData writeToFile:[NSString stringWithFormat:@"%@/Documents/data%lld",NSHomeDirectory(),i] atomically:true];
                freespace-=cacheData.length;
                
            }
        });
    }
    
}



@end
