function frameDilated = ICV_Dilate1(frame,numDilations)
    [H,W] = size(frame);
    frame = logical(ICV_Pad(frame,2));
    frameDilated = frame;
    
    for k = 1:numDilations
        for i =2:H-1
            for j =2:W-1
                nb = [frame(i-1,j);frame(i+1,j);frame(i,j)];
                for m = 1:3
                    if nb(m) == 1
                        frameDilated(i,j) = 1;
                        break;
                    end
                end
            end
        end
        frame = frameDilated;
    end
    
end