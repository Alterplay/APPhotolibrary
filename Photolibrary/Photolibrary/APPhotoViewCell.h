//
//  APPhotoViewCell.h
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCollectionViewModelTransfer.h"

@interface APPhotoViewCell : UICollectionViewCell <DTCollectionViewModelTransfer>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
