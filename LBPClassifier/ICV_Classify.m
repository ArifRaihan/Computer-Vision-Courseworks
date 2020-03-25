function Class = ICV_Classify(histTest,histFace,histCar)
    %Reference images for car and face
    similarityCar = ICV_HistSimilarity(histTest,histCar);
    similarityFace = ICV_HistSimilarity(histTest,histFace);

    if similarityCar > similarityFace
        Class = 'Car';
    else
        Class = 'Face';
    end

end