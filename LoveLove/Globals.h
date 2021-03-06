//
//  Globals.h
//  anz
//
//  Created by KevinCao on 16/6/28.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#ifndef Globals_h
#define Globals_h

#define color(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define kDefaultViewBackgroundColor [UIColor hexStringToColor:@"#f3f3f0"]
#define kNavColor [UIColor hexStringToColor:@"#FDD530"]
//淡灰色
#define kLightGrayColor [UIColor hexStringToColor:@"#999999"]
//深灰色
#define kDarkGrayColor [UIColor hexStringToColor:@"#727171"]
//浅灰色背景
#define kBgLightGrayColor [UIColor colorWithWhite:0 alpha:0.2]
//绿色
#define kGreenColor [UIColor hexStringToColor:@"#55bc22"]
// 透明
#define kLucencyColor [UIColor hexStringToColor:@"#f0f0f0"]


//wifi下手动下载图片
#define kConfigManualDownloadPictures @"kConfigManualDownloadPictures"
#define kCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#define SCREEN_SIZE          [[UIScreen mainScreen] bounds].size
//屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define kRootNavigation ((AppDelegate *)[[UIApplication sharedApplication] delegate]).nav
#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kRootWindow [UIApplication sharedApplication].windows[0]

#define XiHeiFont(fontSize) [UIFont systemFontOfSize:fontSize]

#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kNavbarHeight ((kDeviceVersion>=7.0)? 64 :44 )
#define kIOS7DELTA   ((kDeviceVersion>=7.0)? 20 :0 )
#define kTabBarHeight 49

#define kUSERPASSWORD @"116116"

#endif /* Globals_h */
