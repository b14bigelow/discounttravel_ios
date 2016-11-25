//
//  SlideMenuViewController.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/25/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "AppDelegate.h"

@interface SlideMenuViewController ()

@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 2;
    } else {
        return [[getAppDelegate().model countriesList] count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell" forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.textLabel.text = @"Top item";
    } else {
        cell.textLabel.text = getAppDelegate().model.countriesList[indexPath.row - 1];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 0){
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 200)];
        [baseView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_header_background"]]];
        UIImage *logo = [UIImage imageNamed:@"discount_travel_logo"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
        [baseView addSubview:imageView];
        imageView.center = baseView.center;
        return baseView;
    } else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 200;
    } else{
        return 0;
    }
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
