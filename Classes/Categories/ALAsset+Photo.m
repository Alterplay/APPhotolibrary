//
//  ALAsset+Photo.m
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import "ALAsset+Photo.h"

@implementation ALAsset (Photo)

- (UIImage *)photoThumbnail
{
    if (self.thumbnail)
    {
        return [UIImage imageWithCGImage:self.thumbnail scale:UIScreen.mainScreen.scale
                                                  orientation:UIImageOrientationUp];
    }
    return nil;
}

- (void)loadPhotoInFullResolutionAsynchronously:(void (^)(UIImage *image))callbackBlock
{
    [self loadPhotoAsynchronously:callbackBlock isFullResolution:YES];
}

- (void)loadPhotoInFullScreenAsynchronously:(void (^)(UIImage *image))callbackBlock
{
    [self loadPhotoAsynchronously:callbackBlock isFullResolution:NO];
}

#pragma mark - private

- (void)loadPhotoAsynchronously:(void (^)(UIImage *))callbackBlock
               isFullResolution:(BOOL)isFullResolution
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        ALAssetRepresentation *representation = self.defaultRepresentation;
        CGImageRef cgImage = isFullResolution ? representation.fullResolutionImage :
                             representation.fullScreenImage;
        UIImage *image = nil;
        if (cgImage)
        {
            image = [UIImage imageWithCGImage:cgImage scale:UIScreen.mainScreen.scale
                                  orientation:UIImageOrientationUp];
        }
        dispatch_async(dispatch_get_main_queue(), ^
        {
            callbackBlock ? callbackBlock(image) : nil;
        });
    });
}

@end
