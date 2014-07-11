//
//  pieChartLegendView.h
//  myBudget2
//
//  Created by Maciek Caputa on 14.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pieChartLegendView : UIView

@property (strong,nonatomic) NSDictionary *data;

- (NSInteger)getTappedItemIndexAtPoint:(CGPoint)point;

@end
