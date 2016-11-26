//
//  NSObject+PerformBlockAfterDelay.h
//  anz
//
//  Created by KevinCao on 16/7/6.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlockAfterDelay)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end
