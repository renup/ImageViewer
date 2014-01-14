//
//  AppCache.h
//  ImageViewer
//
//  Created by Renu P on 1/12/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCache : NSObject

+(AppCache *)sharedAppCache;

-(void)setImage:(UIImage *)pic forKey:(NSString *)picStr;
-(UIImage *)getImageForKey:(NSString *)imageStr;

@end
