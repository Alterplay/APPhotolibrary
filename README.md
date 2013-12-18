<img src="https://dl.dropboxusercontent.com/u/2334198/APPhotolibrary-git-teaser.png">

APPhotolibrary is a wrapper on [ALAssetsLibrary](https://developer.apple.com/library/ios/documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html) and a category for [ALAsset](https://developer.apple.com/library/ios/documentation/AssetsLibrary/Reference/ALAsset_Class/Reference/Reference.html)


#### Features
* Asynchronous loading of photo library assets
* Asynchronous sorting of assets
* Asynchronous loading of full resolution photo from asset
* Asynchronous loading of full screen photo from asset

#### Installation
Add `APPhotolibrary` pod to Podfile


#### Using

###### Load photos
```objective-c
APPhotolibrary *photolibrary = [[APPhotolibrary alloc] init];
[photolibrary loadPhotosAsynchronously:^(NSArray *assets, NSError *error)
{
    if (!error)
    {
        // show assets
    }
    else
    {
        // show error
    }
}];

```

###### Sort photos
```objective-c
photolibrary.sortAscending = YES;
photolibrary.sortComparator = ^NSComparisonResult(ALAsset *asset1, ALAsset *asset2)
{
    // return result of comparsion two assets   
};
```

> ### Default sort is by date


###### Get photo from asset
```objective-c
#import "ALAsset+Photo.h"
...
ALAsset *asset = // assign asset
// photo thumbnail
self.thumbnailImageView.image = asset.photoThumbnail;
// load fullscreen photo (size depends on device screen)
__weak __typeof(self) weakSelf = self;
[asset loadPhotoInFullScreenAsynchronously:^(UIImage *image)
{
    weakSelf.fullScreenImageView.image = image;
}];
// load full resolution photo
[asset loadPhotoInFullResolutionAsynchronously:^(UIImage *image)
{
    weakSelf.fullScreenImageView.image = image;
}];
```

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/b44e965f18d06c561e4dd22212647d65 "githalytics.com")](http://githalytics.com/Alterplay/APPhotolibrary)

=======================
[Check out](https://github.com/Alterplay) all Alterplay's GitHub projects.
[Email us](mailto:hello@alterplay.com?subject=From%20GitHub%20APPhotolibrary) with other ideas and projects.
