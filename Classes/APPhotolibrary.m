//
//  APPhotolibrary.m
//  APPhotolibrary
//
//  Created by Alexey Belkevich on 12/10/13.
//  Copyright (c) 2013 alterplay. All rights reserved.
//

#import "APPhotolibrary.h"
#import "ALAssetsGroup+Assets.h"

@implementation APPhotolibrary

#pragma mark - life cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        _assetLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

#pragma mark - public

+ (BOOL)isAuthorized
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    return (status == ALAuthorizationStatusAuthorized ||
            status == ALAuthorizationStatusNotDetermined);
}

- (void)loadPhotosAsynchronously:(void (^)(NSArray *assets, NSError *error))callbackBlock
{
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@""
                                                                 ascending:self.sortAscending
                                                                comparator:self.sortComparator];
    [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
    {
        [assets addObjectsFromArray:group.assets];
        if (!group)
        {
            [assets sortUsingDescriptors:@[descriptor]];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                callbackBlock ? callbackBlock([assets copy], nil) : nil;
            });
        }
    } failureBlock:^(NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            callbackBlock ? callbackBlock(nil, error) : nil;
        });
    }];
}

#pragma mark - private

- (APAssetComparator)sortComparator
{
    if (!_sortComparator)
    {
        _sortComparator = ^NSComparisonResult(ALAsset *asset1, ALAsset *asset2)
        {
            NSDate *date1 = [asset1 valueForProperty:ALAssetPropertyDate];
            NSDate *date2 = [asset2 valueForProperty:ALAssetPropertyDate];
            return [date1 compare:date2];
        };
    }
    return _sortComparator;
}

@end