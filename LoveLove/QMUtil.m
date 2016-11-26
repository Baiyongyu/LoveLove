//
//  ANZUtil.m
//  anz
//
//  Created by KevinCao on 16/6/29.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import "QMUtil.h"
#include <CommonCrypto/CommonDigest.h>

@implementation QMUtil

+ (NSString *)filePathWithFileName:(NSString *)fileName shouldCreateWhenNotExist:(BOOL)shouldCreateWhenNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localDirPath = [documentsDirectory stringByAppendingPathComponent:@"anz"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fileManager fileExistsAtPath:localDirPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:localDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [localDirPath stringByAppendingPathComponent:fileName];
    if (![fileManager fileExistsAtPath:filePath]) {
        if (shouldCreateWhenNotExist) {
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
            [self addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:filePath]];
        } else {
            filePath = nil;
        }
    }
    return filePath;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(BOOL)checkMoblieNumber:(NSString *)mobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|47|5[0-235-9]|78|8[02435-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,181,189
     */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349|700)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    //兼容以上 新手机号段 13,14,15,17,18...
    NSString * NEW = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSPredicate *regextestnew = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NEW];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES)
        || ([regextestnew evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

+(NSString*)checkString:(NSObject *)data
{
    NSString* string=@"";
    if ([data isKindOfClass:[NSString class]])
    {
        string = (NSString*)data;
    }
    else if ([data isKindOfClass:[NSNumber class]])
    {
        string = [NSString stringWithFormat:@"%@",data];
    }
    return string;
}

+(NSNumber*)checkNumber:(NSNumber*)number
{
    NSNumber *result=[NSNumber numberWithInt:0];
    if([number isKindOfClass:[NSNumber class]])
    {
        result = number;
        
    } else if ([number isKindOfClass:[NSString class]]) {
        result = @(((NSString *)number).doubleValue);
    }
    return result;
}

+(NSArray*)checkArray:(NSArray*)array
{
    if (array!=nil&&([array isKindOfClass:[NSArray class]]||[array isKindOfClass:[NSMutableArray class]]))
    {
        return array;
    }
    return nil;
}

+(NSString *)stringDisposeWithDouble:(double)doubleValue
{
    NSString *str = [NSString stringWithFormat:@"%.2f",doubleValue];
    int len = (int)str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

+(void)hiddenKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+(NSString *)sha512Encode:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+(NSString *)getVersionCode
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(UIFont *)getXiHeiFont:(CGFloat)fontSize
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        return [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+(BOOL)call:(NSString *)phoneNumber
{
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
}

+ (UIViewController *)getViewControllerFromView:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (BOOL)detectWebsite:(NSString *)text
{
    NSPredicate *websiteDetector = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",websiteRegex];
    if ([websiteDetector evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

+(UIImage *)imageCompressForImage:(UIImage *)sourceImage targetSize:(CGFloat)defineSize
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetSize = MIN(defineSize, MIN(width, height));
    //    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetSize, targetSize));
    [sourceImage drawInRect:CGRectMake(0,0,targetSize, targetSize)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//截屏
+ (UIImage *)screenShot:(UIView *)view
{
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//获取字符串的size
+(CGSize)getSizeWithText:(NSString*)text fontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize]}];
    return size;
}

//获取字符串的size
+(CGSize)getSizeWithText:(NSString*)text font:(UIFont*)font
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: font}];
    return size;
}

+(CGSize)getSizeWithText:(NSString*)text boldfontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize]}];
    return size;
}

//获取字符窜大小
+(CGSize)sizeWithString:(NSString*) string  font:(UIFont*)font size:(CGSize)size
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    
    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize textSize = [string boundingRectWithSize:size
                                           options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return textSize;
}

