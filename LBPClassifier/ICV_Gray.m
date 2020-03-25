function imgGray = ICV_Gray(img)
    [H,W,~] = size(img);
    imgGray = zeros(H,W);
    for x = 1:H
        for y = 1:W
            imgGray(x,y) = (.299 * img(x,y,1)) + (.587 * img(x,y,2)) + (.114 * img(x,y,3)); 
            %imgGray(x,y) = imgGray(x,y)/255;  %Scales image pixels to values between 0 and 1
        end
    end
end
