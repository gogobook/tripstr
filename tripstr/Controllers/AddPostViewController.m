//
//  AddPostViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "AddPostViewController.h"

typedef enum ImagePickerType{
    ImagePickerTypeCamera,
    ImagePickerTypeLibrary
}ImagePickerType;

@interface AddPostViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation AddPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        self.title = @"rrrr";
//        self.navigationController = [[UINavigationController alloc] init];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)finishButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPictureButtonTapped:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Use Camera",@"Load from Library", nil];
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case ImagePickerTypeCamera:
        {
            [self useCamera];
            break;
        }
        case ImagePickerTypeLibrary:
        {
            [self usePhotoLibrary];
            break;
        }
        default:
            break;
    }
}

- (void) useCamera
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"Camera is not working...");
    }
    
}

- (void) usePhotoLibrary
{
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
}

@end
