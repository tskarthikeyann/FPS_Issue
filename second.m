AVCaptureDeviceFormat *bestFormat = nil;
  AVFrameRateRange *bestFrameRateRange = nil;
  for ( AVCaptureDeviceFormat *format in [videoDevice formats] ) {
    for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges ) {
        if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate ) {
            bestFormat = format;
            bestFrameRateRange = range;
        }
    }
}
NSError *error = nil;

if ( bestFormat ) {
if ( [videoDevice lockForConfiguration:&error] ) {
    videoDevice.activeFormat = bestFormat;
    videoDevice.activeVideoMinFrameDuration = bestFrameRateRange.minFrameDuration;
    videoDevice.activeVideoMaxFrameDuration = bestFrameRateRange.maxFrameDuration;
    [videoDevice unlockForConfiguration];
    }}
    