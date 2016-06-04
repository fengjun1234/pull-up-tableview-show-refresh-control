//
//  ITNewsViewController.m
//  6-科技头条
//
//  Created by fengjun on 16/6/4.
//  Copyright © 2016年 fengjun. All rights reserved.
//

#import "ITNewsViewController.h"
#import "ITNews.h"
#import "ITNew.h"
#import "RefreshView.h"


static NSString * cellId = @"cellId";

@implementation ITNewsViewController{
    //tableView
    ITNews *  _itNews;
    
    //新闻列表数据
    NSMutableArray <ITNew *>* _itNewsList;
    
    //刷新视图
    RefreshView * _refreshView;
    
     
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    //初始化
    _itNewsList = nil;
    
    [self  loaddata];
    
    //设置tableView的footerView
    
    _refreshView = [RefreshView refreshView];
     //有个BUG，就是在程序一启动的时候，有个转瞬即逝的菊花视图
    self.tableView.tableFooterView = _refreshView;
    
   
    
   
}

- (void)loaddata{
    // 是否上拉刷新
    BOOL isPullup = _refreshView.indicatorView.isAnimating;
    
    // 生成时间字符串
    NSString *timeStr;
    
    // 判断上拉刷新
    if (isPullup) {
        // 取数组最后一条记录的 addTime 做上拉刷新的时间
        timeStr = _itNewsList.lastObject.addtime;
    } else {
        
        // 下拉刷新 - 获取当前系统时间字符串
        timeStr = [self timeString];
    }
    
    
//    NSString * urlString = @"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1464881444/type/0?channel=appstore&uuid=204ACEB6-9827-4AC7-A107-7CE2E48B0897&net=5&model=iPhone&ver=1.0.5";
    
    //根据当前系统时间和是否上拉进行取数据
    NSString * urlString = [NSString stringWithFormat:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/%@/type/%d?channel=appstore&uuid=204ACEB6-9827-4AC7-A107-7CE2E48B0897&net=5&model=iPhone&ver=1.0.5", timeStr ,isPullup ];
    
    
    
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    
    
    [ [[NSURLSession sharedSession]  dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error == nil) {
            NSLog(@"连接失败");
        }
        
        //直接JSON反序列成数组
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        NSLog(@"%@",array);
        
        NSMutableArray * arrayM = [NSMutableArray array];
        
   
        for (NSDictionary * ditc  in array) {
            ITNew * model = [[ITNew alloc] init];
            
            [model setValuesForKeysWithDictionary:ditc];
            
            [arrayM addObject:model];
        }
        
        //数据加载完成
        
        
        if (isPullup ) {
            
            [_itNewsList addObjectsFromArray:arrayM];
        }else{
             _itNewsList = arrayM;
        }
       
        //更新主线程UI
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue()
                           , ^{
                               
                               [_refreshView.indicatorView stopAnimating];
                               
                               // 关闭刷新控件,???
                               [self.refreshControl endRefreshing];
    
                               //刷新数据
                               [self.tableView reloadData];
                               
                           });
            
            
            
            
        });
        
   
      }
      ] resume];
    
  }


/**
 * 返回当前系统日期距离 1970-01-01 的秒数的字符串
 */
- (NSString *)timeString {
    
    // 1. 建立当前系统日期
    NSDate *date = [NSDate date];
    
    // 2. 获取距离 1970-01-01 的秒数
    NSInteger delta = [date timeIntervalSince1970];
    
    return @(delta).description;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _itNewsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    
    ITNew * model = _itNewsList[indexPath.row];
    
    cell.textLabel.text = model.title;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == [tableView numberOfRowsInSection:0] -1  &&!_refreshView.indicatorView.isAnimating) {
         //如果等于最后一行，并且图标是停止的，则转动

        [_refreshView.indicatorView startAnimating];
        
        
        //重新加载下数据
        
        [self loaddata];
    }
    
    
}




@end
