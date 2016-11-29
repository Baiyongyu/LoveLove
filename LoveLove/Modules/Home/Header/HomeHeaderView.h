//
//  HomeHeaderView.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/28.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 首页热门推荐协议 */
@protocol DidSeletedViewItemDelegate <NSObject>
- (void)didSeletedViewItem:(NSIndexPath *)indexPath;
@end

@interface HomeHeaderView : UIView
/** delegate */
@property(nonatomic, assign) id <DidSeletedViewItemDelegate> delegate;
@end
