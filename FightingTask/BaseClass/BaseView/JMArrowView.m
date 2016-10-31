//
//  ArrowView.m
//  OpenGL_Demo
//
//  Created by zhaojh on 16/10/20.
//  Copyright © 2016年 szkl. All rights reserved.
//

#import "JMArrowView.h"
#import <objc/runtime.h>

static const char clickActionKey;
static const char blockActionKey;
#define RADOANS(x) (M_PI * (x) / 180.0)

@interface JMArrowView ()

@property(nonatomic,assign)CGFloat angle;
@property(nonatomic,assign)CGFloat sideLength;
@property(nonatomic,assign)CGFloat lineWidth;
@property(nonatomic,strong)UIColor* lineColor;
@property(nonatomic,assign)ArrowDirect direction;

@end

@implementation JMArrowView

JMArrowView* JMArrowViewCreat(CGRect frame){

    return [[JMArrowView alloc] initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.angle = 80;
        self.sideLength = 30;
        self.lineWidth = 2;
        self.lineColor = [UIColor grayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat h = self.sideLength * sin(RADOANS(self.angle/2));
    CGFloat w = self.sideLength * cos(RADOANS(self.angle/2));
    
    CGPoint center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y);
    
    CGPoint point1, point2, point3;
    switch (_direction) {
        case ArrowRight:{
            point1 = CGPointMake(center.x - w/2, center.y - h);
            point2 = CGPointMake(center.x + w/2, center.y);
            point3 = CGPointMake(center.x - w/2, center.y + h);
        }
            break;
        case ArrowLeft:{
            point1 = CGPointMake(center.x + w/2, center.y - h);
            point2 = CGPointMake(center.x - w/2, center.y);
            point3 = CGPointMake(center.x + w/2, center.y + h);
        }
            break;
        case ArrowUp:{
            CGFloat temp = h; h = w; w = temp;
            point1 = CGPointMake(center.x - w, center.y + h/2);
            point2 = CGPointMake(center.x, center.y - h/2);
            point3 = CGPointMake(center.x + w, center.y + h/2);
        }
            break;
        case ArrowDown:{
            CGFloat temp = h; h = w; w = temp;
            point1 = CGPointMake(center.x - w, center.y - h/2);
            point2 = CGPointMake(center.x, center.y + h/2);
            point3 = CGPointMake(center.x + w, center.y - h/2);
        }
            break;
        default:
            break;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadow(context, CGSizeMake(.5, .5), 1);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    
    CGContextAddLineToPoint(context, point2.x, point2.y);

    CGContextAddLineToPoint(context, point3.x, point3.y);
    
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.lineColor setStroke];
    
    CGContextDrawPath(context, kCGPathStroke);
}

-(JMArrowView *(^)(CGFloat, CGFloat, CGFloat, UIColor *))pramsSetting{

    return ^(CGFloat angle,CGFloat sideLength,CGFloat lineWidth, UIColor* lineColor){
    
        self.angle = angle == 0 ? self.angle : angle;
        self.sideLength = sideLength == 0 ? self.sideLength : sideLength;
        self.lineWidth = lineWidth == 0 ? self.lineWidth : lineWidth;
        self.lineColor = lineColor == nil ? self.lineColor : lineColor;
        
        return self;
    };
}

-(JMArrowView *(^)(void(^block)()))tapAction{
    
    return ^JMArrowView* (void(^block)()){
        
        if (!objc_getAssociatedObject(self, &clickActionKey)) {
            
            UIGestureRecognizer* gesture = objc_getAssociatedObject(self, &clickActionKey);
            
            if (!gesture) {
                
                gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
                
                objc_setAssociatedObject(self, &clickActionKey, gesture, OBJC_ASSOCIATION_RETAIN);
                
                [self addGestureRecognizer:gesture];
            }
            
            objc_setAssociatedObject(self, &blockActionKey, block, OBJC_ASSOCIATION_COPY);
        }
        
        return self;
    };
}
-(void)clickAction:(UITapGestureRecognizer*)tap{
    
    JMArrowView* (^block)() = objc_getAssociatedObject(self, &blockActionKey);
    
    if (block) {
        block();
    }
}
-(JMArrowView* (^)(UIView * ,ArrowDirect))addAction{

    return ^(UIView *superView, ArrowDirect direction){
    
        self.direction = direction;
        [superView addSubview:self];
        [self setNeedsDisplay];
        return self;
    };
}

- (UIImage *)getColorImage:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.backgroundColor = [UIColor colorWithPatternImage:[self getColorImage:[[UIColor lightGrayColor] colorWithAlphaComponent:.1]]];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.backgroundColor = [UIColor colorWithPatternImage:[self getColorImage:[UIColor clearColor]]];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.backgroundColor = [UIColor colorWithPatternImage:[self getColorImage:[UIColor clearColor]]];
}


@end
