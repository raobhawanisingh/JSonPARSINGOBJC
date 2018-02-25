//
//  ViewController2.h
//  JSONParsing
//
//  Created by Student 01 on 04/02/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblAuthor;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscreption;
@property (strong, nonatomic) IBOutlet UILabel *lblURL;
@property (strong, nonatomic) IBOutlet UILabel *imgUrl;
@property (strong, nonatomic) IBOutlet UILabel *lblPublishAT;
@property (strong, nonatomic) NSDictionary *dictDetails;
@end
