//
//  Setting.h
//  Book
//
//  Created by tmp on 16/4/22.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#ifndef Setting_h
#define Setting_h

static NSString * const HBackgroundColor = @"bookBackgroundColor"; //取出来 NSString
static NSString * const HLight = @"ScreenLight";                    // NSNumber
static NSString * const HFontSize = @"bookFontSize";                // NSNumber
static NSString * const HFontStyle = @"bookFontStyle";              // NSString
static NSString * const HBookChatperNum = @"bookChatperNum";        //NSNumber
static NSString * const HBookContentNum = @"bookContentNum";        //NSNumber
static NSString * const HBookUnderLineArr = @"bookUnderLineArr";    //NSArray


#define GetObjectUserDefault(key)     [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define SetObjectUserDefault(object, key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]


#endif /* Setting_h */
