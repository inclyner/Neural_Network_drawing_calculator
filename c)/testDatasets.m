function testDatasets(netNameNum,netNameOp)

res=30;

diretorio_principal = 'DataSet';
counter = 1;
num = 1;
load(strcat("networks/",netNameNum),"net");


matrixTarget = [0, 1, 2, 3, 4, 5,6,7,8,9];
matrixTarget = repelem(matrixTarget, 3);
binaryMatrix  = zeros(res * res,3);
for pasta=0:9
    for imagem=1:3
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, counter) = reshape(binarizedImg, 1, []);
        out = sim(net, binaryMatrix);
        
        [a, b] = max(out);
        if((b(counter)-1)==matrixTarget(counter))
            num=num + 1;
        end
         counter=counter+1;
    end
end
fprintf("\nnumeros: %f",num/30*100);





counter=1;
num=1;
load(strcat("networks/",netNameOp),"net");

matrixTarget = ["+","/","*","-"];
matrixTarget = repelem(matrixTarget, 3);

array_nomes_pasta_op = ["add","div","mul","sub"];
% Loop através das pastas
for pasta = array_nomes_pasta_op
    % Loop através das imagens
    for imagem = 1:3
        caminho = fullfile(diretorio_principal, num2str(pasta), [num2str(imagem) '.png']);
        img = imread(caminho);
        img = imresize(img, [res,res]);
        binarizedImg = imbinarize(img);
        binaryMatrix(:, counter) = reshape(binarizedImg, 1, []);
        out = sim(net, binaryMatrix);
        
        [a, b] = max(out);
            switch(b(counter))
                case 1
                    if(matrixTarget(counter)=="+")
                        num=num+1;
                    end
                case 2
                    if(matrixTarget(counter)=="/")
                        num=num+1;
                    end
                case 3
                    if(matrixTarget(counter)=="*")
                        num=num+1;
                    end
                case 4
                    if(matrixTarget(counter)=="-")
                        num=num+1;
                    end
            end

         counter=counter+1;

    end
end
fprintf("\nnumeros: %f",num/12*100);


end