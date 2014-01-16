//
//  AppCache.m
//  ImageViewer
//
//  Created by Renu P on 1/12/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "AppCache.h"

@interface AppCache()

@property (nonatomic, strong)NSCache *cache;

@end

static AppCache *sharedAppCacheObj = nil;

@implementation AppCache

@synthesize cache;


+(AppCache *)sharedAppCache
{
    if (sharedAppCacheObj == nil)
    {
        NSLog(@"CREATING AGAIN");
        sharedAppCacheObj = [[AppCache alloc] init];
        sharedAppCacheObj.cache = [[NSCache alloc] init];
    }
    return sharedAppCacheObj;
}


-(void)setImage:(UIImage *)pic forKey:(NSString *)picStr
{
    if (pic != nil) {
        [self.cache setObject:pic forKey:picStr];
    }
}

-(UIImage *)getImageForKey:(NSString *)imageStr
{
   return [self.cache objectForKey:imageStr];
}

@end
