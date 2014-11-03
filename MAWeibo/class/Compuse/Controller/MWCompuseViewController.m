//
//  MWCompuseViewController.m
//  MAWeibo
//
//  Created by admin on 14-11-2.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWCompuseViewController.h"
#import "MWComposeTextView.h"
#import "AFNetworking.h"
#import "MWAccount.h"
#import "MBProgressHUD+MW.h"
#import "MWComposeToolBar.h"
#import "IWHttpTool.h"
#import "MWComposePhotoView.h"


@interface MWCompuseViewController ()<UITextViewDelegate, MWComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MWComposePhotoViewDelegate>
// 编写微博视图
@property (nonatomic ,weak) MWComposeTextView *textView;
// 工具视图
@property (nonatomic ,weak) MWComposeToolBar *toolBar;

@property (nonatomic ,weak) MWComposePhotoView *imageView;
@end

@implementation MWCompuseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.title = @"发微博";
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 初始化textView视图
    MWComposeTextView *textView = [[MWComposeTextView alloc]initWithFrame:self.view.frame];
    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
    
    // 设置textView一直可以滚动
    textView.alwaysBounceVertical = YES;
    // 设置代理
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    self.textView = textView;
    [MWNotificationCenter addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:textView];
    
    // 初始化toolbar视图
    MWComposeToolBar *toolBar = [[MWComposeToolBar alloc]init];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    // 设置代理
    toolBar.delegate = self;
    CGFloat toolBarX = 0;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarH = 44;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    [MWNotificationCenter addObserver:self selector:@selector(keyBoardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 初始化选择图片
    MWComposePhotoView *imageView = [[MWComposePhotoView alloc]initWithFrame:CGRectMake(10, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.textView addSubview:imageView];
    imageView.degelate = self;
    self.imageView = imageView;
    
}


- (void)keyBoardFrameChanged:(NSNotification *)note
{

    // 如果y = YES 键盘出现
    BOOL y  = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y < [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y;
    // 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (y) {
        // 1.取出键盘的frame
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 3.执行动画
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
        }];
    }else{
        // 2.执行动画
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    }
    
}

/**
 *  textView的文字变化
 */
- (void)textChanged
{
    // 有内容,发送键可以点击
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 *  发送
 */
- (void)send
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 1. 封装请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    MWAccount *account = [MWAccount account];
    dict[@"access_token"] = account.access_token;
    dict[@"status"] = self.textView.text;
    if (self.imageView.images.count) {
     
        // 2. 发送请求
        [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (UIImageView *imageView in self.imageView.images) {
                NSData *data = UIImageJPEGRepresentation(imageView.image, 0.0001);
                [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD showSuccess:@"发送成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"发送失败"];
        }];
    }else{
        // 2. 发送请求
        [IWHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:dict success:^(id json) {
            [MBProgressHUD showSuccess:@"发送成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"发送失败"];
        }];
        }
    // 3. 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [MWNotificationCenter removeObserver:self];
}
/**
 *  在DidAppear中显示键盘
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.textView becomeFirstResponder];
}

#pragma mark - textView的代理方法
- (void)composeToolBar:(MWComposeToolBar *)toolBar ButtonType:(MWComposeToolBarButtonType)type
{
    switch (type) {
        case MWComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case MWComposeToolBarButtonTypePicture:
            [self openPictureLibrary];
            break;
        default:
            break;
    }
}

#pragma mark - photoView的代理方法
- (void)composePhotoViewAddButton:(MWComposePhotoView *)toolBar
{
    [self openPictureLibrary];
}
/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
/**
 *  打开照片
 */
- (void)openPictureLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.imageView addImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
