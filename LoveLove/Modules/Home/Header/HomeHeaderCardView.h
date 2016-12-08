//
//  HomeHeaderCardView.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 首页热门推荐协议 */
@protocol DidSeletedViewItemDelegate <NSObject>
- (void)didSeletedViewItem:(NSIndexPath *)indexPath;
@end

@interface HomeHeaderCardView : UIView
/** delegate */
@property(nonatomic, assign) id <DidSeletedViewItemDelegate> delegate;
@end
