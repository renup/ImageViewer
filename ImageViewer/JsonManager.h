//
//  JsonManager.h
//  ImageViewer
//
//  Created by Renu P on 1/10/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonManager : NSObject

//-(JsonManager *)init;

- (void)writeJsonToDocumentsDirectory;
- (NSArray *)fetchedData;

@end
