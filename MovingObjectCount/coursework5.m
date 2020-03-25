%% Task 5(a) Frame differencing using reference frame

videoC = VideoReader('DatasetC.mpg');
frames = read(videoC);
[H,W,C,N] = size(frames);
framesGray = zeros(H,W,N);
%Converts to grayscale first
for i = 1:N
    framesGray(:,:,i) = ICV_Gray(frames(:,:,:,i));
end

referenceFrame = framesGray(:,:,1);
%Frame differencing function does no threshold when argument is 0
frameDiff = ICV_FindFrameDiff(referenceFrame,framesGray(:,:,34),0);
frameDiffThresh = ICV_FindFrameDiff(referenceFrame,framesGray(:,:,34),50);
figure(1);
    
subplot(2,2,1);
imshow(uint8(referenceFrame));
title('Reference Frame');
    
subplot(2,2,2);
imshow(uint8(framesGray(:,:,8)));
title('Next Frame');
    
subplot(2,2,3);
imshow(uint8(frameDiff));
title('Frame difference');

subplot(2,2,4);
imshow(frameDiffThresh);
title('Frame difference Threshold');


%% Task 5(b) Frame differencing between consecutive frames

[H,W,C,N] = size(frames);
framesGray = zeros(H,W,N);

for i = 1:N
    framesGray(:,:,i) = ICV_Gray(frames(:,:,:,i));
end

frameDiff = ICV_FindFrameDiff(framesGray(:,:,28),framesGray(:,:,29),0);
frameDiffThresh = ICV_FindFrameDiff(framesGray(:,:,28),framesGray(:,:,29),20);

subplot(2,2,1);
imshow(uint8(framesGray(:,:,6)));
title('Reference Frame');
    
subplot(2,2,2);
imshow(uint8(framesGray(:,:,7)));
title('Next Frame');
    
subplot(2,2,3);
imshow(uint8(frameDiff));
title('Frame difference');

subplot(2,2,4);
imshow(frameDiffThresh);
title('Frame difference Threshold');
%% Task 5(c)Generate background from all frames in video
videoC = VideoReader('DatasetC.mpg');
frames = read(videoC);
bg = ICV_GenerateBackground(frames);
imshow(bg);
title('Background Image');

%% Task 5(d) Counting the number of moving objects

videoC = VideoReader('DatasetC.mpg');
frames = read(videoC);
[H,W,C,N] = size(frames);
framesGray = zeros(H,W,N);

for i = 1:N
    framesGray(:,:,i) = ICV_Gray(frames(:,:,:,i));
end
%Subtracting background image from all frames
bGray = ICV_Gray(bg);
foreground = framesGray;
for i = 1:N
    foreground(:,:,i) = abs(foreground(:,:,i) - bGray);
end

%Finds difference between all frames
frameDifferences = logical(ICV_FindFrameDiffAll(foreground,37));
%% Task 5(d) Dilation operation to expand the white pixels and connect them

framesDilated = logical(zeros(H+2,W+2,N));

for i = 1:N-1
    framesDilated(:,:,i) = ICV_Dilate1(frameDifferences(:,:,i),7);
end
% 
%For dilating 2nd time over the previously dilated ones
framesDilated2 = framesDilated(2:H+1,2:W+1,:);
for i = 1:N-1
    framesDilated(:,:,i) = ICV_Dilate2(framesDilated2(:,:,i),3);
end



%% Task 5(d) Applies connected component algorithm to count connected regions

objectCountFrames = ICV_ConnectedComponent(framesDilated);

for i = 1:N-1
    figure(1);
    imshow(framesDilated(:,:,i));
    title(['Number of objects ',num2str(objectCountFrames(:,i))]);
end

%% Visualise number of moving objects over every frame
bar(objectCountFrames);
ylabel('Number of moving objects');
xlabel('Frame number');
title('Frame no vs Count')