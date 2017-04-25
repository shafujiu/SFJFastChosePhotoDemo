# SFJFastChosePhotoDemo
相机 相册的快速选取的工具类

封装照片 相机选取的逻辑，通过block传递UIImagePickerController对象

```Objective-c
// 获取工具
+ (instancetype)shareTool;
// 拍照
- (void)takePhotoSuccess:(void (^)(UIImagePickerController *picker))success failed:(void (^)())failed;
// 选择照片
- (void)selectPhotoSuccess:(void (^)(UIImagePickerController *picker))success failed:(void (^)())failed;
```

通过代理我们可以监听拾取照片 以及拍照的保存照片的状态
```Objective-c
// 选择相片的代理
- (void)photoTool:(SFJPhotoTool *)photoTool didFinishPickingMediaWithImage:(UIImage *)image;
// 保存相片的代理
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error;
```
