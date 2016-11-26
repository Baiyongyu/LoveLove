//
//  ANZUtil.h
//  anz
//
//  Created by KevinCao on 16/6/29.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

const static NSString *emailRegex = @"[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,6}+(\\.[a-zA-Z][a-zA-Z\\-]{0,6})+";
const static NSString *phoneNumberRegex = @"(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?([0-9][0-9\\- \\.]+[0-9])";
const static NSString *websiteRegex = @"((http|https|Http|Https|rtsp|Rtsp|http|www|ftp)://)?(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";

#import <Foundation/Foundation.h>

@interface QMUtil : NSObject

/**
 *  获取文件路径
 *
 *  @param fileName                 文件名
 *  @param shouldCreateWhenNotExist 当文件不存在时是否创建
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName shouldCreateWhenNotExist:(BOOL)shouldCreateWhenNotExist;

/**
 *  忽略文件备份
 *
 *  @param URL 文件路径
 *
 *  @return 是否成功
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

/**
 *  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  检查手机号码是否合法
 *
 *  @param mobileNumber 手机号码
 *
 *  @return 是否合法
 */
+(BOOL)checkMoblieNumber:(NSString *)mobileNumber;

/**
 *  校验字符串
 *
 *  @param data 校验对象
 *
 *  @return 字符串结果
 */
+(NSString*)checkString:(NSObject *)data;

/**
 *  校验数字
 *
 *  @param number 校验对象
 *
 *  @return 数字
 */
+(NSNumber*)checkNumber:(NSNumber*)number;

/**
 *  校验数组
 *
 *  @param array 校验对象
 *
 *  @return 数组
 */
+(NSArray*)checkArray:(NSArray*)array;

/**
 *  浮点数处理并去掉多余的0
 *
 *  @param doubleValue 浮点数
 *
 *  @return
 */
+(NSString *)stringDisposeWithDouble:(double)doubleValue;

/**
 *  根据表名清空数据库表
 *
 *  @param entityName 表名
 */
//+(void)deleteCoreDataWithEntity:(NSString*)entityName;

/**
 *  隐藏键盘
 */
+(void)hiddenKeyboard;

/**
 *  sha512加密
 *
 *  @param string 原始数据
 *
 *  @return 加密数据
 */
+(NSString *)sha512Encode:(NSString *)string;

/**
 *  获取版本号
 *
 *  @return 版本号
 */
+(NSString *)getVersionCode;

/**
 *  根据系统版本获取默认细黑字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+(UIFont *)getXiHeiFont:(CGFloat)fontSize;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 *
 *  @return
 */
+(BOOL)call:(NSString *)phoneNumber;

/**
 *  获取view的view controller
 *
 *  @param view 当前view
 *
 *  @return 当前view所在view controller
 */
+ (UIViewController *)getViewControllerFromView:(UIView *)view;

/**
 *  判断字符串是否是网址
 *
 *  @param text
 *
 *  @return
 */
+ (BOOL)detectWebsite:(NSString *)text;

/**
 *  压缩图片
 *
 *  @param sourceImage 原始图片
 *  @param defineSize  压缩尺寸
 *
 *  @return 压缩后的图片
 */
+(UIImage *)imageCompressForImage:(UIImage *)sourceImage targetSize:(CGFloat)defineSize;

//截屏
+ (UIImage *)screenShot:(UIView *)view;

//获取字符窜大小
+(CGSize)getSizeWithText:(NSString*)text fontSize:(int)fontSize;
+(CGSize)getSizeWithText:(NSString*)text font:(UIFont*)font;
+(CGSize)getSizeWithText:(NSString*)text boldfontSize:(int)fontSize;
+(CGSize)sizeWithString:(NSString*) string  font:(UIFont*)font size:(CGSize)size;
+(CGSize)sizeWithString:(NSString*) string  attribute:(NSDictionary*)attribute size:(CGSize)size;
+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText font:(UIFont*)font;
+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText attribute:(NSDictionary*)attribute;
+(float)heightForTextViewSize:(CGSize)size  withAttributeText: (NSAttributedString *) attributeStrText;
//获取NSAttributed字符窜大小
+(CGSize)sizeWithString:(NSAttributedString*)attrStr size:(CGSize)size;
//MD5加密
+(NSString *)MD5:(NSString *)str;
//计算距今天数
+(int)calculateDaysFromDate:(NSDate*)date;
//计算两个日期之间的天数
+(int)calculateDaysFromDate:(NSDate*)fromDate toDate:(NSDate *)toDate;
//字符串转化成时间
+(NSDate*)getDateFromeString:(NSString*)str;
//将时间转化成字符串
+(NSString*)formatter:(NSString*)formattter fromeDate:(NSDate*)date;

//将时间字符串转化成特定格式的字符串
+(NSString*)formatter:(NSString*) formattter fromeDateStr:(NSString*)str;

//将时间字符串转化成时间搓
+ (NSInteger)getTimeSpwithTimestr:(NSString*)timeStr;

//时间搓转为时间字符串
+ (NSString*)getTimeStrFormatter:(NSString*)formattter withTimeSp:(NSInteger)currentInteger;

@end
