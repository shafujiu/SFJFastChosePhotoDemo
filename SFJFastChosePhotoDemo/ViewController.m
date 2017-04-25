//
//  ViewController.m
//  SFJFastChosePhotoDemo
//
//  Created by 沙缚柩 on 2017/4/24.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "ViewController.h"
#import "SFJPhotoTool.h"


@interface ViewController ()<SFJPhotoToolDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImageViw;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SFJPhotoTool shareTool].delegate = self;
}

- (IBAction)takePhoto:(id)sender {
    
    [[SFJPhotoTool shareTool] takePhotoSuccess:^(UIImagePickerController *picker) {
        [self presentViewController:picker animated:YES completion:nil];
    } failed:^{
        NSLog(@"拍照失败");
    }];
}

- (IBAction)chosePhoto:(id)sender {
    [[SFJPhotoTool shareTool] selectPhotoSuccess:^(UIImagePickerController *picker) {
        [self presentViewController:picker animated:YES completion:nil];
    } failed:^{
        NSLog(@"选择失败");
    }];
}

#pragma mark - <SFJPhotoToolDelegate>
// 选择相片的代理
- (void)photoTool:(SFJPhotoTool *)photoTool didFinishPickingMediaWithImage:(UIImage *)image{
    _photoImageViw.image = image;
}
// 保存相片的代理
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error{
    NSLog(@"保存照片成功");
}

@end
