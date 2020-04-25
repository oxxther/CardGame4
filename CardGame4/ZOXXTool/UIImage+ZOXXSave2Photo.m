

#import "UIImage+ZOXXSave2Photo.h"
#import <Photos/Photos.h>

@implementation UIImage (ZOXXSave2Photo)

- (void)saveIntoPhotosAlbum{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
           status == PHAuthorizationStatusDenied) {
        //无权限
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self, NULL, NULL, NULL);
}

@end
