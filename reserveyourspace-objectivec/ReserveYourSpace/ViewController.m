//
//  ViewController.m
//  ReserveYourSpace
//
//  Created by Singh, Navin on 17/04/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "MyBookingsCollectionViewCell.h"
#import "MeetingDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, AVCaptureMetadataOutputObjectsDelegate>
{
    NSArray *originalData;
    NSMutableArray *searchData;
}

@property (strong, nonatomic) NSArray *arrayList;
@property (strong, nonatomic) UISearchBar *meetingRoomSearchBar;
@property (strong, nonatomic) UIButton *buttonForDatePicker;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionRooms;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionMyBookings;
@property (strong, nonatomic) UILabel *myBookingsLabel;
@property (strong, nonatomic) UIImageView *qrCodeImage;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIView *controllerView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) UIImageView *micImage;

@end

@implementation ViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 alpha:1.0]

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back2.jpg"]]];
    [_collectionRooms registerNib:[CollectionViewCell nib] forCellWithReuseIdentifier:collectionCellID];
    [_collectionMyBookings registerNib:[MyBookingsCollectionViewCell nib] forCellWithReuseIdentifier:myBookingsCellID];
    [self addComponentsInOrder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addComponentsInOrder{
    // 1.
    [self addDatePickerButton];
    // 2.
    [self addSearchBar];
    // 3.
    [self addsearchResultObject];
    // 4.
    [self addQRCodeScanner];
    // 5.
    [self addMyBookings];
}

-(void)updateComponents{
    [self addsearchResultObject];
    [self addQRCodeScanner];
    [self addMyBookings];
}

-(void)addSearchBar{

     _meetingRoomSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width - _buttonForDatePicker.frame.size.width, 56)];
    [_meetingRoomSearchBar setSearchBarStyle:UISearchBarStyleMinimal];
    _meetingRoomSearchBar.delegate = self;
    _micImage = [[UIImageView alloc] initWithFrame:CGRectMake(245, 17, 20, 20)];
    [_micImage setImage:[UIImage imageNamed:@"mic.png"]];
    [_meetingRoomSearchBar.layer addSublayer:_micImage.layer];
    [self.view addSubview:_meetingRoomSearchBar];

}

-(void)addDatePickerButton{
    _buttonForDatePicker = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40, 65, 40, 40)];
    [_buttonForDatePicker setImage:[UIImage imageNamed:@"date.png"] forState:UIControlStateNormal];
    [self.view addSubview:_buttonForDatePicker];
}

-(void)addsearchResultObject{
    if(searchData.count == 0 || searchData == nil)
        [_collectionRooms setFrame:CGRectMake(20 + _meetingRoomSearchBar.frame.origin.x, _meetingRoomSearchBar.frame.origin.y + _meetingRoomSearchBar.frame.size.height + 20, _meetingRoomSearchBar.frame.size.width, 0)];
    
    else{
        [_collectionRooms setFrame:CGRectMake(20 + _meetingRoomSearchBar.frame.origin.x, _meetingRoomSearchBar.frame.origin.y + _meetingRoomSearchBar.frame.size.height + 20, _meetingRoomSearchBar.frame.size.width, 101.5)];
        [_collectionRooms reloadData];
    }
}

-(void)addQRCodeScanner{
    CGFloat height = 272;
    
        if(!_controllerView){
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//                _imagePickerController = [[UIImagePickerController alloc] init];
//
//                _imagePickerController.delegate = self;
//                _imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
//                _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//                _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//
//                _controllerView = _imagePickerController.view;
//                [_controllerView setFrame:CGRectMake(_collectionRooms.frame.origin.x, _collectionRooms.frame.origin.y + _collectionRooms.frame.size.height, _collectionRooms.frame.size.width, height)];
//                _controllerView.alpha = 0.0;
//                [self.view addSubview:_controllerView];
//
//                [UIView animateWithDuration:0.3
//                                      delay:0.0
//                                    options:UIViewAnimationOptionCurveLinear
//                                 animations:^{
//                                     _controllerView.alpha = 1.0;
//                                 }
//                                 completion:nil
//                 ];
                
                NSError *error;
                
                AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                
                AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
                if (!input) {
                    NSLog(@"%@", [error localizedDescription]);
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
                _controllerView = [[UIView alloc] initWithFrame:CGRectMake(_collectionRooms.frame.origin.x+30, _collectionRooms.frame.origin.y + _collectionRooms.frame.size.height, _collectionRooms.frame.size.width-_collectionRooms.frame.size.width/4, height)];
                [_videoPreviewLayer setFrame:_controllerView.layer.bounds];
                
                [_controllerView.layer addSublayer:_videoPreviewLayer];
                [self.view addSubview:_controllerView];
                [_captureSession startRunning];
            }
            else{
            _qrCodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(_collectionRooms.frame.origin.x, _collectionRooms.frame.origin.y + _collectionRooms.frame.size.height, _collectionRooms.frame.size.width, height)];
            [_qrCodeImage setImage:[UIImage imageNamed:@"qrcodeimage.png"]];
            [self.view addSubview:_qrCodeImage];
            }
        }
        else{
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                [_controllerView setFrame:CGRectMake(_collectionRooms.frame.origin.x+30, _collectionRooms.frame.origin.y + _collectionRooms.frame.size.height, _collectionRooms.frame.size.width-_collectionRooms.frame.size.width/4, height)];
            }
            else{
            CGFloat height = 272;
            [_qrCodeImage setFrame:CGRectMake(_collectionRooms.frame.origin.x, _collectionRooms.frame.origin.y + _collectionRooms.frame.size.height, _collectionRooms.frame.size.width, height)];
                [_qrCodeImage setImage:[UIImage imageNamed:@"qrcodeimage.png"]];}
        }
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            //  [_response performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(showRoomDetails:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            //[self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            //  [_scanButton performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            //   _isReading = NO;
        }
    }
}

