//
//  SXFiveScoreCell.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "SXFiveScoreCell.h"

@interface SXFiveScoreCell ()

@property (weak, nonatomic) IBOutlet UIImageView *scoreImg;

@property(nonatomic,assign,getter=isOpen)BOOL open;

@end
@implementation SXFiveScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.scoreView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.open = YES;
}

+ (instancetype)cell {
   return [[NSBundle mainBundle]loadNibNamed:@"SXFiveScoreCell" owner:nil options:nil][0];
}

- (void)setScores:(NSArray *)scores {
    _scores = scores;
    self.scoreView.showType = 1;
    self.scoreView.showColor = [UIColor colorWithRed:0.97 green:0.5 blue:0.09 alpha:0.8];
//    self.scoreView.showColor = [UIColor orangeColor];
    self.scoreView.showWidtn = 1;
    self.scoreView.subScore1 = [scores[0] floatValue];
    self.scoreView.subScore2 = [scores[1] floatValue];
    self.scoreView.subScore3 = [scores[2] floatValue];
    self.scoreImg.image = [UIImage imageNamed:@"fb_three"];
    if (scores.count > 3) {
        self.scoreView.subScore4 = [scores[3] floatValue];
        self.scoreImg.image = [UIImage imageNamed:@"fb_four"];
    }
    if (scores.count > 4) {
        self.scoreView.subScore5 = [scores[4] floatValue];
        self.scoreImg.image = [UIImage imageNamed:@"fb_five"];
    }
    
}
- (void)setCompareScores:(NSArray *)compareScores {
    _compareScores = compareScores;
    self.compareScoreView.showType = 2;
    self.compareScoreView.showColor = [UIColor colorWithRed:0.18 green:0.74 blue:0.65 alpha:0.8];
//    self.compareScoreView.showColor = [UIColor greenColor];
    self.compareScoreView.showWidtn = 1;
    self.compareScoreView.subScore1 = [compareScores[0] floatValue];
    self.compareScoreView.subScore2 = [compareScores[1] floatValue];
    self.compareScoreView.subScore3 = [compareScores[2] floatValue];
    if (compareScores.count > 3) {
        self.compareScoreView.subScore4 = [compareScores[3] floatValue];
    }
    if (compareScores.count > 4) {
        self.compareScoreView.subScore5 = [compareScores[4] floatValue];
    }
}
- (void)setLabelNames:(NSArray *)labelNames {
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isOpen == NO) {
        [UIView animateWithDuration:1.0 animations:^{
            self.scoreView.transform = CGAffineTransformIdentity;
        }];
        self.open = YES;
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            self.scoreView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        }];
        self.open = NO;
    }
}

@end
