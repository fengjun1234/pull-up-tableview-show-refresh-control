//
//  RefreshView.h
//  6-科技头条
//
//  Created by fengjun on 16/6/4.
//  Copyright © 2016年 fengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
+ (instancetype)refreshView;
@end
