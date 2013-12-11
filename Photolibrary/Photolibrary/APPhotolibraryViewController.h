//
//  APPhotolibraryViewController.h
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCollectionViewController.h"

@class APPhotolibrary;

@interface APPhotolibraryViewController : DTCollectionViewController
{
    APPhotolibrary *photoLibrary;
}

@end
