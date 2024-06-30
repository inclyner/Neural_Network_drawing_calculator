function [output] = trainNetwork(trainParam, transfer1,transfer2,divide,trainRatio,valRatio,testRatio,opcao,nome)




accuracyarray =zeros(10,1);
testaccuracyarray =zeros(10,1);

outputDir = "networks\";
outputFile = fullfile(outputDir, strcat(nome, ".mat"));

bestAcc=0;

for i=1:10

net = feedforwardnet([10]);
net.trainFcn = trainParam;
net.layers{1}.transferFcn = transfer1;
net.layers{2}.transferFcn = transfer2;
%net.layers{3}.transferFcn = "purelin";
net.divideFcn = divide;
net.divideParam.trainRatio = trainRatio;
net.divideParam.valRatio = valRatio;
net.divideParam.testRatio = testRatio;
net.trainParam.epochs = 20;

opcao1=opcao;


[in, matrixTarget] = StartTrain(opcao1);

[net,tr] = train(net, in, matrixTarget);


%% Simular e analisar resultados

out = sim(net, in);

accuracy = 0;
for k = 1:size(out,2)
    [~,maxIndex] = max(out(:,k));
    [~,targetIndex] = max(matrixTarget(:,k));
    if maxIndex == targetIndex
        accuracy = accuracy + 1;
    end
end
accuracy = accuracy / size(out,2);


plotconfusion(matrixTarget,out)

fprintf('Precisão total de treino %f\n', accuracy*100)

if accuracy>bestAcc
save(outputFile, "net");
bestAcc=accuracy;
end

% Calculate the accuracy on the test set
testOut = sim(net,in(:,tr.testInd)); 
testAccuracy = 0;
for j = 1:size(testOut,2)
    [~,maxIndex] = max(testOut(:,j));
    [~,targetIndex] = max(matrixTarget(:,tr.testInd(j))); 
    if maxIndex == targetIndex
        testAccuracy = testAccuracy + 1;
    end
end
testAccuracy = testAccuracy / size(testOut,2);
fprintf('Precisão total de teste %f\n', testAccuracy*100)


accuracyarray(i)=accuracy*100;
testaccuracyarray(i)=testAccuracy*100;


end




mediaAccuracy = mean(accuracyarray);
mediatestaccuracy = mean(testaccuracyarray);
fprintf('Average accuracy das 10 runs %f\n', mediaAccuracy);
fprintf('Average da accuracy dos testes em 10 runs %f\n', mediatestaccuracy);

end