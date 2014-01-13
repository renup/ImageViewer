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


//+(AppCache *)sharedAppCache
//{
//    dispatch_once_t pred = 0;
//    __strong static AppCache *sharedAppCacheObj = nil;
//    dispatch_once(&pred, ^{
//        sharedAppCacheObj = [[AppCache alloc] init];
//    });
//    return sharedAppCacheObj;
//}

//-(AppCache *)init
//{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}

-(void)setImage:(UIImage *)pic forKey:(NSString *)picStr
{
    if (pic != nil) {
        [self._cache setObject:pic forKey:picStr];
    }
}

-(UIImage *)getImageForString:(NSString *)imageStr
{
   return [self._cache objectForKey:imageStr];
}

@end
