//
//  pieChartView.m
//  myBudget2
//
//  Created by Maciek Caputa on 14.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "pieChartView.h"

@interface pieChartView ()


@end

@implementation pieChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    const CGFloat colors[27] = {241/255.0,  88/255.0,  84/255.0, 77/255.0,  77/255.0,  77/255.0, 93/255.0, 165/255.0, 218/255.0,250/255.0, 164/255.0,  58/255.0, 96/255.0, 189/255.0, 104/255.0,241/255.0, 124/255.0, 176/255.0,178/255.0, 145/255.0,  47/255.0,178/255.0, 118/255.0, 178/255.0,222/255.0, 207/255.0,  63/255.0};
    CGFloat circleWidth = (self.bounds.size.width>self.bounds.size.height) ? self.bounds.size.height : self.bounds.size.width;
    CGFloat radius = circleWidth/3;
    CGPoint center = self.center;
    CGFloat lastangle=0;
    
    NSArray *values = [self.data allValues];
    CGFloat angle =0;
    
    for (int i =0; i<[values count]; i++) {
        NSNumber *value =values[i];
         angle += 2*M_PI*[value floatValue];
        UIBezierPath *pie = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:lastangle endAngle:angle clockwise:YES];
        [pie addLineToPoint:center];
        [pie closePath];

        UIColor *color = [UIColor colorWithRed:colors[i*3] green:colors[(i*3)+1] blue:colors[(i*3)+2] alpha:1];
        [color setFill];
        [pie fill];
        lastangle=angle;
    }
    
}


@end
