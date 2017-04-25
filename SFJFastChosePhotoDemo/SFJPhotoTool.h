//
//  SFJPhotoTool.h
//  SFJFastChosePhotoDemo
//
//  Created by 沙缚柩 on 2017/4/24.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFJPhotoTool;

@protocol SFJPhotoToolDelegate <NSObject>
// 选择相片的代理
- (void)photoTool:(SFJPhotoTool *)photoTool didFinishPickingMediaWithImage:(UIImage *)image;
// 保存相片的代理
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error;

@end


@interface SFJPhotoTool : NSObject

@property (nonatomic, weak) id<SFJPhotoToolDelegate> delegate;

+ (instancetype)shareTool;

- (void)takePhotoSuccess:(void (^)(UIImagePickerController *picker))success failed:(void (^)())failed;

- (void)selectPhotoSuccess:(void (^)(UIImagePickerController *picker))success failed:(void (^)())failed;





@end
