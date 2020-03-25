# Computer-Vision-Courseworks
I have uploaded some of the courseworks which I found very interesting to work with.

<b>LBP Classifier</b>

The classifier uses the histogram intersection similarity measure to compare two histograms. The classifier takes as input the LBP global descriptors for test image and two LBP global descriptors of two reference images for face and car. The global descriptors for each of these images are the concatenated histograms computed in the previous task. Then the classifier will compute the histogram similarity value of test image descriptor with reference car image descriptor and another similarity value of test image descriptor with reference face image descriptor. If the similarity value for test image with car is greater than that with face, the classifier will classify the test image as a car and vice-versa. Two face and car images from the dataset are chosen as reference images and the other four are chosen as test images. 
<img src = 'CVCWScreenshot/LBPClassifier.png'/>
<img src = 'CVCWScreenshot/LBPClassifier2.png'/>
