function [histWindows,imgWindows,imgLBP] = ICV_LBP(img,windowSize)
    %First Pad Image, Second LBP image, Third Divide LBP image
    [H,W,~] = size(img);
    %Converts image to grayscale and adds zero padding
    imgGray = ICV_Gray(img);
    imgPadded = ICV_Pad(imgGray,2);
    [H2,W2] = size(imgPadded);
    %Creates a new image to store the LBP values of img
    imgLBP = zeros(H,W);
    BitCode = zeros(1,8);

    %Assigns LBP values to new image
    for i = 2:H2-1
        for j = 2:W2-1
            neighborPixelIndexes = [imgPadded(i,j-1),imgPadded(i+1,j-1),imgPadded(i+1,j),imgPadded(i+1,j+1),imgPadded(i,j+1),imgPadded(i-1,j+1),imgPadded(i-1,j),imgPadded(i-1,j-1)];
                            
            for p = 1:8
                if neighborPixelIndexes(p) > imgPadded(i,j)
                    BitCode(p) = 1;
                else
                    BitCode(p) = 0;
                end
            end
            imgLBP(i-1,j-1) = ICV_BitCodeToDecimal8(BitCode);
        end
    end
    
    %Calls function to divide image according to windowsize
    [imgWindows,num_Windows] = ICV_DivideImage(imgLBP,windowSize);
    
    %Finds Histograms for every window
    [Hw,Ww,~] = size(imgWindows);
    imgLBPHist = imgWindows(:,:,:)+1;
    histWindows = zeros(256,num_Windows);
    for k = 1:num_Windows
        for i = 1: Hw
            for j = 1:Ww
                histWindows(imgLBPHist(i,j,k),k) = histWindows(imgLBPHist(i,j,k),k) + 1;
            end
        end
    end
    
end
