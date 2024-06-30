function calculadora_TP()
%CALCULADORA_DATASET Summary of this function goes here
%   Detailed explanation goes here

clear all;
close all;

% Definir o diretório principal
diretorio_principal = 'NN datasets\start';diretorio_principal = 'NN datasets\start';

% Variável para armazenar as imagens binárias
imagens_binarias = [];

% Loop através das pastas
for pasta = 0:9
    % Loop através das imagens
    for imagem = 1:5
        % Construir o caminho da imagem
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);

        % Ler a imagem
        imagem_original = imread(caminho);
        outputSize = [50, 50]; % Width x Height

        % Resize the image
        resizedImage = imresize(imagem_original, outputSize);
        % Converter a imagem para binário
        imagem_binaria = imbinarize(resizedImage);

        % Armazenar a imagem binária
        imagens_binarias = cat(3, imagens_binarias, imagem_binaria);

    end
end

% Verificar o tamanho da matriz resultante
tamanho = size(imagens_binarias);

% Exemplo de acesso a uma imagem binária específica
%imagem_2_2 = imagens_binarias(:,:,2); % Acessa a segunda imagem da primeira pasta

% Exemplo de exibição de uma imagem binária
%imshow(imagem_2_2);

matriz = [...
    0 0 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5  6 6 6 6 6 7 7 7 7 7  8 8 8 8 8  9 9 9 9 9
];

% Variável para armazenar as imagens binárias
imagens_binarias_operadores = [];
array_nomes_pasta_op = ["add","div","mul","sub"];
% Loop através das pastas
for pasta = array_nomes_pasta_op
    % Loop através das imagens
    for imagem = 1:5
        % Construir o caminho da imagem
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);

        % Ler a imagem
        imagem_original = imread(caminho);

        % Converter a imagem para binário
        imagem_binaria = imbinarize(imagem_original);

        % Armazenar a imagem binária
        imagens_binarias_operadores = cat(3, imagens_binarias_operadores, imagem_binaria);

    end
end

% Verificar o tamanho da matriz resultante
tamanho = size(imagens_binarias_operadores);

% Exemplo de acesso a uma imagem binária específica
%imagem_2_2 = imagens_binarias_operadores(:,:,1*5 +1); % Acessa a segunda imagem da primeira pasta

%imshow(imagem_2_2);

matriz_op = [...
    "add" "add" "add" "add" "add";
    "div" "div" "div" "div" "div";
    "mul" "mul" "mul" "mul" "mul";
    "sub" "sub" "sub" "sub" "sub";
];

%reorganização dos dados

%inputData = reshape(imagem_2_2, [], 1); % transforma a imagem binaria num array de uma coluna
incrementador = 1;
num_pastas = 10;
num_imagens = 5;
%total_iteracoes = num_pastas * num_imagens;https://github.com/RafaelSGil/Shape-Recognition-Network/blob/main/src/binarizedImageApp.m

array_total = [];   
%imagem_total = imagens_binarias(:,:,1)
% Loop através das pastas
for pasta = 0:9
    % Loop através das imagens
    for imagem = 1:5
    imagem_total = imagens_binarias(:,:,incrementador);
    inputData = imagem_total(:);
    array_total{incrementador}=inputData;
    incrementador=incrementador+1;
    end

end

%definição de parametros rede neuronal
% Concatenate the individual arrays into a single matrix
concatenatedData = cell2mat(cellfun(@(x) x(:), array_total, 'UniformOutput', false));
logicalconcatenatedData = logical(concatenatedData);
logicalm=logical(matriz);
quant_neuronios = 10; % numero de neuronios camada escondida
net_num = feedforwardnet(quant_neuronios)
net_op = feedforwardnet(quant_neuronios);

net_num.trainParam.epochs = 1;

% [net_num,tr] = train(net_num,logicalconcatenatedData ,logicalm)



%view(net_num);
%disp(tr);

%out = sim(net_num, logicalconcatenatedData);

%plotconfusion(logicalm, out) % Matriz de confusao
globalAccuracy = zeros(1, 10); % Initialize array to store accuracy values for each run

for run = 1:10
    % Train the neural network model
    [net_num,tr] = train(net_num, logicalconcatenatedData, logicalm);

    % Test the neural network model
    out = sim(net_num, logicalconcatenatedData);
    predictedLabels = vec2ind(out);

    % Calculate accuracy
    accuracy = sum(out == predictedLabels) / numel(out);

    % Store accuracy value for this run
    globalAccuracy(run) = accuracy;

    % Display confusion matrix
    plotconfusion(logicalm, out);
    title(sprintf('Confusion Matrix - Run %d', run));
    xlabel('Predicted Class');
    ylabel('Actual Class');
    set(gca,'xticklabel', {'0','1', '2', '3', '4', '5', '6', '7', '8', '9'});
    set(gca,'yticklabel', {'0','1', '2', '3', '4', '5', '6', '7', '8', '9'});
    colorbar;
    drawnow;
    pause(1); % Pause to view the confusion matrix
end

% Calculate and display the average accuracy over 10 runs
averageAccuracy = mean(globalAccuracy);
fprintf('Average Accuracy: %.2f%%\n', averageAccuracy * 100);

end

