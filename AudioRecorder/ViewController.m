//
//  ViewController.m
//  AudioRecorder
//
//  Created by Jay Versluis on 10/01/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AVAudioRecorder *recorder;
- (IBAction)recordButtonPressed:(id)sender;
- (IBAction)playbackButtonPressed:(id)sender;
- (IBAction)finishRecording:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AVAudioRecorder *)recorder {
    
    if (!_recorder) {
        _recorder = [[AVAudioRecorder alloc]init];
        _recorder.delegate = self;
    }
    return _recorder;
}

- (IBAction)recordButtonPressed:(id)sender {
    
    // create a URL to an audio asset
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:@"audiofile.wav"];
    
    // create an audio recorder with the above URL
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc]initWithURL:documentsURL settings:nil error:nil];
    self.recorder = recorder;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [self.recorder record];

}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
    NSLog(@"Problem playing that sound file.");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
    NSLog(@"There was a problem with that recording");
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
}

- (IBAction)playbackButtonPressed:(id)sender {
    
    // grab a URL to an audio asset
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:@"audiofile.wav"];
    
    // create player
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:documentsURL error:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [player play];
}

- (IBAction)finishRecording:(id)sender {
    
    [self.recorder stop];
}



@end
