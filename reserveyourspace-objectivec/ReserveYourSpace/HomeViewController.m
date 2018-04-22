//
//  HomeViewController.m
//  ReserveYourSpace
//
//  Created by Maheshwari, Deepali on 20/4/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import "HomeViewController.h"
#import "MeetingDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MyBookingsCollectionViewCell.h"

@interface HomeViewController () <AVCaptureMetadataOutputObjectsDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *scannerView;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UILabel *response;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionMyBookings;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_collectionMyBookings registerNib:[MyBookingsCollectionViewCell nib] forCellWithReuseIdentifier:myBookingsCellID];
   // [_collectionMyBookings setFrame:CGRectMake(_scannerView.frame.origin.x, _scannerView.frame.origin.y + _scannerView.frame.size.height +50, _scannerView.frame.size.width, 100)];
   // [_collectionMyBookings reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startScanning:(id)sender {
    [self startReading];
}

-(BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_scannerView.layer.bounds];
    
    [_scannerView.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
          //  [_response performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(showRoomDetails) withObject:nil waitUntilDone:NO];
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
          //  [_scanButton performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            //   _isReading = NO;
        }
    }
}

-(void)showRoomDetails{
    MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdVC"];
    [self presentViewController:mdVC animated:YES completion:nil];
}
-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    
   // [_videoPreviewLayer removeFromSuperlayer];
}


#pragma UICollectionView Delegates


- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    
//    if(collectionView == _collectionRooms){
//        CollectionViewCell *collectionCell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
//        [collectionCell configureCell];
//        cell = collectionCell;
//    }
    
    if(collectionView == _collectionMyBookings){
        MyBookingsCollectionViewCell *myBookingsCell = (MyBookingsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:myBookingsCellID forIndexPath:indexPath];
        [myBookingsCell configureCellForIndexPath:indexPath];
        cell = myBookingsCell;
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    
    if(collectionView == _collectionMyBookings)
        count = 3;
    
//    if(collectionView == _collectionRooms)
//        count = searchData.count;
    
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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

