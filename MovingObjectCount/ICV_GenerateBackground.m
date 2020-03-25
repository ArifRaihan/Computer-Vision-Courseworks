function backgroundImg = ICV_GenerateBackground(frames)
    [H,W,C,N] = size(frames);
    sumImg = uint16(zeros(H,W,C));
    frames16 = uint16(frames);

    for k = 1:N
        for i = 1:H
            for j = 1:W
                sumImg(i,j,:) = sumImg(i,j,:) + frames16(i,j,:,k);
            end
        end
    end

    avgImg = sumImg/size(frames,4);
    backgroundImg = uint8(avgImg);

end