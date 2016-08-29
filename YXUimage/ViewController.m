//
//  ViewController.m
//  YXUimage
//
//  Created by IOS Developer on 16/4/1.
//  Copyright © 2016年 Shaun. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h" // w 750   h  1000

@interface ViewController ()
{
    GPUImagePicture * staticPicture;
    
    GPUImageOutput<GPUImageInput> * brightnessFilter;   //亮度
    
    GPUImageOutput<GPUImageInput> * contrastFilter;//对比度
    
    GPUImageOutput<GPUImageInput> * bilateralFilter; //美颜
    
    GPUImageFilterPipeline * pipeline;
    
    NSMutableArray *arrayTemp;
    
    UISlider *  brightnessSlider;
    
    UISlider * contrastSlider;
    
    UISlider * bilateralSlider;
}
@property (nonatomic, strong) UIImageView * imageV;
@property (nonatomic, strong) UISlider * slider;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage * image = [UIImage imageNamed:@"wechat"];
    
    self.imageV = [[UIImageView alloc]initWithImage:image];
    self.imageV.frame = CGRectMake(0, 0, 300, 400);
    self.imageV.center = self.view.center;
    
    
    staticPicture =[[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    
    
    //亮度
    brightnessFilter =[[GPUImageBrightnessFilter alloc] init];
    CGRect mainScreenFrame =[[UIScreen mainScreen] bounds];
    GPUImageView * GPUView = [[GPUImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [brightnessFilter forceProcessingAtSize:GPUView.sizeInPixels];
     self.imageV =(UIImageView *) GPUView;
    [brightnessFilter addTarget:GPUView];
    
    
    
    brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, mainScreenFrame.size.height - 250, mainScreenFrame.size.width - 50.0, 40.0)];
    [brightnessSlider addTarget:self action:@selector(filterImageValue:) forControlEvents:UIControlEventValueChanged];
    brightnessSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    brightnessSlider.minimumValue = 0.0;
    brightnessSlider.maximumValue = 1.0;
    brightnessSlider.tag = 10;
    brightnessSlider.value = 0.0;
    [GPUView addSubview:brightnessSlider];
    [staticPicture processImage];
    
    
    //对比度
    contrastFilter = [[GPUImageContrastFilter alloc]init];
    [contrastFilter forceProcessingAtSize:GPUView.sizeInPixels];
    [contrastFilter addTarget:GPUView];
    
    contrastSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, mainScreenFrame.size.height - 190, mainScreenFrame.size.width - 50.0, 40.0)];
    [contrastSlider addTarget:self action:@selector(filterImageValue:) forControlEvents:UIControlEventValueChanged];
//    contrastSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    contrastSlider.minimumValue = 0.0;
    contrastSlider.maximumValue = 1.0;
    contrastSlider.tag = 11;
    contrastSlider.value = 0.0;
    [GPUView addSubview:contrastSlider];
    [staticPicture processImage];
    
    
    //美颜
    bilateralFilter = [[GPUImageBilateralFilter alloc]init];
    [bilateralFilter forceProcessingAtSize:GPUView.sizeInPixels];
    [bilateralFilter addTarget:GPUView];
    
    bilateralSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, mainScreenFrame.size.height - 300, mainScreenFrame.size.width - 50.0, 40.0)];
    [bilateralSlider addTarget:self action:@selector(filterImageValue:) forControlEvents:UIControlEventValueChanged];
//    bilateralSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    bilateralSlider.minimumValue = 0.0;
    bilateralSlider.maximumValue = 1.0;
    bilateralSlider.tag = 12;
    bilateralSlider.value = 0.0;
    [GPUView addSubview:bilateralSlider];
    [staticPicture processImage];
    
    
    
    
    
    //组合，这就是把你要添加的所有滤镜效果放进数组
    [staticPicture addTarget:brightnessFilter];
    [staticPicture addTarget:contrastFilter];
    [staticPicture addTarget:bilateralFilter];
    
    arrayTemp = [[NSMutableArray alloc]initWithObjects:brightnessFilter,contrastFilter,bilateralFilter,nil];
    pipeline = [[GPUImageFilterPipeline alloc]initWithOrderedFilters:arrayTemp input:staticPicture output:(GPUImageView*)self.imageV];
    
    
   
    
    
    
