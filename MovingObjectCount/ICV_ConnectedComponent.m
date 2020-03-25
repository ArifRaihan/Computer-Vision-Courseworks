function objectCountFrames = ICV_ConnectedComponent(framesDilated)
    [H,W,N] = size(framesDilated);
    eqList = zeros(500,N);
    
    connectedLabels = zeros(H+2,W+2);
    for k = 1:N-1
        m = framesDilated(:,:,k);
        currentLabel = 1;
        for i = 2:H-1
            for j = 2:W-1
                neighbors = [m(i,j-1),m(i-1,j)];
                if m(i,j) == 1    
                    if and(neighbors(1) == 0,neighbors(2) == 0)
                        
                        connectedLabels(i,j) = currentLabel;
                        currentLabel = currentLabel+1;
            
                    elseif xor(neighbors(1) == 1, neighbors(2) == 1)
                        if neighbors(1) == 1
                            connectedLabels(i,j) = connectedLabels(i,j-1);
                        end
                
                        if neighbors(2) == 1
                            connectedLabels(i,j) = connectedLabels(i-1,j);
                        end
                
                    elseif and(neighbors(1) == 1, neighbors(2) == 1)
                        if connectedLabels(i,j-1) ~= connectedLabels(i-1,j)
                            minLabel = min(connectedLabels(i,j-1),connectedLabels(i-1,j));
                            maxLabel = max(connectedLabels(i,j-1),connectedLabels(i-1,j));
                            connectedLabels(i,j) = minLabel;
                            eqList(maxLabel,k) = minLabel;
                        else
                            connectedLabels(i,j) = neighbors(1);
                        end
                    end    
                end
            end
    
            for j = 2:W-1
                s = connectedLabels(i,j);
                if s == 0
                    continue
                end
                if eqList(s,k) ~= 0
                    connectedLabels(i,j) = eqList(s,k);
                end
            end
        end

        for i = 1:H+2
            for j = 1:W+2
                s = connectedLabels(i,j);
                if s == 0
                    continue
                end
                if eqList(s) ~= 0
                    connectedLabels(i,j) = eqList(s);
                end
            end
        end
    end
    
    objectCountFrames = zeros(1,140);
    for i = 1:N-1
        objectCountFrames(:,i) = size(unique(eqList(:,i)),1);
    end
end