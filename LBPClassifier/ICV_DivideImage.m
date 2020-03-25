function [imgWindows,num_Windows] = ICV_DivideImage(img,windowSize)
    %For dividing image into non overlapping windows
    [H,W] = size(img);
    num_Windows = (H/windowSize)^2;
    num_WindowsHorizontal = H/windowSize;
    imgWindows = zeros(windowSize,windowSize,num_Windows);

    p = 1;
    windowNumStart = 1;
    windowNum = 1;
    for i = 1:H
        if mod(windowNum,num_WindowsHorizontal) == 0 && p > windowSize
            windowNumStart = windowNum+1;
            p = 1;
        end
        q = 1;
        windowNum = windowNumStart;
        for j = 1:W
            imgWindows(p,q,windowNum) = img(i,j);
            q = q+1;
            if q > windowSize
                windowNum = windowNum + 1;
                q = 1;
            end
        end
        windowNum = windowNum - 1;
        p = p+1;
    end
end