-(void)showRoomDetails:(NSString*) roomName{
    //Not available :(
    if ([roomName isEqualToString:@"Indus"]) {
        MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdIndusVC"];
        [self presentViewController:mdVC animated:YES completion:nil];
    }
    //Available :)
    if ([roomName isEqualToString:@"Ajanta"]) {
        MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdVC"];
        [self presentViewController:mdVC animated:YES completion:nil];
    }
    //Check in
    if ([roomName isEqualToString:@"Corbett"]) {
        MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdCorbettVC"];
        [self presentViewController:mdVC animated:YES completion:nil];
    }
    
    
}
-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // [_videoPreviewLayer removeFromSuperlayer];
}

- (void)addMyBookings{
    
    if(_qrCodeImage)
    [_collectionMyBookings setFrame:CGRectMake(_qrCodeImage.frame.origin.x, _qrCodeImage.frame.origin.y + _qrCodeImage.frame.size.height +50, _qrCodeImage.frame.size.width, 100)];
    else
    [_collectionMyBookings setFrame:CGRectMake(_collectionRooms.frame.origin.x, _controllerView.frame.origin.y + _controllerView.frame.size.height +50, _collectionRooms.frame.size.width, 100)];
    
//    [_collectionMyBookings setFrame:CGRectMake(_collectionRooms.frame.origin.x, _controllerView.frame.origin.y + _collectionRooms.frame.size.height, _collectionRooms.frame.size.width, 100)];
    
    if(_myBookingsLabel == nil){
        _myBookingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(_collectionMyBookings.frame.origin.x, _collectionMyBookings.frame.origin.y - 30, _collectionMyBookings.frame.size.width, 30)];
        [_myBookingsLabel setText:@"My Bookings"];
        [self.view addSubview:_myBookingsLabel];
    }
    else{
        [_myBookingsLabel setFrame:CGRectMake(_collectionMyBookings.frame.origin.x, _collectionMyBookings.frame.origin.y - 30, _collectionMyBookings.frame.size.width, 30)];
    }
    [_collectionMyBookings reloadData];
}

- (IBAction)openDatePicker:(id)sender {

}

- (NSDictionary *)loadData
{
    NSMutableDictionary *dataMap = [NSMutableDictionary new];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"notifications" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error){
//        DLOG(@"Error getting JSON: %@", error);
    } else{
        if ([json isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = (NSDictionary *)json;
            for(NSString *category in dict){
                if ([category isEqualToString:@"Notifications"]) {
                  
                }
                if ([category isEqualToString:@"Tasks"]) {
                  
                }
            }
        } else{
//            DLOG(@"Unexpected JSON format for daily digest config: %@", json);
        }
    }
    
    return dataMap;
}


#pragma UISearchBar Delegates

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"searchbar text : searchBarTextDidBeginEditing" );
    [searchBar setShowsCancelButton:YES animated:YES];
    [_micImage setHidden:YES];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"searchbar text : textDidChange %@ ",searchText );
    
    if([searchText isEqualToString:@"a"] || [searchText isEqualToString:@"A"])
        searchData = [[NSMutableArray alloc] initWithObjects:@"A",@"Ab",@"Abc", nil]; // this is initialised here so that when user enters a text (preferably 'a' or 'A'). we can populate the list with rooms
    else
        searchData = nil;
    
    [self updateComponents];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //[searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

-(BOOL) searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"])
    {
       // [searchBar resignFirstResponder];
        return NO;
    }
    return YES;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"pressed cross on search");
    [searchBar resignFirstResponder];
    [_micImage setHidden:NO];
}

-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchbar text : %@", searchBar.text);
    
}

#pragma UICollectionView Delegates


- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    
    if(collectionView == _collectionRooms){
        CollectionViewCell *collectionCell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        [collectionCell configureCell];
        [collectionCell initializeCellValues:indexPath];
        cell = collectionCell;
    }
    
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
        count = 2;
    
    if(collectionView == _collectionRooms)
        count = searchData.count;
    
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView == _collectionMyBookings) {
        MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdCorbettVC"];
        [self presentViewController:mdVC animated:YES completion:nil];
    }
    
    
    if(collectionView == _collectionRooms) {
        MeetingDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mdVC"];
        [self presentViewController:mdVC animated:YES completion:nil];
    }
    
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if(collectionView == _collectionMyBookings)
//        return CGSizeMake((collectionView.frame.size.width/2)-40, 80);
//    
//    if(collectionView == _collectionRooms)
//        return CGSizeMake(85, 80);
//    
//    
//    return CGSizeZero;
//    
//    
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
            if(collectionView == _collectionMyBookings)
                return 30;
    
            if(collectionView == _collectionRooms)
                return 10;
    
    
            return 0;
}



#pragma UITapGestureRecogniser

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        UIView *controllerView = imagePickerController.view;
        
        controllerView.alpha = 0.0;
        controllerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:controllerView];
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             controllerView.alpha = 1.0;
                         }
                         completion:nil
         ];
        
    }
}

#pragma camera delegate

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    _qrCodeImage.image = chosenImage;
//
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//
//}
/* Unused delegate methods
 
 
 - (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
 
 }
 
 - (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
 
 }
 
 - (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
 
 }
 
 - (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
 
 }
 
 - (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
 
 }
 
 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
 
 }
 
 - (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
 
 }
 
 - (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
 
 }
 
 - (void)setNeedsFocusUpdate {
 
 }
 
 - (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
 
 }
 
 - (void)updateFocusIfNeeded {
 
 }
 */

@end
