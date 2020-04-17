//
//  ZOXXAlertViewControll.m
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXAlertViewControll.h"

@interface ZOXXAlertViewControll ()

@end

@implementation ZOXXAlertViewControll

- (instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
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
