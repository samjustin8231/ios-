



## 快捷键

自动补全：esc





## Interface Builder
图形化开发工具
支持格式
.nib（旧）
.xib（新）

### IBOutLet

### IBAction

## 设备尺寸



## UIViewController

程序获取控件方式：

1)通过拖拽IBOutlet连接

2)通过tag

```
UILabel *label = [self.view viewWithTag:12222];
```





## other

@class和#import 区别

```
总结，@class class1只是告诉编译器，class1是一个类，你不要以为class1是个未声明的野种，除此之外，没了。
但是 #import "class1.h"会告诉编译器，class1这个类中有什么东西，即class1.h中包含的函数和变量。
所以.h中使用@class绰绰有余，若你有需要创建或访问class1中的函数和变量，则必须使用#import。
```




