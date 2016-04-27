//
//  TransitionAnimation.h
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, transitionType) {
    transitionTypePush,
    transitionTypePop,
    
};

@interface TransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitonWithTransitoinType:(transitionType)type;

- (instancetype)initWithTransitoinType:(transitionType)type;

@property (nonatomic, assign)transitionType type;

@end
