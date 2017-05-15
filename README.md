# Vehicle's Driver Detection

In this project we are developing a system to detect driver’s motion in an image taken from inside the car using camera on the dashboard.
This project uses Convolutional Neural Networks to train the model to classify the images into 10 different categories : c0 -  safe driving c1 - texting (right) c2 - talking on the phone (right) c3 - texting (left) c4 - talking on the phone (left) c5 - operating the radio c6 - drinking c7 - reaching behind c8 - hair and makeup c9 - talking to passenger

# Dataset

https://www.kaggle.com/c/state-farm-distracted-driver-detection/data

2D dashboard camera images where the driver’s actions are captured from passanger seat’s POV.

Training set - 15698 images
Validation set -3363 images
Test set - 3364 images

# CNN Model

Software Packages used - Caffe
Pre-trained model - Alexnet trained on ImageNet Dataset
Trained the model after fine-tuning on our train-set and validation-set for 100,000 iterations
Final model - 90000 iteration

# Observations

The accuracy of the model increased from 56% to 99.43% when weights from pretrained AlexNet model were used. By testing the images covered with patches it was observed the features learned were accurate. Images that in which irrelevant portion was covered, were classified correctly even after adding a patch. Whereas one of the images shows the classification wrong because a crucial part of the image was hidden. This image when tested without patch was classified correctly.
Also, it was observed that the dataset was over-fitted to the angle at which the images were taken and maybe to the 10 drivers that constituted the train-set. Since the original test set and train set have similar drivers the accuracy is very high but it dropped drastically when new driver images are tested.
To reduce the over-fitting problem model should be fine- tuned on a much more diverse dataset.

# Caffe

[![Build Status](https://travis-ci.org/BVLC/caffe.svg?branch=master)](https://travis-ci.org/BVLC/caffe)
[![License](https://img.shields.io/badge/license-BSD-blue.svg)](LICENSE)

Caffe is a deep learning framework made with expression, speed, and modularity in mind.
It is developed by the Berkeley Vision and Learning Center ([BVLC](http://bvlc.eecs.berkeley.edu)) and community contributors.

Check out the [project site](http://caffe.berkeleyvision.org) for all the details like

- [DIY Deep Learning for Vision with Caffe](https://docs.google.com/presentation/d/1UeKXVgRvvxg9OUdh_UiC5G71UMscNPlvArsWER41PsU/edit#slide=id.p)
- [Tutorial Documentation](http://caffe.berkeleyvision.org/tutorial/)
- [BVLC reference models](http://caffe.berkeleyvision.org/model_zoo.html) and the [community model zoo](https://github.com/BVLC/caffe/wiki/Model-Zoo)
- [Installation instructions](http://caffe.berkeleyvision.org/installation.html)

and step-by-step examples.

[![Join the chat at https://gitter.im/BVLC/caffe](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/BVLC/caffe?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Please join the [caffe-users group](https://groups.google.com/forum/#!forum/caffe-users) or [gitter chat](https://gitter.im/BVLC/caffe) to ask questions and talk about methods and models.
Framework development discussions and thorough bug reports are collected on [Issues](https://github.com/BVLC/caffe/issues).

Happy brewing!

## License and Citation

Caffe is released under the [BSD 2-Clause license](https://github.com/BVLC/caffe/blob/master/LICENSE).
The BVLC reference models are released for unrestricted use.

Please cite Caffe in your publications if it helps your research:

    @article{jia2014caffe,
      Author = {Jia, Yangqing and Shelhamer, Evan and Donahue, Jeff and Karayev, Sergey and Long, Jonathan and Girshick, Ross and Guadarrama, Sergio and Darrell, Trevor},
      Journal = {arXiv preprint arXiv:1408.5093},
      Title = {Caffe: Convolutional Architecture for Fast Feature Embedding},
      Year = {2014}
    }
