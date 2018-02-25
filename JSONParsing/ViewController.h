//
//  ViewController.h
//  JSONParsing
//
//  Created by Student 01 on 03/02/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleTableViewCell.h"
#import "ViewController2.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arrArticles;
}
@property (strong, nonatomic) IBOutlet UITableView *tblArticles;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

