## Helloworld

```
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {//自动释放内存
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
```

## 基本数据类型

基本数据类型除了C语言中的char、int、float、double之外，

1. BOOL类型，包含两个值YES和NO，其实ObjC中的布尔类型就是整数1和0；
2. id类型，是一个对象类型，可以表示所有对象；
3. NSString是Fundation框架中定义的字符串类型；



# 一、类和对象

## 1.类定义

Person.h

```
#import <Foundation/Foundation.h>
@interface Person : NSObject
@end
```

在声明Person类的同时可以看到它继承于NSObject，这是ObjC的基类，所有的类最终都继承于这个类

Person.m

```
#import "Person.h"
@implementation Person
@end
```

在ObjC中定义一个类需要两个文件.h和.m：

## 2.成员变量

```
Person.h
#import <Foundation/Foundation.h>//由于使用了NSObject，所以导入此头文件

//NSObject是基类，Person实现了NSObject
@interface Person : NSObject{
    /*注意成员变量不声明任何关键字的话是默认可访问性@Protected
     *注意在ObjC中不管是自定义的类还是系统类对象都必须是一个指针，例如下面的_name
     */
    @private
    NSString *_name;//在ObjC中推荐成员变量名以_开头
    int _age;
    @protected
    NSString *_nation;
    @public
    float height;
}
@end
```

```
main.m
#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p=[Person alloc];
        p=[p init];
        //上面两句代码可以直接写成：Person *p=[[Person alloc] init];
        //还可以写成：Person *p=[Person new];
        
        p->height=1.72;
        NSLog(@"height=%.2f",p->height);//结果：height=1.72
    }
    return 0;
}
```

- ObjC中所有的对象类型的变量都必须加上“*”,在ObjC中对象其实就是一个指针（例如之前看到的NSString也是如此，但是基本类型不用加”*”）；
- ObjC中使用[]进行方法调用，在ObjC中方法调用的本质就是给这个对象或类发送一个消息；
- 在ObjC中类的实例化需要两个步骤：分配内存、初始化；
- 类的初始化调用了父类的init方法，如果使用默认初始化方法进行初始化（没有参数），内存分配和初始化可以简写成[Person new]；

## 3.方法和属性

在ObjC中使用“-”定义动态方法，使用“+”定义静态方法。

```
//声明一个动态方法，没有返回值
-(void)setName:(NSString *)name;
//声明一个静态方法，没有返回值
+(void)showMessage:(NSString *)info;
```

但是在ObjC中gettter方法通常使用变量名，而不加“get”

```
//声明age的setter、getter方法
-(int)age;
-(void)setAge:(int)age;
```

具体的调用：

```
mport <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p=[Person alloc];
        p=[p init];
        //上面两句代码可以直接写成：Person *p=[[Person alloc] init];
        //还可以写成：Person *p=[Person new];
        
        //成员变量调用
        p->height=1.72;
        NSLog(@"height=%.2f",p->height);//结果：height=1.72
        
        //方法调用
        [p setName:@"Kenshin"];
        
        //属性调用
        p.age=28; //等价于：[p setAge:28];
        int age=p.age;//等价于：age=[p age];
        NSLog(@"age=%i",age); //结果：age=28
        
    }
    return 0;
}
```

### 属性

其实在ObjC中可以通过声明@property，同时通过@synthesize自动生成getter、setter方法（在新版本中甚至甚至都不用通过@synthesize只声明就可以使用）

Person.h

```
#import <Foundation/Foundation.h>
@interface Person : NSObject{
    @public
    NSString *birthday;
    NSString *_position;
    NSString *_degress;
}
@property NSString *birthday;
@property NSString *position;
@property NSString *degress;
@property NSString *education;
@property float weight;
-(void)printInfo;
@end
```

Person.m

```
#import "Person.h"

@implementation Person

@synthesize birthday;
@synthesize position;
@synthesize degress=_degress;

@synthesize education;

-(void)printInfo{
    NSLog(@"_weight=%.2f",_weight);
    NSLog(@"education=%@",education);
    NSLog(@"_degress=%@",_degress);
}
@end
```

Main.m

