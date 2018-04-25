//
//  MeetingDetailViewController.m
//  ReserveYourSpace
//
//  Created by Singh, Navin on 20/04/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import "MeetingDetailViewController.h"

@interface MeetingDetailViewController ()

@end

@implementation MeetingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnBook.layer setCornerRadius:5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)openAjanta:(id)sender {
    MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdVC"];
    [self presentViewController:mdVC animated:YES completion:nil];
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