//获取字符窜大小
+(CGSize)sizeWithString:(NSString*) string  attribute:(NSDictionary*)attribute size:(CGSize)size
{
    CGSize textSize = [string boundingRectWithSize:size
                                           options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return textSize;
}

//获取NSAttributed字符窜大小
+(CGSize)sizeWithString:(NSAttributedString*) attrStr size:(CGSize)size
{
    CGSize textSize = [attrStr boundingRectWithSize:size
                                            options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                            context:nil].size;
    return textSize;
}

//MD5加密
+(NSString *)MD5:(NSString *)str{
    //32位MD5小写
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(int)calculateDaysFromDate:(NSDate*)date
{
    NSString* str=[QMUtil formatter:@"yyyy-MM-dd" fromeDate:date];
    str=[str stringByAppendingString:@" 0:0:0"];
    date=[QMUtil getDateFromeString:str];
    NSUInteger unitFlags =NSDayCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit;
    NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* today=[NSDate date];
    
    NSDateComponents *comps = [cal components:unitFlags fromDate:date toDate:today options:0];
    NSInteger days=[comps day];
    NSInteger years=[comps year];
    NSInteger months=[comps month];
    days=(days+months*30+years*365);
    return (int)days;
}

+(int)calculateDaysFromDate:(NSDate*)fromDate toDate:(NSDate *)toDate
{
    NSString* fromDateStr=[QMUtil formatter:@"yyyy-MM-dd" fromeDate:fromDate];
    fromDateStr=[fromDateStr stringByAppendingString:@" 0:0:0"];
    fromDate=[QMUtil getDateFromeString:fromDateStr];
    
    NSString* toDateStr=[QMUtil formatter:@"yyyy-MM-dd" fromeDate:toDate];
    toDateStr=[toDateStr stringByAppendingString:@" 0:0:0"];
    toDate=[QMUtil getDateFromeString:toDateStr];
    
    NSUInteger unitFlags =NSDayCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit;
    NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [cal components:unitFlags fromDate:fromDate toDate:toDate options:0];
    NSInteger days=[comps day];
    NSInteger years=[comps year];
    NSInteger months=[comps month];
    days=(days+months*30+years*365);
    return (int)days;
}

+(NSDate*)getDateFromeString:(NSString*)str
{
    if (str.length==10) {
        str = [str stringByAppendingString:@" 00:00:00"];
    } else if (str.length>19) {
        str = [str substringToIndex:19];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:str];
    if(date==nil)
        date=[NSDate date];
    return date;
}

+(NSString*)formatter:(NSString*) formattter fromeDate:(NSDate*)date
{
    NSString *returnValue;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:formattter];
    returnValue = [dateFormatter stringFromDate:date];
    return returnValue;
}

+(NSString*)formatter:(NSString*) formattter fromeDateStr:(NSString*)str
{
    NSString *returnValue=[NSString string];
    if(![str isKindOfClass:[NSString class]])
    {
        return returnValue;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:str];
    if(date==nil)
    {
        return returnValue;
    }
    [dateFormatter setDateFormat:formattter];
    returnValue = [dateFormatter stringFromDate:date];
    return returnValue;
}


+ (NSInteger)getTimeSpwithTimestr:(NSString*)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate* date = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return [timeSp integerValue];
}

#pragma mark - 时间搓转为时间字符串
+ (NSString*)getTimeStrFormatter:(NSString*)formattter withTimeSp:(NSInteger)currentInteger{
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:currentInteger];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setDateFormat:formattter];
    NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
    return currentDateStr;
}

+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText font:(UIFont*)font
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(size.width - fPadding, CGFLOAT_MAX);
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    
    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize newSize = [strText boundingRectWithSize:constraint
                                           options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    newSize.height+=16.0;
    return newSize.height;
}

+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText attribute:(NSDictionary*)attribute
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(size.width - fPadding, CGFLOAT_MAX);
    CGSize newSize = [strText boundingRectWithSize:constraint
                                           options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    newSize.height+=16.0;
    return newSize.height;
}

+(float)heightForTextViewSize:(CGSize)size  withAttributeText: (NSAttributedString *) attributeStrText
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(size.width - fPadding, CGFLOAT_MAX);
    CGSize newSize = [attributeStrText boundingRectWithSize:constraint
                                                    options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                    context:nil].size;
    
    newSize.height+=16.0;
    return newSize.height;
}

@end