//    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(20, self.imageV.maxY+20, K_SCREENWIDTH-40, 10)];
//    self.slider.minimumValue = 1;
//    self.slider.maximumValue = 20;
//    [self.slider addTarget:self action:@selector(filterImageValue:) forControlEvents:UIControlEventValueChanged];
//    
//    
//    [self.view addSubview:self.slider];
    [self.view addSubview:self.imageV];
}

- (void)filterImageValue:(UISlider *)sender
{
    NSInteger index = sender.tag - 10;
    switch (index)
    {
        case 0:
        {
            GPUImageBrightnessFilter *GPU = (GPUImageBrightnessFilter *)brightnessFilter;
            [GPU setBrightness:brightnessSlider.value];
            [staticPicture processImage];
            NSLog(@"亮度 =  %f",brightnessSlider.value);
        }
            break;
        case 1:{
            GPUImageContrastFilter *GPU = (GPUImageContrastFilter *)contrastFilter;
            [GPU setContrast:contrastSlider.value];
            [staticPicture processImage];
            NSLog(@"对比度 =  %f",contrastSlider.value);
            
        }
            break;
            
        case 2:
        {
            GPUImageBilateralFilter *GPU = (GPUImageBilateralFilter *)bilateralFilter;
            [GPU setDistanceNormalizationFactor:contrastSlider.value];
            [staticPicture processImage];
            NSLog(@"颜值 =  %f",contrastSlider.value);
        }
            break;
        default:
            break;
    }
    
    NSLog(@"lalala:%f",sender.value);
}

- (UIImage *)filterImageWithImage:(UIImage *)image
{
    
    GPUImagePicture * staticPicture = [[GPUImagePicture alloc]initWithImage:image smoothlyScaleOutput:YES];
    
//    GPUImageBrightnessFilter * passFilter = [GPUImageBrightnessFilter new];
//    passFilter.brightness = + 0.3f;
//    [passFilter forceProcessingAtSize:image.size];
//    [passFilter useNextFrameForImageCapture];
//    [staticPicture addTarget:passFilter];
    
    
    // First pass: face smoothing filter //双边滤镜美颜效果
//    self.bilateralFilter = [[GPUImageBilateralFilter alloc] init];
//    self.bilateralFilter.distanceNormalizationFactor = 0;
//    [_bilateralFilter useNextFrameForImageCapture];
//    [staticPicture addTarget:_bilateralFilter];
    
    
    
//    // Second pass: edge detection
//    GPUImageCannyEdgeDetectionFilter * cannyEdgeFilter = [[GPUImageCannyEdgeDetectionFilter alloc] init];
//    [staticPicture addTarget:cannyEdgeFilter];
//    
//    
//    // Adjust HSB
//    GPUImageHSBFilter * hsbFilter = [[GPUImageHSBFilter alloc] init];
//    [hsbFilter adjustBrightness:1.1];
//    [hsbFilter adjustSaturation:1.1];
//    
//    [staticPicture addTarget:hsbFilter];
//
//    
//
//    NSMutableArray * arrayTemp = [[NSMutableArray alloc]initWithObjects:passFilter,bilateralFilter,cannyEdgeFilter,hsbFilter,nil];
//    
//    GPUImageFilterPipeline * pipeline = [[GPUImageFilterPipeline alloc]initWithOrderedFilters:arrayTemp input:staticPicture output:image];
//    
    [staticPicture processImage];
    
//    image = [_bilateralFilter imageFromCurrentFramebuffer];
    
    return image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
