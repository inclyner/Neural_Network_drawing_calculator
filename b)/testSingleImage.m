function [output] = testDatasets(opcao, imgpath)
%opcao => op ou num

res=30;
diretorio_principal = 'DataSet';


switch opcao

    case "num"
load("networks/logsigsoftmaxNumNet.mat","net");
matrixTarget = [0, 1, 2, 3, 4, 5,6,7,8,9];
binaryMatrix  = zeros(res * res,3);

        caminho = imgpath;
        img = imread(caminho(1));
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, 1) = reshape(binarizedImg, 1, []);
        out = sim(net, binaryMatrix);
        
          [a, b] = max(out);
            switch(b(1))
                case 1
                    output=0;
                case 2
                    output =1;
                    
                case 3
                    output=2;
               
                case 4
                    output = 3;

                case 5
                    output = 4;

                case 6
                    output = 5;

                case 7
                    output = 6;

                case 8
                    output = 7;

                case 9
                    output = 8;

                case 10
                    output = 9;

                otherwise
                    output = "Could not recognize";
            end



    case "op"

load("networks/logsigsoftmaxOp_Net.mat","net");

matrixTarget = ["+","/","*","-"];

        caminho = imgpath;
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, 1) = reshape(binarizedImg, 1, []);
        out = sim(net, binaryMatrix);
        
        [a, b] = max(out);
            switch(b(1))
                case 1
                    output="*";
                case 2
                    output ="+";
                case 3
                    output="-";
                  
                case 4
                    output = "/";
            end


end

disp(output)

end