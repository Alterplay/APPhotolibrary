//
//  APPhotoViewController.m
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import "APPhotoViewController.h"
#import "ALAsset+Photo.h"

@interface APPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@end

@implementation APPhotoViewController

#pragma mark - appearance

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAssetImage];
}

#pragma mark - private

- (void)loadAssetImage
{
    [self.activity startAnimating];
    self.imageView.alpha = 0.f;
    __weak __typeof(self) weakSelf = self;
    [self.asset loadPhotoInFullScreenAsynchronously:^(UIImage *image)
    {
        [weakSelf.activity stopAnimating];
        weakSelf.imageView.image = image;
        [UIView animateWithDuration:0.2f animations:^
        {
            weakSelf.imageView.alpha = 1.f;
        }];
    }];
}

@end
