//
//  DataParser.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "DataParser.h"

@implementation DataParser

+ (NSDictionary *)parseOpenAPIResult:(NSData *)responseData {
    if(responseData == nil)
        return nil;
    
    NSDictionary *resultDict = nil;
    NSError * error = nil;
    NSData *finalData = nil;
    
    @autoreleasepool {
        NSString *filteredStr = nil;
        NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (str && ![str isKindOfClass:[NSNull class]]) {
            filteredStr = [self removeUnescapedCharacter:str];
            finalData = [filteredStr dataUsingEncoding:NSUTF8StringEncoding];
        }
        else {
            finalData = nil;
        }
    }
    if (!finalData) {
        return nil;
    }
    resultDict = [NSJSONSerialization JSONObjectWithData:finalData options:0 error:&error];
    return resultDict;
}

+ (NSString *)removeUnescapedCharacter:(NSString *)inputStr {
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound) {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
}

@end
