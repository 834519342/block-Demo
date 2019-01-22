//
//  ViewController.m
//  block-Demo
//
//  Created by xt on 2019/1/21.
//  Copyright © 2019 TJ. All rights reserved.
//

/*
 * block三种类型:
 * 全局块(_NSConcreteGlobalBlock)存在于全局内存中,相当于单例
 * 栈块(_NSConcreteStackBlock)存在于栈内存中,超出其作用域则马上被销毁
 * 堆块(_NSConcreteMallocBlock)存在于堆内存中,是一个带引用计数的对象,需要自行管理其内存
 */

/*
 * 判断block的存储位置
 * 1.block不访问外界变量(包括栈中和堆中)
 * block为全局块
 
 * 2.block访问外界变量
 * MRC环境:访问外界变量的block默认存储栈中
 * ARC环境:访问外界变量的block默认存储在堆中(实际是放在栈区,然后ARC情况下自动拷贝到堆区),自动释放
 */

#import "ViewController.h"
#import "MyBlockDemo.h"

typedef void(^MyBlockSix)(void);

@interface ViewController ()

@property (nonatomic, copy) MyBlockSix myBlockSix;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self block];
//    [self block_1];
//    [self block_2];
//    [self block_3];
    [self block_5];
}

/*
 * block定义与使用
 */
- (void)block
{
    //无参数,无返回值
    void(^MyBlockOne)(void) = ^(void){
        NSLog(@"无参数,无返回值");
    };
    MyBlockOne();
    
    //有参数,无返回值
    void(^MyBlockTwo)(int a) = ^(int a){
        NSLog(@"参数:%d,无返回值", a);
    };
    MyBlockTwo(1);
    
    //有参数,有返回值
    int(^MyBlockThree)(int, int) = ^(int a, int b){
        NSLog(@"参数:%d + %d", a, b);
        return a+b;
    };
    int s = MyBlockThree(1,2);
    NSLog(@"返回值:%d", s);
    
    //无参数,有返回值
    int(^MyBlockFour)(void) = ^{
        return 1;
    };
    s = MyBlockFour();
    NSLog(@"返回值:%d", s);
    
    //实际开发中常用typedef定义block
    typedef int(^MyBlock)(int, int);
    MyBlock myBlockFive;
    myBlockFive = ^(int a, int b){
        NSLog(@"参数:%d, %d", a, b);
        return a + b;
    };
    s = myBlockFive(10, 20);
    NSLog(@"返回值:%d", s);
}

/*
 * block与外界变量
 * 局部变量存放在栈空间,block里面不能改变局部变量的值
 * 使用__block修饰,局部变量会被拷贝到堆空间使用,block里面可以改变变量的值
 */
- (void)block_1
{
//    int age = 10;
    __block int age = 10;
    void(^MyBlock)(void) = ^{
        age = 20;
        NSLog(@"block:age = %d, %p", age, &age);
    };
    age = 18;
    NSLog(@"局部:age = %d, %p", age, &age);
    MyBlock();
    NSLog(@"局部:age = %d, %p", age, &age);
}

/*
 * 防止block循环引用
 * ARC下:使用__weak
 * MRC下:使用__block,用完需要手动释放
 * block里面用__strong修饰,生命周期和当前block块相同
 */
- (void)block_2
{
    __weak typeof(self) weakSelf = self;
//    __block typeof(self) blockSelf = self;
    self.myBlockSix = ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf test_1];
        [weakSelf test_1];
//        blockSelf = nil;
    };
    self.myBlockSix();
}

- (void)test_1
{
    NSLog(@"test_1");
}

/*用法*/
- (void)block_3
{
//    block作为变量(Xcode自动补全:inlineBlock)
//    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };
    
//    block作为属性(Xcode自动补全:typedefBlock)
//    typedef <#returnType#>(^<#name#>)(<#arguments#>);
    
//    作为方法参数
    [self block_4:^int(int a, int b) {
        return a + b;
    }];
}

//作为方法参数
- (void)block_4:(int(^)(int a,int b))block
{
    NSLog(@"%d", block(1,2));
}

//链式编程
- (void)block_5
{
    [MyBlockDemo new].block_1(1).block_2.block_3(2);
}

@end
