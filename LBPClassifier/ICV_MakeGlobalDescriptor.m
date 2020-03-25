function histCombined = ICV_MakeGlobalDescriptor(img,windowSize)
    [histWindows,LBPWindows] = ICV_LBP(img,windowSize);
    num_Windows = size(histWindows,2);
    
    histWindowsNorm = zeros(size(histWindows,1),num_Windows);
    %Normalizes histograms for every window
    for i = 1:num_Windows
        histWindowsNorm(:,i) = ICV_NormalizeHistogram(histWindows(:,i));
    end
    
    histCombined = ICV_ConcatenateHistograms(histWindowsNorm);
end

