clc
clear all
% read the image with hand-written characters
title = 'D:\Vilniustech\Intelligent Systems\Lab4\pic1.jpeg';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(title, 5);
% Development of character recognizer
% take the features from cell-type variable and save into a matrix-type variable
P = cell2mat(pozymiai_tinklo_mokymui);
% create the matrices of correct answers for each line (number of matrices = number of symbol lines)
T = [eye(24), eye(24), eye(24), eye(24),eye(24)];
% create an RBF network for classification with 13 neurons, and sigma = 1
network = newrb(P,T,0,1,24);
%Test of the network (recognizer)
% estimate output of the network for unknown symbols (row, that were not used during training)
P2 = P(:,12:22);
Y2 = sim(network, P2);
% find which neural network output gives maximum value
[a2, b2] = max(Y2);
% Visualize result
% calculate the total number of symbols in the row
letter_num = size(P2,2);
% we will save the result in variable 'atsakymas'
result = [];
for k = 1:letter_num
    switch b2(k)
       case 1
            result = [result, 'X'];
        case 2
            result = [result, 'A'];
        case 3
            result = [result, 'B'];
        case 4
            result = [result, 'C'];
        case 5
            result = [result, 'D'];
        case 6
            result = [result, 'E'];
        case 7
            result = [result, 'F'];
        case 8
            result = [result, 'G'];
        case 9
            result = [result, 'H'];
        case 10
            result = [result, 'I'];
        case 11
            result = [result, 'J'];
            case 12
            result = [result, 'K'];
            case 13
            result = [result, 'L'];
            case 14
            result = [result, 'M'];
            case 15
            result = [result, 'N'];
            case 16
            result = [result, 'O'];
            case 17
            result = [result, 'P'];
            case 18
            result = [result, 'Q'];
        case 19
            result = [result, 'R'];
        case 20
            result = [result, 'S'];
            case 21
            result = [result, 'T'];
            case 22
            result = [result, 'U'];
            case 23
            result = [result, 'V'];
            case 24
            result = [result, 'W'];
    end
end
% show the result in command window
disp(result)
% Extract features of the test image
title = 'D:\Vilniustech\Intelligent Systems\Lab4\pic2.jpeg';
pozymiai_patikrai = pozymiai_raidems_atpazinti(title, 1);
% Perform letter/symbol recognition
% features from cell-variable are stored to matrix-variable
P2 = cell2mat(pozymiai_patikrai);
% estimating neuran network output for newly estimated features
Y2 = sim(network, P2);
% searching which output gives maximum value
[a2, b2] = max(Y2);
%Visualization of result
% calculating number of symbols - number of columns
letter_num = size(P2,2);
result = [];
for k = 1:letter_num
    switch b2(k)
        case 1
            result = [result, 'X'];
        case 2
            result = [result, 'A'];
        case 3
            result = [result, 'B'];
        case 4
            result = [result, 'C'];
        case 5
            result = [result, 'D'];
        case 6
            result = [result, 'E'];
        case 7
            result = [result, 'F'];
        case 8
            result = [result, 'G'];
        case 9
            result = [result, 'H'];
        case 10
            result = [result, 'I'];
        case 11
            result = [result, 'J'];
            case 12
            result = [result, 'K'];
            case 13
            result = [result, 'L'];
            case 14
            result = [result, 'M'];
            case 15
            result = [result, 'N'];
            case 16
            result = [result, 'O'];
            case 17
            result = [result, 'P'];
            case 18
            result = [result, 'Q'];
        case 19
            result = [result, 'R'];
        case 20
            result = [result, 'S'];
            case 21
            result = [result, 'T'];
            case 22
            result = [result, 'U'];
            case 23
            result = [result, 'V'];
            case 24
            result = [result, 'W'];
    end
end
figure(8), text(0.1,0.5,result,'FontSize',38), axis off

