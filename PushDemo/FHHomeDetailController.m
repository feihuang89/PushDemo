//
//  FHHomeDetailController.m
//  PushDemo
//
//  Created by Africa on 15/10/21.
//  Copyright © 2015年 Africa. All rights reserved.
//

#import "FHHomeDetailController.h"

@interface FHHomeDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end

@implementation FHHomeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bodyLabel.text = self.userinfo[@"localNotification"];
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
