//
//  UIView+transition.m
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "UIView+transition.h"

@implementation UIView (transition)

- (void)setAnchorPointTo:(CGPoint)point {
    
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}


@end
