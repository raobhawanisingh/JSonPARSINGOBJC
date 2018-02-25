//
//  ViewController.m
//  JSONParsing
//
//  Created by Student 01 on 03/02/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JSON";
    //[_activityIndicator startAnimating];
    NSString *jsonStrURL = @"https://newsapi.org/v1/articles?source=techcrunch&apiKey=efe99de73d1d49608eb3d4e87c536b26";
    [self JSONPersing:jsonStrURL];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) JSONPersing:(NSString *)strURL{
       [_activityIndicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSData *data1 = [[NSData alloc] initWithContentsOfURL:url];
    NSLog(@"%@",data1);
    NSURLSession *session = [NSURLSession sharedSession];//it is an singlton class used for client server communication
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator stopAnimating];
            _activityIndicator.hidden = YES;
            
            
            
            
             // reload/refreash data of table view if updation,deletion,insertion is done(Refreash tableview)
        });
       
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:alertAction];
                [self presentViewController:alertController animated:YES completion:nil];
                });
            NSLog(@"%@",error.localizedDescription);
            
        }else if (data !=nil){
                       NSError *errJson;
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errJson];
            if (errJson==nil) {
              NSLog(@"%@",dict);
                arrArticles = [dict valueForKey:@"articles"];
                if (arrArticles.count) {
                    _tblArticles.delegate = self;//to call delegate for that obj
                    _tblArticles.dataSource = self;//to call delegate for that obj
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SUCCESS" message:@"wellcome" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                            
                            
                            [_tblArticles reloadData];// reload/refreash data of table view if updation,deletion,insertion is done(Refreash tableview)
                        }];
                        [alertController addAction:alertAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    });
                    

            
                    //dispatch is used to switch tread here we switch from background tread to main tread
                    
                }
                
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"JSON_ERROR" message:@"JSON INVALID" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:alertAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                });

                NSLog(@"%@",errJson.localizedDescription);
            }
            
        }
    
    }];
    [dataTask resume];
    NSLog(@"hiiiiiii:::::");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrArticles.count>0) {
        return arrArticles.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}//this method is used to set the hight of cell 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"articleCell"];
    if (cell == nil) {
        cell = [[ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"articleCell"];//used for creating obj of cell
        
        return cell;
    }
    NSDictionary *dict = [arrArticles objectAtIndex:indexPath.row];
    
    
    NSString *strAuthor =[dict valueForKey:@"author"];
    cell.lblTitle.text = strAuthor;
    NSString *strDesc = [dict valueForKey:@"description"];
    cell.lblDescreption.text = strDesc;
    
    cell.imgView.layer.borderWidth = 1.0;
    cell.imgView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width/2;
    cell.imgView.clipsToBounds = YES;
    
    
    NSString *strURL = [dict valueForKey:@"urlToImage"];
    [self imageDownload:cell.imgView withPath:strURL];
    // NSURL *url = [NSURL URLWithString:strURL];
   // NSData *data = [[NSData alloc]initWithContentsOfURL:url];
   // cell.imgView.image = [UIImage imageWithData:data];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController2 *VC2= [story instantiateViewControllerWithIdentifier:@"ViewController2"];
    VC2.dictDetails = [arrArticles objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:VC2 animated:YES];
}


- (void)imageDownload:(UIImageView *)imgvw withPath:(NSString *)strPath{
    NSURL *url = [NSURL URLWithString:strPath];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *dwtask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            imgvw.image = [UIImage imageNamed:@"placeholder-images.jpg"];
        }else{
           NSData *data = [[NSData alloc]initWithContentsOfURL:location];
            dispatch_async(dispatch_get_main_queue(), ^{
                imgvw.image = [UIImage imageWithData:data];
 
            });
        }
    }];
    [dwtask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
