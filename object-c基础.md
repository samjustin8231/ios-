## 第一个Object-c程序—HelloWorld

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

**注意：**

1. 首先#import是一个导入命令，类似于C语言的#include命令，但是相对于#include而言，#import有效的处理了重复导入的问题，在C语言中也提到过如何通过条件编译解决重复导入，而在ObjC中你不需要处理了，#import已经自动进行了重复处理；与#include类似，导入系统类库使用<>，导入自定义类库使用””；
2. Foundation.h是Foundation框架中的头文件，这是ObjC中的一个基础类库，基本上后面我们用到的所有ObjC的代码都需要引入这个类库；
3. @autoreleasepool是ObjC的关键字，它的作用是对包含在这个关键字后面大包括内的程序会自动进行内存回收，不需要开发人员手动释放无用的对象；当然表面上看起来这有点类似于C#和Java的内存垃圾回收机制，但是事实上他们的原理完全不同，以后再做具体解释。
4. NSLog是标准输出函数，类似于C语言中的printf()函数，但是它会自动换行，当然它同样支持格式输出（例如%i表示输出整形数据，%f输出浮点型数据），这个函数在Fundation.h中声明；
5. @”Hello,World!”,是一个字符串常量，在ObjC中字符串前需要使用@符号；

**扩展**

