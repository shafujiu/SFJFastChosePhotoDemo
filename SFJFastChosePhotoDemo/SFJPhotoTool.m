//
//  SFJPhotoTool.m
//  SFJFastChosePhotoDemo
//
//  Created by 沙缚柩 on 2017/4/24.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "SFJPhotoTool.h"

@interface SFJPhotoTool ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation SFJPhotoTool

static SFJPhotoTool *tool = nil;

+ (instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (void)takePhotoSuccess:(void (^)(UIImagePickerController *picker))success failed:(void (^)())failed{
    /*
     UIImagePickerControllerCameraDeviceRear,   //后置摄像头
     UIImagePickerControllerCameraDeviceFront   //前置摄像头
     */
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) { //没有
        !failed ? :failed();
        return;
    }
    
    UIImagePickerController *imageCtrl = [[UIImagePickerController alloc] init];
    //指定资源的来源：来自摄像头
    imageCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imageCtrl.allowsEditing = YES;
    imageCtrl.delegate = self;
    !success ? :success(imageCtrl);
    //    [self presentViewController:imageCtrl animated:YES completion:NULL];
}

- (void)selectPhotoSuccess:(void (^)(UIImagePickerController *picker))success failed:(void (^)())failed{
    /*
     sourceType:指定资源的来源
     UIImagePickerControllerSourceTypePhotoLibrary,       //显示所有同步到iPhone上的图像包括用户拍摄的图片的文件夹
     UIImagePickerControllerSourceTypeCamera,             //来自摄像头
     UIImagePickerControllerSourceTypeSavedPhotosAlbum    //系统内置的相册文件夹
     */
    //1.创建控制器
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imageCtrl = [[UIImagePickerController alloc] init];
        //2.指定资源的来源
        imageCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //3.设置代理
        imageCtrl.delegate = self;
//        imageCtrl.allowsEditing = YES;
        //4.使用模态视图的方式来弹出
        !success ? : success(imageCtrl);
        //        [self presentViewController:imageCtrl animated:YES completion:NULL];
    }else{
        !failed ? :failed();
    }
}


#pragma mark - <UIImagePickerControllerDelegate>
// TODO:选择一个照片或者视屏的时候调用的方法，info包含了资源相关的信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //1.取出图片 - 取出原始图片 UIImagePickerControllerOriginalImage
    //          - 取出编辑后的图片（裁剪后的） UIImagePickerControllerEditedImage
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        // 1.取出图片
//        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 2.判断图片的来源是否是来自照相机
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // 3.将图片保存到相册
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            // 通知机制 配套的方法
            //- (void)image:(UI Image *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
        }
        
        if ([self.delegate respondsToSelector:@selector(photoTool:didFinishPickingMediaWithImage:)]) {
            [self.delegate photoTool:self didFinishPickingMediaWithImage:image];
        }
    }
    // 关闭模态视图
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//TODO:通过UIImageWriteToSavedPhotosAlbum保存图片成功之后，调用此方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if ([self.delegate respondsToSelector:@selector(image:didFinishSavingWithError:)]) {
        [self.delegate image:image didFinishSavingWithError:error];
    }
    NSLog(@"保存成功");
}

@end
