# JHOptionView
非常好用的选择器
在开发中像填写用户资料页面，很常用到各种各样的选择器，我现在所做的项目也不另外，也有自己的一套选择器组件。
先看看效果: 

![选择器.gif](http://upload-images.jianshu.io/upload_images/3950574-461e38346d7815a2.gif?imageMogr2/auto-orient/strip)  

用法非常易用和灵活:  

```
// 1、创建控件
- (JHNormalOptionView *)normalOptionView {
    if (_normalOptionView) return _normalOptionView;
   _normalOptionView = [[JHNormalOptionView alloc] initWithFrame:self.view.bounds];
    return _normalOptionView;
}
// 2、添加view
[self.view addSubview:self.normalOptionView];
// 3、灵活的显示想要的选择器
[self.normalOptionView setTitle:@"请选择字母" datas:@[@"a", @"b", @"c", @"d"] selectRow:2];
        [self.normalOptionView show];
        WeakSelf;
        self.normalOptionView.verifyBlock = ^{
            NSLog(@"%@ %zd",weakSelf.normalOptionView.selectTitle, weakSelf.normalOptionView.selectRow);
        };
```
有问题欢迎issues，若项目对你有用还望不吝给个star让我动力十足😀
