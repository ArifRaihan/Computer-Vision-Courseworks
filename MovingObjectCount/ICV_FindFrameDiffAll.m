function frameDifferenceAll = ICV_FindFrameDiffAll(frames,threshold)
    [H,W,N] = size(frames);
    frameDifferenceAll = zeros(H,W,N);
    for k = 1:N-1
        frameDifferenceAll(:,:,k) = abs(frames(:,:,k)-frames(:,:,k+1));
        for i = 1:H
            for j = 1:W
                if frameDifferenceAll(i,j,k) > threshold
                    frameDifferenceAll(i,j,k) = 255; 
                else
                    frameDifferenceAll(i,j,k) = 0;
                end
            end
        end
    end
end