```
int main(int argc, const char * argv[]) {
    
    Person *p=[[Person alloc]init];
    p->birthday=@"1987-08-20";
    p.birthday=@"1986-08-08";
    p->_position=@"developer";
    p.position=@"architect";
    
    p.degress=@"undergraduate";
    
    p.education=@"university";
    
    p.weight=60.0;
    
    NSLog(@"p->birthday=%@,p.birthday=%@",p->birthday,p.birthday);
    //结果:p->birthday=1986-08-08,p.birthday=1986-08-08
    
    NSLog(@"p->_position=%@,p.position=%@",p->_position,p.position);
    //结果：p->_position=developer,p.position=architect
    
    NSLog(@"p.weight=%.2f",p.weight);
    //结果：p.weight=60.00
    [p printInfo];
    /*结果：
     _weight=60.00
     education=university
     _degress=undergraduate*/
    
    return 0;
}
```

属性生成规则，总结如下：

- 如果只声明一个属性a，不使用@synthesize实现：编译器会使用_a作为属性的成员变量（如果没有定义成员变量_a则会自动生成一个私有的成员变量_a；如果已经定义了成员变量_a则使用自定义的成员变量_a。注意：如果此时定义的成员变量不是_a而是a则此时会自动生成一个成员变量_a，它跟自定义成员变量a没有任何关系）；
- 如果声明了一个属性a，使用**@synthesize a**进行实现，但是实现过程中没有指定使用的成员变量（例如上面birthday）：则此时编译器会使用a作为属性的成员变量（如果定义了成员变量a，则使用自定义成员变量；如果此时没有定义则会自动生成一个私有的成员变量a，注意如果此时定义的是_a则它跟生成的a成员变量没有任何关系）；
- 如果声明了一个属性a，使用**@synthesize a=_a**进行实现，这个过程已经指定了使用的成员变量：此时会使用指定的成员变量作为属性变量；

有了上面的总结，相信理解上面的代码并不难，通常在实际开发过程中我们要么直接在@property中声明不使用@synthesize；要么使用过程中指定具体的成员变量。

## 4.self关键字

其实在ObjC中也有一个类似的关键字self，只是self不仅可以表示当前对象还可以表示类本身，也就是说它既可以用在静态方法中又可以用在动态方法中。

## 5.构造方法

## 6.description方法

在C#中每个类都有一个ToString()方法（java中叫做toString()）用于打印一个对象的信息，在ObjC中这个方法叫description

```
-(NSString *)description{
    return [NSString stringWithFormat:@"{name:%@,age:%i}",self.name,self.age];
}

mian.m
Person *p=[[Person alloc]init];
p.name=@"Kenshin";
p.age=28;

NSLog(@"%@",p);//此时会调用对象description方法返回对应的描述信息
/*结果：
name:Kenshin,age:28}
*/
```

注意上面NSLog中的格式符是%@，当使用%@输出一个对象时，ObjC会调用个对象的description返回对应的信息进行输出，默认情况下如果我们不重写description方法，输出内容是类名和地址，例如Person则输出“<Person: 0x100202310>”。

需要强调的是千万不要在description中打印输出self，因为当输出self时会调用该对象的description方法，如此一来就会造成死循环。

## 7.继承



# 二、协议、代码块、分类



## 1.协议

协议类似于Java与C#语言中的"接口"

AnimalDeletage.h

```
//定义一个协议
@protocol AnimalDelegate <NSObject>

@required //必须实现的方法
-(void)eat;

@optional //可选实现的方法
-(void)run;
-(void)say;
-(void)sleep;

@end
```

Person.h

```
#import <Foundation/Foundation.h>
#import "AnimalDelegate.h"
@interface Person : NSObject<AnimalDelegate>
-(void)eat;
@end
```

这里需要说明几点：

1. 一个协议可以扩展自另一个协议，例如上面AnimalDelegate就扩展自NSObject，如果需要扩展多个协议中间使用逗号分隔；
2. 和其他高级语言中接口不同的是协议中定义的方法不一定是必须实现的，我们可以通过关键字进行@required和@optional进行设置，如果不设置则默认是@required（注意ObjC是弱语法，即使不实现必选方法编译运行也不会报错）；
3. 协议通过<>进行实现，一个类可以同时实现多个协议，中间通过逗号分隔；
4. 协议的实现只能在类的声明上,不能放到类的实现上（也就是说必须写成@interface Person:NSObject<AnimalDelegate>而不能写成@implementation Person<AnimalDelegate>）；
5. 协议中不能定义属性、成员变量等,只能定义方法；