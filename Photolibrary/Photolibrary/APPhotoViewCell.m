//
//  APPhotoViewCell.m
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import "APPhotoViewCell.h"
#import "ALAsset+Photo.h"

@implementation APPhotoViewCell

- (void)updateWithModel:(id)model
{
    ALAsset *asset = model;
    self.imageView.image = asset.photoThumbnail;
}

@end
