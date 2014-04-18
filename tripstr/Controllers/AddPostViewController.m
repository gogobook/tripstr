//
//  AddPostViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "AddPostViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
#import <SIAlertView.h>

typedef enum ImagePickerType{
    ImagePickerTypeCamera,
    ImagePickerTypeLibrary
}ImagePickerType;

@interface AddPostViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) IBOutlet UITextField* headline;
@property (nonatomic,strong) IBOutlet UITextField* location;
@property (nonatomic,strong) IBOutlet UITextView*  content;

@property (nonatomic,strong) UIImage* selectedImage;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (nonatomic,strong) MBProgressHUD* hud;

@end

@implementation AddPostViewController



- (id)init
{
    self = [super init];
    
    if (self) {
//        self.navigationController = [[UINavigationController alloc] init];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Add New Post";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(finishButtonTapped:)];
    self.navigationController.navigationBar.translucent = NO;
    
    
//
//    [self setLayout];
//    [self setConstraints];
}

- (void)setLayout
{
//    [self.view addSubview:self.headline];
//    [self.view addSubview:self.location];
//    [self.view addSubview:self.content];
}

- (void)setConstraints
{
//    NSDictionary* views = @{@"headline":self.headline,@"location":self.location,@"content":self.content};
//    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[headline]-[location]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
//    [self.view addConstraints: [ NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[headline]-|" options:0 metrics:nil views:views]];
//    [self.view addConstraints: [ NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[location]-|" options:0 metrics:nil views:views]];
}

- (IBAction) addPictureButtonTapped:(id)sender {
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.selectedImage = info[@"UIImagePickerControllerEditedImage"];
    [self.addPhotoButton setBackgroundImage:self.selectedImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)finishButtonTapped:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.headline.enabled = NO;
    [self.hud show:YES];
    NSData* imageData = UIImageJPEGRepresentation(self.selectedImage, 0.8);
    PFFile* imageFile = [PFFile fileWithName:@"userImage.jpg" data:imageData];
    
    
    PFObject* newPost = [PFObject objectWithClassName:@"postData"];
    newPost[@"headline"] = self.headline.text;
    newPost[@"location"] = self.location.text;
    newPost[@"content"] = self.content.text;
    newPost[@"photo"] = imageFile;
    newPost[@"author"] = [PFUser currentUser];
    newPost[@"authorId"] = [[PFUser currentUser]objectId];
    PFRelation* authorRelation = [newPost relationForKey:@"authorRelation"];
    [authorRelation addObject:[PFUser currentUser]];
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.hud hide:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.hud hide:YES];
            SIAlertView* alert = [[SIAlertView alloc] initWithTitle:@"Upload Failed" andMessage:@"Check your internet connection and try again later"];
            [alert addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeCancel  handler:nil];
            [alert show];
            NSLog(@"Error uploading: %@",error);
            
        }
    }];
    

}

- (void)cancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- getter

-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}

//-(UITextField *)headline
//{
//    if (!_headline) {
//        _headline = [[UITextField alloc] init];
//        _headline.translatesAutoresizingMaskIntoConstraints = NO;
//        _headline.placeholder = @"Topic (Required)";
//        _headline.borderStyle = UITextBorderStyleBezel;
//    }
//    return _headline;
//}
//
//-(UITextField *)location
//{
//    if (!_location) {
//        _location = [[UITextField alloc] init];
//        _location.translatesAutoresizingMaskIntoConstraints = NO;
//        _location.placeholder = @"Location (eg. Taipei, Taiwan)";
//        _location.borderStyle = UITextBorderStyleBezel;
//    }
//    return _location;
//}



//-(UITextView *)content
//{
//    if (!_content) {
//        _content = [[UITextView alloc] initWithFrame:CGRectMake(20, 90, 280, 100)];
//        _content.backgroundColor = [UIColor purpleColor];
//        _content.text = @"blabla";
//    }
//    return _content;
//}
@end
