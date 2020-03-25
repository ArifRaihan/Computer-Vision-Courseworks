%% Task4(a)

%Reads Video
videoC = VideoReader('DatasetC.mpg');
frames = read(videoC);

%Function takes an array of frames as input and returns motion field and predictedfFrames
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),20,16);  %Takes frames 7 and 8 as input

%Shows frame 7 and 8 and superimposes motion vectors for frame 7 on frame 8
subplot(2,3,1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(2,3,3);
imshow(frames(:,:,:,8));
title('Frame 8');

subplot(2,3,5);
imshow(frames(:,:,:,8));
%title('Superimposed motion vectors on Frame 8');
hold on
quiver(Y(:,:,1),X(:,:,1),DY(:,:,1),DX(:,:,1),'white');

%% Task 4(b)
%Shows predicted frame

[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),20,16);

subplot(1,3,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,3,2);
figure(1);
imshow(uint8(frames(:,:,:,8)));
title('Frame 8');

subplot(1,3,3);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');

%% Set arrays to store execution time for c and d
timeDiffBlockSize = zeros(3,1);
timeDiffWindowSize = zeros(3,1);
%% Task 4(c)
%Window size 16x16 and block size 4x4

%t1 and t2 for calculating elapsed time for running the function
t1 = datetime;
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),16,4);
t2 = datetime;

timeDiffBlockSize(1) = (t2.Hour*60+t2.Minute*60+t2.Second)-(t1.Hour*60+t1.Minute*60+t1.Second);

subplot(1,2,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,2,2);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');

%% Task 4(c)
%Window size 16x16 and block size 8x8
t1 = datetime;
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),16,8);
t2 = datetime;

timeDiffBlockSize(2) = (t2.Hour*60+t2.Minute*60+t2.Second)-(t1.Hour*60+t1.Minute*60+t1.Second);

subplot(1,2,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,2,2);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');
%% Task 4(c)
%Window size 16x16 and block size 16x16
t1 = datetime;
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),16,16);
t2 = datetime;

timeDiffBlockSize(3) = (t2.Hour*60+t2.Minute*60+t2.Second)-(t1.Hour*60+t1.Minute*60+t1.Second);

subplot(1,2,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,2,2);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');

%% Task 4(d)
%Block size 8x8 and Window size 8x8
t1 = datetime;
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),8,8);
t2 = datetime;

timeDiffWindowSize(1) = (t2.Hour*60+t2.Minute*60+t2.Second)-(t1.Hour*60+t1.Minute*60+t1.Second);

subplot(1,2,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,2,2);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');

%% Task 4(d)
%Block size 8x8 and Window size 16x16
t1 = datetime;
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),16,8);
t2 = datetime;

timeDiffWindowSize(2) = (t2.Hour*60+t2.Minute*60+t2.Second)-(t1.Hour*60+t1.Minute*60+t1.Second);

subplot(1,2,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,2,2);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');

%% Task 4(d)
%Block size 8x8 and Window size 32x32
t1 = datetime;
[X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames(:,:,:,7:8),32,8);
t2 = datetime;

timeDiffWindowSize(3) = (t2.Hour*60+t2.Minute*60+t2.Second)-(t1.Hour*60+t1.Minute*60+t1.Second);

subplot(1,2,1);
figure(1);
imshow(frames(:,:,:,7));
title('Frame 7');

subplot(1,2,2);
figure(1);
imshow(uint8(framesPredicted(:,:,:,1)));
title('Predicted frame 8');
%% Task 4(e) Plot execution time for varying block sizes

blockSizes = [4,8,16];
plot(blockSizes,timeDiffBlockSize);
ylim([0 2]);
ylabel('Time executed (Seconds)');
xlabel('Block Sizes');
%% Task 4(e) Plot execution time for varying window sizes
windowSizes = [8,16,32];
plot(windowSizes,timeDiffWindowSize);
ylim([0 2]);
ylabel('Time executed (Seconds)');
xlabel('Window Sizes');