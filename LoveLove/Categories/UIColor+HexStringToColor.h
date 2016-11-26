//
//  UIColor+HexStringToColor.h
//  anz
//
//  Created by KevinCao on 16/6/28.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexStringToColor)
+(UIColor *)hexStringToColor:(NSString *)stringToConvert;
+(UIColor *)skBackgroundColor;
+(UIColor *)skThemeColor;
@end
