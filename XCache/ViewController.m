//
//  ViewController.m
//  XCache
//
//  Created by xlx on 16/3/12.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import "ViewController.h"
#import "XCache.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cacheLabel.text = [XCache returnCacheSize];

}
- (IBAction)clean:(id)sender {
    [XCache cleanCache:^{
        NSLog(@"清理成功");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