- ObjC中没有命名空间(C#)或包（Java）的概念，那也就是说在同一个应用中不能同时存在两个完全相同的类名，通常情况下我们通过前缀加以区分，例如在ObjC中的NSString、NSLog中的NS就是前缀。
- ObjC中很多关键字都是以@开头（例如@autoreleasepool、@interface、@protocol），另外需要注意的是为了区分C语言中的字符串，ObjC中的字符串也必须加上@。

## 基本数据类型

基本数据类型除了C语言中的char、int、float、double之外，

1. BOOL类型，包含两个值YES和NO，其实ObjC中的布尔类型就是整数1和0；

2. id类型，是一个对象类型，可以表示所有对象；

3. NSString是Fundation框架中定义的字符串类型；

   ![](http://images.cnitblog.com/blog/62046/201407/222021496356451.png)


**注意**

1.在C或者ObjC中整形可以使用%i也可以使用%d来格式化，只有使用scanf()输入的时候二者才有区别（由于%d始终被编译器解释为decimal intergeer所以即使输入010会被认为是整形10，而%i则会将前面的0或者0x认为此输入是八进制或十六进制整数）;

2.%p本质就是输出指针地址，在32位编译器下对于一个指针类型使用%x输出和%p输出其实是一样的，只是后者会在前面加上“ox”（注意在64位编译器下由于指针长度8byte，而整形只有4byte所以%x输出的内容只是%p的低位数据）；



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

- **.h文件：**放类的声明，包括成员变量、属性和方法声明（事实上.h文件不参与编译过程）；关键字@interface声明一个类，同时它必须以@end结束，在这两个关键字中间声明相关成员；在声明Person类的同时可以看到它继承于NSObject，这是ObjC的基类，所有的类最终都继承于这个类（但是需要注意ObjC中的基类或者根类并不只有一个，例如NSProxy也是ObjC的基类），由于这个类在Foundation框架中定义，所以导入了<Foundation/Foundaton.h>（这么描述的意思是导入Foundation框架中的Foundation.h声明文件）；
- **.m文件：**放属性、方法的具体实现；关键字@implementation用于实现某个类，同时必须以@end结尾，在这两个关键字中间实现具体的属性、方法；由于.m中使用了Person类，所以需要导入声明文件“Person.h”；

## 2.成员变量

```
Person.h
#import <Foundation/Foundation.h>//由于使用了NSObject，所以导入此头文件

//NSObject是基类，Person实现了NSObject
@interface Person : NSObject{
    /*成员变量必须包含在大括号中
     *注意成员变量不声明任何关键字的话是默认可访问性@Protected
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

访问权限

成员变量定义在.h文件中，同时必须定义在类后面的{}内。成员的可访问性通过下面三个关键字声明：

- @private 私有成员，只有当前类可以访问；
- @protected 受保护成员，只有当前类或子类可以访问（如果没有添加任何修饰则默认为@protected）；
- @public 公共成员，所有类均可访问；

## 3.方法和属性

在ObjC中方法分为静态方法和动态方法两种，动态方法就是对象的方法，静态方法就是类方法，这一点跟其他高级语言没有区别。在ObjC中使用“-”定义动态方法，使用“+”定义静态方法。如果一个方法在.h中有声明则该方法是公共方法，如果没有在.h中声明直接在.m中定义则该方法是私有方法，外部无法访问。

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

self.name=name本身就会调用Person的setName方法，如此反复就会造成循环操作，所有一般如果需要重写setter方法，可以直接写成_name=name,由此我们也可以看到为什么之前即使没有使用@property生成对应的属性方法，在定义成员变量时也都加上了下划线（这是一好的编码习惯）。

## 5.构造方法

```
#import <Foundation/Foundation.h>

@interface Person : NSObject

@property NSString *name;
@property int age;

-(id)initWithName:(NSString *)name andAge:(int )age;

@end
```

```
#import "Person.h"

@implementation Person

//自定义构造方法
-(id)initWithName:(NSString *)name andAge:(int)age{
    if(self=[super init]){ //super代表父类,通过调用父类的方法给当前对象赋值，然后判断这个对象是否为nil，如果不为空则依次给name、age属性赋值。
        self.name=name;
        self.age=age;
    }
    return self;
}

@end
```

**扩展**

通过自定义构造方法固然可以简化代码，但是在使用时还要手动申请内存，在ObjC中一般我们通过定义一个静态方法来解决这个问题

```
#import <Foundation/Foundation.h>

@interface Person : NSObject

@property NSString *name;
@property int age;

-(id)initWithName:(NSString *)name andAge:(int )age;

+(id)personWithName:(NSString *)name andAge:(int )age;
@end
```

```
#import "Person.h"

@implementation Person

//自定义构造方法
-(id)initWithName:(NSString *)name andAge:(int)age{
    if(self=[super init]){ //super代表父类
        self.name=name;
        self.age=age;
    }
    return self;
}

//通过静态方法获得一个对象
+(id)personWithName:(NSString *)name andAge:(int)age{
    Person *p=[[Person alloc]initWithName:name andAge:age];
    return p;
}
@end
```

```
#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    
    Person *p=[[Person alloc]initWithName:@"Kenshin" andAge:28];
    NSLog(@"name=%@,age=%i",p.name,p.age);
    //结果：name=Kenshin,age=28
    
    Person *p2=[Person personWithName:@"Kaoru" andAge:27];
    NSLog(@"name=%@,age=%i",p2.name,p2.age);
    //结果：name=Kaoru,age=27
    return 0;
}
```

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

person.h

```
#import <Foundation/Foundation.h>

@interface Person : NSObject{
    @protected
    NSString *_nation;
}

#pragma mark - 属性
#pragma mark 姓名
@property (nonatomic,copy) NSString *name;
#pragma mark 年龄
@property (nonatomic,assign) int age;
#pragma mark 籍贯
@property (nonatomic,copy) NSString *nation;

#pragma mark - 动态方法
#pragma mark 带有参数的构造函数
-(id)initWithName:(NSString *)name andAge:(int )age;

#pragma mark - 静态方法
#pragma mark 通过静态方法返回一个对象
+(id)personWithName:(NSString *)name andAge:(int )age;

@end
```

Person.m

```
#import "Person.h"

@implementation Person

#pragma mark - 动态方法
#pragma mark 带有参数的构造函数
-(id)initWithName:(NSString *)name andAge:(int)age{
    if(self=[super init]){ //super代表父类
        self.name=name;
        self.age=age;
    }
    return self;
}

#pragma mark - 静态方法
#pragma mark 通过静态方法返回一个对象
+(id)personWithName:(NSString *)name andAge:(int)age{
    Person *p=[[Person alloc]initWithName:name andAge:age];
    return p;
}

#pragma mark - 重写方法
#pragma mark 重写description
-(NSString *)description{
    return [NSString stringWithFormat:@"{name:%@,age:%i}",self.name,self.age];
}

@end
```

Student.h

```
#import "Person.h"

@interface Student : Person

#pragma mark - 属性
#pragma mark 分数
@property (nonatomic,assign) float score;

#pragma mark - 动态方法
#pragma mark 带有参数的构造函数
-(id)initWithName:(NSString *)name andAge:(int )age andScore:(float)score;

#pragma mark - 静态方法
#pragma mark 通过静态方法返回一个对象
+(id)studentWithName:(NSString *)name andAge:(int )age andScore:(float)score;

@end
```

Student.m

```
#import "Student.h"

@implementation Student

#pragma mark - 动态方法
#pragma mark 带有参数的构造函数
-(id)initWithName:(NSString *)name andAge:(int )age andScore:(float)score{
    if(self=[super initWithName:name andAge:age]){
        self.score=score;
    }
    return self;
}

#pragma mark - 静态方法
#pragma mark 通过静态方法返回一个对象
+(id)studentWithName:(NSString *)name andAge:(int)age andScore:(float)score{
    Student *s=[[Student alloc]initWithName:name andAge:age andScore:score];
    return s;
}

#pragma mark - 重写方法
#pragma mark 重写description
-(NSString *)description{
    return [NSString stringWithFormat:@"{name:%@,age:%i,nation:%@,scroe:%.2f}",self.name,self.age,self->_nation,self.score]; //注意这里访问了父类的属性和方法
}

@end
```

Main.m

```
#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    
    Person *p=[Person personWithName:@"Kenshin" andAge:28];
    NSLog(@"p=%@",p);
    
    Student *s=[Student studentWithName:@"Kaoru" andAge:27 andScore:100];
    s.nation=@"henan";
    NSLog(@"s=%@",s);
    
    
    return 0;
}
```

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

person.m

```
#import "Person.h"

