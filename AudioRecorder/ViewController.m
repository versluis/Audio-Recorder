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
@property (nonatomic, strong) AVAudioPlayer *player;
// @property (nonatomic, strong) AVAudioSession *session;

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

- (IBAction)recordButtonPressed:(id)sender {
    
    // create a URL to an audio asset
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:@"audiofile.wav"];
    
    // create an audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    if (session.inputAvailable) {
        
        NSLog(@"We can start recording!");
        [session setActive:YES error:nil];
        
    } else {
        NSLog(@"We don't have a mic to record with :-(");
    }
    
    // settings for our recorder
    NSDictionary *audioSettings = @{AVFormatIDKey: [NSNumber numberWithInt:kAudioFormatLinearPCM],
                                    AVSampleRateKey: [NSNumber numberWithFloat:22050],
                                    AVNumberOfChannelsKey: [NSNumber numberWithInt:1]
                                    };
    
    // create an audio recorder with the above URL
    self.recorder = [[AVAudioRecorder alloc]initWithURL:documentsURL settings:audioSettings error:nil];
    self.recorder.delegate = self;
    [self.recorder prepareToRecord];
    [self.recorder record];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];

}


- (IBAction)playbackButtonPressed:(id)sender {
    
    // grab a URL to an audio asset
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:@"audiofile.wav"];
    
    // create a session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // create player
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:documentsURL error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    
}

- (IBAction)finishRecording:(id)sender {
    
    [self.recorder stop];
    self.recorder = nil;
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
}

#pragma mark - Delegate Methods

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]];
}

@end
