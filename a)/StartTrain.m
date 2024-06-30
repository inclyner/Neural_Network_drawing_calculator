function [in, target] = StartTrain(opcao)
%CALCULADORA_DATASET Summary of this function goes here
%opcao = Start, Train

% Definir o diretório principal


res=30;


switch opcao
%% Case Start

case "Start"
diretorio_principal = 'NN datasets\start';
counter = 1;
binaryMatrix  = zeros(res * res,5);% binary matrix
for pasta=0:9
    for imagem=1:5
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, counter) = reshape(binarizedImg, 1, []);
        counter=counter+1;
    end
end

array_nomes_pasta_op = ["add","div","mul","sub"];
% Loop através das pastas
for pasta = array_nomes_pasta_op
    % Loop através das imagens
    for imagem = 1:5
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, counter) = reshape(binarizedImg, 1, []);
        counter=counter+1;
     
        
    end
end

matrixTarget = [0, 1, 2, 3, 4, 5,6,7,8,9,"+","/","*","-"];
matrixTarget = repelem(matrixTarget, 5);



%% Case Train
case "Train"

diretorio_principal = 'NN datasets\train1';
counter = 1;
binaryMatrix  = zeros(res * res, 50); %binary matrix

for pasta=0:9
    for imagem=1:50
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, counter) = reshape(binarizedImg, 1, []);
        counter=counter+1;
    end
end

counter = 1;
array_nomes_pasta_op = ["add","div","mul","sub"];
% Loop através das pastas
for pasta = array_nomes_pasta_op
    % Loop através das imagens
    for imagem = 1:50
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, counter) = reshape(binarizedImg, 1, []);
        counter=counter+1;
    end
end

matrixTarget = [0, 1, 2, 3, 4, 5,6,7,8,9,"+","/","*","-"];
matrixTarget = repelem(matrixTarget, 50); 



end


stringArray = string(matrixTarget);
classNames = unique(stringArray);
target = onehotencode(stringArray, 1, 'ClassNames', classNames);
%stringArray = string(matrixTarget);
%categoricalArray = categorical(stringArray);
%classNames = unique(stringArray);
%binaryMatrix =  binaryMatrix';
in = binaryMatrix;
%target = onehotencode(stringArray, 1, 'ClassNames', classNames);
%onehotencode(categoricalArray, 1,'ClassNames', 1:50);
%target = onehotencode(matrixTarget,1,'ClassNames',1:6);
end
