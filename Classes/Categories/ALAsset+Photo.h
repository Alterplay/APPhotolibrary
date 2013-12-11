//
//  ALAsset+Photo.h
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAsset (Photo)

- (UIImage *)photoThumbnail;
- (void)loadPhotoInFullResolutionAsynchronously:(void (^)(UIImage *image))callbackBlock;
- (void)loadPhotoInFullScreenAsynchronously:(void (^)(UIImage *image))callbackBlock;

@end
