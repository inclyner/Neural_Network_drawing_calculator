# Year 2022/2023
## Bachelor's Degree in Computer Engineering
### Knowledge and Reasoning
#### Practical Work Report

**Authors:**
- Francisco Carvalho – 2019129635
- João Fernandes – 2018011501

## Table of Contents
1. [Introduction](#introduction)
2. [Decisions Made](#decisions-made)
   - 2.1. Preprocessing of Images
   - 2.2. Targets
   - 2.3. Tests
   - 2.4. Saved Data
3. [Training and Statistical Analysis](#training-and-statistical-analysis)
   - 3.1. Start Folder
   - 3.2. Train Folder
     - 3.2.1 Single Model Training: Numbers + Operators
     - 3.2.2 Separate Model Training: Numbers and Operators
   - 3.3. Dataset
4. [Graphical Interface](#graphical-interface)
5. [Conclusion](#conclusion)
6. [Bibliography](#bibliography)

---

## 1. Introduction
This project was conducted as part of the Knowledge and Reasoning course, aiming to study neural networks for the identification of numbers (0 to 9) and operators (+, /, x, -), with the goal of creating an application resembling a calculator using a feed-forward neural network.

## 2. Decisions Made
### 2.1. Preprocessing of Images
To optimize our application, we resized images to 30x30 pixels (previously 150x150) and converted them into binary matrices.

### 2.2. Targets
We created a matrix of vectors containing numbers and operators (0, 1, 2, ..., 9, +, /, x, -). In the "Start" folder, the target matrix dimensions were 1x70, and in the "Train1" folder, it was 1x700.

### 2.3. Tests
We conducted tests using the following parameters:
- Epochs: 20, and for faster models, 1000 epochs.
- Number of trainings per configuration: 10.

### 2.4. Saved Data
For each configuration, we saved the best model out of 10 trainings in the "networks" folder.

## 3. Training and Statistical Analysis
### 3.1. Start Folder
Used to train the network with 5 images, achieving an overall accuracy of 81%.

### 3.2. Train Folder
This folder hosted most tests with different configurations:
#### 3.2.1 Single Model Training: Numbers + Operators
The best configuration included:
- Number of hidden layers: 1
- Number of neurons: 10
- Activation functions: tansig, softmax
- Training function: trainlm
- Data split: 0.7 train, 0.15 validation, 0.15 test
Resulting in a global accuracy of 90% and test accuracy of 70%.

#### 3.2.2 Separate Model Training: Numbers and Operators
Different activation function configurations were tested, averaging the following results:
- Configuration 1: Global accuracy 84%, test accuracy 69%
- Configuration 2: Global accuracy 68%, test accuracy 60%
- Configuration 3: Global accuracy 93%, test accuracy 78%
- Configuration 4: Global accuracy 67%, test accuracy 57%
- Configuration 5: Global accuracy 63%, test accuracy 54%
- Configuration 6: Global accuracy 92%, test accuracy 77%
The configuration 3 showed the highest precision compared to the single model training.

### 3.3. Dataset
Created datasets for each digit and operator, consisting of 3 images each, processed into binary matrices similar to the "Start" and "Train1" images. Classification using the best neural network configuration achieved 90% success for numbers and 40% for operators.

## 4. Graphical Interface
The application allows loading data from datasets individually, detecting characters and functioning as a simple calculator.
![image](https://github.com/inclyner/Neural_Network_drawing_calculator/assets/84443911/d1502805-1c39-44f5-b67b-bd60f5f3abd7)


## 5. Conclusion
Parameter configuration plays a crucial role in neural network performance, varying based on the specific problem. Proper image preprocessing is vital to focus on relevant character features. In summary, this neural network project was successful in terms of understanding and applying concepts, and in developing networks with satisfactory performance.


