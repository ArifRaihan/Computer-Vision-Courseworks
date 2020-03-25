function frameDifference = ICV_FindFrameDiff(referenceFrame,nextFrame,threshold)
    [H,W] = size(referenceFrame);
    frameDifference = abs(referenceFrame-nextFrame);
    %If threshold is 0, skip next loop for thresholding
    if threshold == 0
        return;
    end
    
    for i = 1:H
        for j = 1:W
            if frameDifference(i,j) > threshold
                frameDifference(i,j) = 255; 
            else
                frameDifference(i,j) = 0;
            end
        end
    end

end