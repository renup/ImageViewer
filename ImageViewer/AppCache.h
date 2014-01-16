//
//  AppCache.h
//  ImageViewer
//
//  Created by Renu P on 1/12/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

//This class caches all the images so that we don't have to fresh download each time user scrolls repeatedly table view in MasterViewController or the full image in DetailViewController
#import <Foundation/Foundation.h>

@interface AppCache : NSObject

/** Creating a singleton AppCache object */
+(id)sharedAppCache;

/** Creating Setters and Getters for images stored in the cache */
-(void)setImage:(UIImage *)pic forKey:(NSString *)picStr;
-(UIImage *)getImageForKey:(NSString *)imageStr;

@end
