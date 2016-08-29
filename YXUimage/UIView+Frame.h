//
//  UIView+Frame.h
//  SmSh
//
//  Created by IOS Developer on 16/8/3.
//  Copyright © 2016年 Xiao_Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  关于Frame的宏定义
 */
#define K_SCREENSIZE [[UIScreen mainScreen] bounds]

#define K_SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define K_SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface UIView (Frame)
- (CGSize  )size;
- (CGPoint )origin;
- (CGFloat )x;
- (CGFloat )y;
- (CGFloat )w;
- (CGFloat )h;
- (CGFloat )centerX;
- (CGFloat )centerY;
- (CGFloat )maxY;
- (CGFloat )maxX;

@end
