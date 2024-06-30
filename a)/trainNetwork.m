function [output] = trainNetwork(trainParam, transfer1,transfer2,divide,trainRatio,valRatio,testRatio,opcao,nome)



net = feedforwardnet([10]);
net.trainFcn = trainParam;
net.layers{1}.transferFcn = transfer1;
net.layers{2}.transferFcn = transfer2;
net.divideFcn = divide;
net.divideParam.trainRatio = trainRatio;
net.divideParam.valRatio = valRatio;
net.divideParam.testRatio = testRatio;
opcao1=opcao;

[in, matrixTarget] = StartTrain(opcao1);


[net,tr] = train(net, in, matrixTarget);


outputDir = "networks/";
outputFile = fullfile(outputDir, strcat(nome, ".mat"));
save(outputFile, "net");

%% Simular e analisar resultados

out = sim(net, in);

r = 0;
for i=1:size(out,2)
    [a, b] = max(out(:,i));
    [c, d] = max(matrixTarget(:,i));
    if b == d
      r = r+1;
    end
end
plotconfusion(matrixTarget,out)
accuracy = r/size(out,2);
output = accuracy*100;
fprintf('Precisão total de treino %f\n', accuracy);

end