@implementation Person

-(void)eat{
    NSLog(@"eating...");
}

@end
```

这里需要说明几点：

1. 一个协议可以扩展自另一个协议，例如上面AnimalDelegate就扩展自NSObject，如果需要扩展多个协议中间使用逗号分隔；
2. 和其他高级语言中接口不同的是协议中定义的方法不一定是必须实现的，我们可以通过关键字进行@required和@optional进行设置，如果不设置则默认是@required（注意ObjC是弱语法，即使不实现必选方法编译运行也不会报错）；
3. 协议通过<>进行实现，一个类可以同时实现多个协议，中间通过逗号分隔；
4. 协议的实现只能在类的声明上,不能放到类的实现上（也就是说必须写成@interface Person:NSObject<AnimalDelegate>而不能写成@implementation Person<AnimalDelegate>）；
5. 协议中不能定义属性、成员变量等,只能定义方法；

事实上在ObjC中协议的更多作用是用于约束一个类必须实现某些方法，而从面向对象的角度而言这个类跟接口并不一定存在某种自然关系，可能是两个完全不同意义上的事物,这种模式我们称之为代理模式（Delegation）。在Cocoa框架中大量采用这种模式实现数据和UI的分离，而且基本上所有的协议都是以Delegate结尾。



按钮点击事件

但是在ObjC中没有事件的定义，而是使用代理来处理这个问题。首先在按钮中定义按钮的代理，同时使用协议约束这个代理（事件的触发者）必须实现协议中的某些方法，当按钮处理过程中查看代理是否实现了这个方法，如果实现了则调用这个方法。

KCButton.h

```
#import <Foundation/Foundation.h>
@class KCButton;

//一个协议可以扩展另一个协议，例如KCButtonDelegate扩展了NSObject协议
@protocol KCButtonDelegate <NSObject>

@required //@required修饰的方法必须实现
-(void)onClick:(KCButton *)button;

@optional //@optional修饰的方法是可选实现的
-(void)onMouseover:(KCButton *)button;
-(void)onMouseout:(KCButton *)button;

@end

@interface KCButton : NSObject

#pragma mark 代理属性，同时约定作为代理的对象必须实现KCButtonDelegate协议
@property (nonatomic,retain) id<KCButtonDelegate> delegate;

#pragma mark 点击方法
-(void)click;

@end
```

KCButton.m

```
#import "KCButton.h"

@implementation KCButton

-(void)click{
    NSLog(@"Invoke KCButton's click method.");
    //判断_delegate实例是否实现了onClick:方法（注意方法名是"onClick:",后面有个:）
    //避免未实现ButtonDelegate的类也作为KCButton的监听
    if([_delegate respondsToSelector:@selector(onClick:)]){
        [_delegate onClick:self];
    }
}

@end
```

MyListener.h

```
#import <Foundation/Foundation.h>
@class KCButton;
@protocol KCButtonDelegate;

@interface MyListener : NSObject<KCButtonDelegate>
-(void)onClick:(KCButton *)button;
@end
```

MyListener.m

```
#import "MyListener.h"
#import "KCButton.h"

@implementation MyListener
-(void)onClick:(KCButton *)button{
    NSLog(@"Invoke MyListener's onClick method.The button is:%@.",button);
}
@end
```

mian.m

```
#import <Foundation/Foundation.h>
#import "KCButton.h"
#import "MyListener.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        KCButton *button=[[KCButton alloc]init];
        MyListener *listener=[[MyListener alloc]init];
        button.delegate=listener;
        [button click];
        /* 结果：
         Invoke KCButton's click method.
         Invoke MyListener's onClick method.The button is:<KCButton: 0x1001034c0>.
         */
    }
    return 0;
}
```

我们通过例子模拟了一个按钮的点击过程，有点类似于Java中事件的实现机制。通过这个例子我们需要注意以下几点内容：

1. id可以表示任何一个ObjC对象类型，类型后面的”<协议名>“用于约束作为这个属性的对象必须实现该协议(注意：使用id定义的对象类型不需要加“*”)；
2. MyListener作为事件触发者，它实现了KCButtonDelegate代理（在ObjC中没有命名空间和包的概念，通常通过前缀进行类的划分，“KC”是我们自定义的前缀）
3. 在.h文件中如果使用了另一个文件的类或协议我们可以通过@class或者@protocol进行声明，而不必导入这个文件，这样可以提高编译效率（注意有些情况必须使用@class或@protocol，例如上面KCButton.h中上面声明的KCButtonDelegate协议中用到了KCButton类，而此文件下方的KCButton类声明中又使用了KCButtonDelegate，从而形成在一个文件中互相引用关系，此时必须使用@class或者@protocol声明，否则编译阶段会报错），但是在.m文件中则必须导入对应的类声明文件或协议文件（如果不导入虽然语法检查可以通过但是编译链接会报错）；
4. 使用respondsToSelector方法可以判断一个对象是否实现了某个方法（需要注意方法名不是”onClick”而是“onClick:”，冒号也是方法名的一部分）；