function img_pad = ICV_Pad(img,padSize)
    [H,W,~] = size(img);
    
    stepStart = 2;
    stepEnd = stepStart-1;
    
    newH = H + padSize;
    newW = W + padSize;
    
    img_pad = zeros(newH,newW);
    img_pad(stepStart:newH-stepEnd,stepStart:newW-stepEnd) = img(:,:);

end