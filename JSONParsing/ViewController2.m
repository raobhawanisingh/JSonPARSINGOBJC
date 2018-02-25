//
//  ViewController2.m
//  JSONParsing
//
//  Created by Student 01 on 04/02/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.dictDetails valueForKey:@"author"];// use to give title for navigation
    _lblAuthor.text =[self.dictDetails valueForKey:@"author"];
    _lblTitle.text = [_dictDetails valueForKey:@"title"];
    _lblDiscreption.text = [_dictDetails valueForKey:@"description"];
    _lblURL.text =[_dictDetails valueForKey:@"url"];
    _imgUrl.text = [_dictDetails valueForKey:@"urlToImage"];
    _lblPublishAT.text=[_dictDetails valueForKey:@"publishedAt"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
