//
//  MyBlockDemo.m
//  block-Demo
//
//  Created by xt on 2019/1/22.
//  Copyright © 2019 TJ. All rights reserved.
//

#import "MyBlockDemo.h"

@implementation MyBlockDemo

- (MyBlockDemo * _Nonnull (^)(int))block_1
{
    MyBlockDemo * (^myBlock)(int) = ^(int a){
        NSLog(@"%d", a);
        return self;
    };
    return myBlock;
}

- (MyBlockDemo *)block_2
{
    return self;
}

- (MyBlockDemo * _Nonnull (^)(int))block_3
{
    return ^(int a){
        NSLog(@"%d", a);
        return self;
    };
}

@end
