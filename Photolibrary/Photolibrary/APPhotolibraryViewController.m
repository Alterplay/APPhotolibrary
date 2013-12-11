//
//  APPhotolibraryViewController.m
//  Photolibrary
//
//  Created by Alexey Belkevich on 12/11/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import "APPhotolibraryViewController.h"
#import "APPhotoViewCell.h"
#import "APPhotolibrary.h"
#import "APPhotoViewController.h"

@import AssetsLibrary;

@interface APPhotolibraryViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@end

@implementation APPhotolibraryViewController

#pragma mark - life cycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        photoLibrary = [[APPhotolibrary alloc] init];
    }
    return self;
}

#pragma mark - appearance

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerCellClass:APPhotoViewCell.class forModelClass:ALAsset.class];
    [self loadPhotos];
}

#pragma mark - collection view delegate implementation

- (void)  collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self collectionItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:NSStringFromClass(APPhotoViewController.class)
                              sender:asset];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    APPhotoViewController *controller = segue.destinationViewController;
    controller.asset = sender;
}

#pragma mark - private

- (void)loadPhotos
{
    [self.activity startAnimating];
    __weak __typeof(self) weakSelf = self;
    [photoLibrary loadPhotosAsynchronously:^(NSArray *assets, NSError *error)
    {
        [weakSelf.activity stopAnimating];
        if (!error)
        {
            [weakSelf addCollectionItems:assets];
            [weakSelf.collectionView reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
