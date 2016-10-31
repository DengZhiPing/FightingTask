//
//  ArrowView.h
//  OpenGL_Demo
//
//  Created by zhaojh on 16/10/20.
//  Copyright © 2016年 szkl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    ArrowUp,
    ArrowDown,
    ArrowLeft,
    ArrowRight
    
}ArrowDirect;

@interface JMArrowView : UIView

/** 初始化调用 参数为CGRect frame */
JMArrowView* JMArrowViewCreat(CGRect frame);

/** 参数，“(角度, 箭头边长, 剪头线宽度, 剪头颜色) 设置0或null使用默认” */
@property(nonatomic,copy)JMArrowView* (^pramsSetting)(CGFloat angle,CGFloat sideLength,CGFloat lineWidth, UIColor* lineColor);

/** 点击事件 参数为点击响应的block */
@property(nonatomic,copy)JMArrowView* (^tapAction)(void(^)());

/** addSubView 参数为父视图, 箭头的方向:枚举值, 须在最后面调用 */
@property(nonatomic,copy)JMArrowView* (^addAction)(UIView* superView,ArrowDirect direction);

@end



