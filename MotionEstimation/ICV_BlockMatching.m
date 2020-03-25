function [X,Y,DX,DY,framesPredicted] = ICV_BlockMatching(frames,windowSize,blockSize)
    [H,W,C,N] = size(frames);
    %Pads the frames based on difference between block size and window size
    paddingSize = windowSize-blockSize; %No. of total cols/rows to be added
    step = paddingSize/2;

    %Pads every frame and converts padded frames into grayscale 
    framesPadded = zeros(H+paddingSize,W+paddingSize,C,N);
    framesPaddedGray = zeros(H+paddingSize,W+paddingSize,N);
    for i = 1:N
        framesPadded(:,:,:,i) = ICV_Pad2(frames(:,:,:,i),paddingSize); 
        framesPaddedGray(:,:,i) = ICV_Gray(framesPadded(:,:,:,i));
    end

    %New height and width for padded frames
    newH = size(framesPaddedGray(:,:,1),1);
    newW = size(framesPaddedGray(:,:,1),2);
    
    %Initialize array for storing centre coordinates for reference and matched blocks
    referenceBlockCentres = zeros(2,H/blockSize*W/blockSize,N); 
    matchedBlockCentres = zeros(2,H/blockSize*W/blockSize,N);
    %Variables for centre X and Y for matched blocks
    startX = 0;
    startY = 0;
    %Traverses through all frames
    for l = 1:N-1
        %fprintf('Frame %d\n',l)
        count = 0;
        for i = step+1:blockSize:newH-step
            for j = step+1:blockSize:newW-step
                count = count+1; %Tracks block number
                
                %Assigns reference block and stores centre coordinates
                block1 = framesPaddedGray(i:i+blockSize-1,j:j+blockSize-1,l);
                referenceBlockCentres(1,count,l) = i+blockSize/2;
                referenceBlockCentres(2,count,l) = j+blockSize/2;
                
                %Traverses inside search window in next frame for block1
                minError = 10000;
                for m = i-step:i-step+windowSize-blockSize
                    for n = j-step:j-step+windowSize-blockSize
                        block2 = framesPaddedGray(m:m+blockSize-1,n:n+blockSize-1,l+1);
                        errorBlock = abs(block1-block2)/blockSize;
                        errorSum = sum(sum(errorBlock));
                        if errorSum < minError
                            minError = errorSum;
                            startX = m;
                            startY = n;
                        end
                    end  
                end
                %Stores matched block centre coordinates
                matchedBlockCentres(1,count,l) = startX+blockSize/2;
                matchedBlockCentres(2,count,l) = startY+blockSize/2;
            end
        end
    end
    
    X = matchedBlockCentres(1,:,:);
    Y = matchedBlockCentres(2,:,:);
    %Displacement vectors for reference blocks to matched blocks
    DX = X-referenceBlockCentres(1,:,:);
    DY = Y-referenceBlockCentres(2,:,:);
    
    %To move blocks in padded region
    framesPredicted = framesPadded;

    %For predicting frames
    for l = 1:N-1
        count = 0;
        for i = step+1:blockSize:newH-step
            for j = step+1:blockSize:newW-step
                count = count+1;
                modelBlock = framesPredicted(i:i+blockSize-1,j:j+blockSize-1,:,l);
                %Displaced indexes for blocks
                di = i + DX(:,count,l);
                dj = j + DY(:,count,l);
                framesPredicted(di:di+blockSize-1,dj:dj+blockSize-1,:,l) = modelBlock;
            end
        end
    end

    %To ignore the zeros in the padding
    framesPredicted = framesPredicted(step+1:newH-step,step+1:newW-step,:,:);
end