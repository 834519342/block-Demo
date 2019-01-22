//
//  MyBlockDemo.h
//  block-Demo
//
//  Created by xt on 2019/1/22.
//  Copyright © 2019 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBlockDemo : NSObject

- (MyBlockDemo * (^)(int))block_1;

- (MyBlockDemo *)block_2;

- (MyBlockDemo * (^)(int))block_3;

@end

NS_ASSUME_NONNULL_END
