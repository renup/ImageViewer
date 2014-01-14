//
//  AppCache.m
//  ImageViewer
//
//  Created by Renu P on 1/12/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "AppCache.h"

@interface AppCache()

@property (nonatomic, strong)NSCache *_cache;

@end

static AppCache *sharedAppCacheObj = nil;

@implementation AppCache

@synthesize _cache;


+(AppCache *)sharedAppCache
{
    if (sharedAppCacheObj == nil)
    {
        sharedAppCacheObj = [[AppCache alloc] init];
        sharedAppCacheObj._cache = [[NSCache alloc] init];
    }
    return sharedAppCacheObj;
}


-(void)setImage:(UIImage *)pic forKey:(NSString *)picStr
{
    if (pic != nil) {
        [self._cache setObject:pic forKey:picStr];
    }
}

-(UIImage *)getImageForKey:(NSString *)imageStr
{
   return [self._cache objectForKey:imageStr];
}

@end
