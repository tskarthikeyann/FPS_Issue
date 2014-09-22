-(void)setupCaptureSession
{
    if ( _captureSession ) {
        return;
    }

    _captureSession = [[AVCaptureSession alloc] init];  

    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  ....................................
  ....................................

_videoConnection = [videoOut connectionWithMediaType:AVMediaTypeVideo];

int frameRate;
NSString *sessionPreset = AVCaptureSessionPreset640x480;
CMTime frameDuration = kCMTimeInvalid;
// For single core systems like iPhone 4 and iPod Touch 4th Generation wI 
//use a lower resolution and framerate to maintain real-time performance.
if ( [[NSProcessInfo processInfo] processorCount] == 1 )
{
    if ( [_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720] ) {
        sessionPreset = AVCaptureSessionPreset1280x720;
    }
    frameRate = 59;
}
else
{
    // USE_GPU_RENDERER is set in the project's build settings
 #if ! use_gpu_renderer
    // When using the CPU renderer we lower the resolution to 720p so that all devices can maintain real-time performance (this is primarily for A5 based devices like iPhone 4s and iPod Touch 5th Generation).
    if ( [_captureSession canSetSessionPreset:AVCaptureSessionPreset640x480] ) {
        sessionPreset = AVCaptureSessionPreset640x480;
    }
 #endif // ! use_gpu_renderer

    frameRate = 59;
}

_captureSession.sessionPreset = sessionPreset;

frameDuration = CMTimeMake( 1, frameRate );



NSError *error = nil;

if ( [videoDevice lockForConfiguration:&error] ) {
    videoDevice.activeFormat = bestFormat;
    [**videoDevice setActiveVideoMaxFrameDuration:frameDuration];
    [videoDevice setActiveVideoMinFrameDuration:frameDuration**];
    [videoDevice unlockForConfiguration];
}
else {
    NSLog(@"videoDevice lockForConfiguration returned error %@", error);
}

self.videoOrientation = [_videoConnection videoOrientation];

[videoOut release];

return;
