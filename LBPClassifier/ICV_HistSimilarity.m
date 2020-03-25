function similarity = ICV_HistSimilarity(hist1,hist2)
    
    commonHist = zeros(size(hist1,1),1);
    for i = 1:size(hist1,1)
        commonHist(i,1) = min(hist1(i),hist2(i));
    end
    
    similarity = sum(commonHist)/max(sum(hist1),sum(hist2));
end