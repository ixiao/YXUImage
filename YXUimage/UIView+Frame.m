//
//  UIView+Frame.m
//  SmSh
//
//  Created by IOS Developer on 16/8/3.
//  Copyright © 2016年 Xiao_Yan. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGSize  )size
{
    return  self.frame.size;
}
- (CGPoint )origin
{
    return self.frame.origin;
}
- (CGFloat )x
{
    return self.origin.x;
}
- (CGFloat )y
{
    return self.origin.y;
}
- (CGFloat )w
{
    return self.size.width;
}
- (CGFloat )h
{
    return self.size.height;
}
- (CGFloat )centerX
{
    return self.center.x;
}
- (CGFloat )centerY
{
    return self.center.y;
}
- (CGFloat )maxY
{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat )maxX
{
    return CGRectGetMaxX(self.frame);
}
@end
