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

//static AppCache *sharedAppCacheObj = nil;

@implementation AppCache

@synthesize cache;

+ (id)sharedAppCache
{
    static AppCache *sharedMyManager = nil;
    
    static dispatch_once_t onceToken;
 
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.cache = [[NSCache alloc] init];
    });
    
    return sharedMyManager;
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
