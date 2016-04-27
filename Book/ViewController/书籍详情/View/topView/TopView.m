//
//  TopView.m
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import "TopView.h"

@interface TopView ()

@property (weak, nonatomic) IBOutlet UIImageView *redu0;
@property (weak, nonatomic) IBOutlet UIImageView *redu1;
@property (weak, nonatomic) IBOutlet UIImageView *redu2;
@property (weak, nonatomic) IBOutlet UIImageView *redu3;
@property (weak, nonatomic) IBOutlet UIImageView *redu4;

@end


@implementation TopView


- (void)setDescLb:(UITextView *)descLb {
    
    _descLb = descLb;
    
    _descLb.scrollsToTop = true;
    
    
}


//配置热度
- (void)setRedu:(NSInteger)redu {
    
    _redu = redu;
    
    UIImage *fillImage  = [UIImage imageNamed:@"redu"];
    UIImage *nullImage  = [UIImage imageNamed:@"redu1"];
    
    switch (redu) {
        case 0:{
            
            self.redu0.image = nullImage;
            self.redu1.image = nullImage;
            self.redu2.image = nullImage;
            self.redu3.image = nullImage;
            self.redu4.image = nullImage;
            
        }
            break;
        case 1:{
            
            self.redu0.image = fillImage;
            self.redu1.image = nullImage;
            self.redu2.image = nullImage;
            self.redu3.image = nullImage;
            self.redu4.image = nullImage;
            
        }
            break;
        case 2:{
            self.redu0.image = fillImage;
            self.redu1.image = fillImage;
            self.redu2.image = nullImage;
            self.redu3.image = nullImage;
            self.redu4.image = nullImage;
        }
            break;
        case 3:{
            self.redu0.image = fillImage;
            self.redu1.image = fillImage;
            self.redu2.image = fillImage;
            self.redu3.image = nullImage;
            self.redu4.image = nullImage;
        }
            break;
        case 4:{
            self.redu0.image = fillImage;
            self.redu1.image = fillImage;
            self.redu2.image = fillImage;
            self.redu3.image = fillImage;
            self.redu4.image = nullImage;
        }
            break;
        case 5:{
            
            self.redu0.image = fillImage;
            self.redu1.image = fillImage;
            self.redu2.image = fillImage;
            self.redu3.image = fillImage;
            self.redu4.image = fillImage;
        }
            break;
        default:
            break;
    }
    
    
}

- (void)awakeFromNib {
    
    
  
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
