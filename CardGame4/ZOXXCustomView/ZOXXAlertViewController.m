//
//  ZOXXAlertViewController.m
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXAlertViewController.h"

@interface ZOXXAlertViewController ()

@property (strong, nonatomic) IBOutlet UILabel *showContentLabel;

@property (strong, nonatomic) IBOutlet UIButton *leftButton;

@property (strong, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic) void (^leftB)(void);

@property (nonatomic) void (^rightB)(void);

@property (nonatomic) NSString *cs;

@property (nonatomic) NSString *ls;

@property (nonatomic) NSString *rs;

@end

@implementation ZOXXAlertViewController

- (instancetype)initWithTitle:(NSString *)title andLeftBtnTxt:(NSString *)ltxt andRightBtnTxt:(NSString *)rtxt andLeftBlock:(void (^)(void))leftBlock andRightBlock:(void (^)(void))rightBlock{
    
    if (self = [super initWithNibName:@"ZOXXAlertViewController" bundle:nil]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.cs = title;
        self.ls = ltxt;
        self.rs = rtxt;
        self.leftB = leftBlock;
        self.rightB = rightBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showContentLabel.text = self.cs;
    [self.leftButton setTitle:self.ls forState:UIControlStateNormal];
    [self.rightButton setTitle:self.rs forState:UIControlStateNormal];
}


- (IBAction)lclick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.leftB) {
        self.leftB();
    }
}

- (IBAction)rclick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.rightB) {
        self.rightB();
    }
}



@end
