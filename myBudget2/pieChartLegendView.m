//
//  pieChartLegendView.m
//  myBudget2
//
//  Created by Maciek Caputa on 14.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "pieChartLegendView.h"

@interface pieChartLegendView ()

@property (strong,nonatomic) NSMutableArray *buttons;

@end

@implementation pieChartLegendView

- (NSMutableArray *)buttons
{
    if (!_buttons) _buttons = [[NSMutableArray alloc] init];
    return _buttons;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    const CGFloat colors[27] = {241/255.0,  88/255.0,  84/255.0, 77/255.0,  77/255.0,  77/255.0, 93/255.0, 165/255.0, 218/255.0,250/255.0, 164/255.0,  58/255.0, 96/255.0, 189/255.0, 104/255.0,241/255.0, 124/255.0, 176/255.0,178/255.0, 145/255.0,  47/255.0,178/255.0, 118/255.0, 178/255.0,222/255.0, 207/255.0,  63/255.0};
    NSArray *labels= [self.data allKeys];
    NSArray *values = [self.data allValues];
    
    const CGSize maxwidth = {self.bounds.size.width-20.0, self.bounds.size.height-20.0};
    const CGPoint startPoint = {20.0, 20.0};
    const CGSize margin = {5.0, 15.0};
    const CGSize padding = {5.0, 5.0};
    
    CGPoint current= {startPoint.x, startPoint.y};
    
    for (int i=0; i<[labels count]; i++) {
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:labels[i]];
        
        NSNumber *percentValue = [NSNumber numberWithFloat:[values[i] floatValue]*100];
        
        
        NSAttributedString *value = [[NSAttributedString alloc ]initWithString:[NSString stringWithFormat:@" - %d %%", [percentValue integerValue]]];
        
        [text appendAttributedString:value];
        
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[[text string] rangeOfString:[text string]]];
        
        CGSize textSize = [text size];
        
        if (current.x+textSize.width+2*padding.width> maxwidth.width) {
            current.y+=text.size.height+2*padding.height+margin.height;
            current.x=startPoint.x;
        }
        
        CGRect textrect = CGRectMake(current.x, current.y, textSize.width+2*padding.width, textSize.height+2*padding.height);
        UIBezierPath *textBox = [UIBezierPath bezierPathWithRoundedRect:textrect cornerRadius:3.0];
        
        UIColor *color = [UIColor colorWithRed:colors[i*3] green:colors[(i*3)+1] blue:colors[(i*3)+2] alpha:1];
        [color setFill];
        [textBox fill];
        
        CGPoint textpoint = {current.x+padding.width, current.y+padding.height};
        
        [text drawAtPoint:textpoint];
        
        [self.buttons addObject:textBox];
        
        
        current.x = current.x + textrect.size.width + margin.width;
        
    }
    
}

- (NSInteger)getTappedItemIndexAtPoint:(CGPoint)point
{
    NSInteger itemIndex=-1;
    for (UIBezierPath *button in self.buttons) {
        if ([button containsPoint:point]) {
            itemIndex=[self.buttons indexOfObject:button];
            break;
        }
    }
    return itemIndex;
}


@end
