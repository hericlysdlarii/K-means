%% Inicialização
clear ; close all; clc

% Carregando o dataset
load('ex7data2.mat');

fprintf('Etapa de associação: encontrando os centróides mais próximos.\n\n');

% Definindo a localização inicial dos centróides
K = 3; 
initial_centroids = [3 3; 
                     6 2; 
                     8 5];

% Função que encontra os centróides mais próximos dos exemplos de treinamento baseada na posição inicial dos mesmos
idx = findClosestCentroids(X, initial_centroids);

fprintf('Os centróides mais próximos para os 3 primeiros exemplos de treinamento são: \n')
fprintf(' %d', idx(1:3));
fprintf('\n(a ordem retornada pela função deve ser: 1, 3, 2 respectivamente)\n');

fprintf('\nEtapa de movimentação do cluster: define as novas posições dos centróides.\n\n');

% Calcula a nova posição do centróide com base na média dos exemplos de treinamento
% que estão associados a ele 
centroids = computeCentroids(X, idx, K);

fprintf('Nova posição dos centróides:  \n')
fprintf(' %f %f \n' , centroids');
fprintf('\n As novas coordenadas dos centróides devem ser: \n');
fprintf('   [ 2.428301 3.157924 ]\n');
fprintf('   [ 5.813503 2.633656 ]\n');
fprintf('   [ 7.119387 3.616684 ]\n\n');


%% =================== Algoritmo K-Means ======================
%  Uma vez que você implementou as etapas de movimentação (computeCentroids) e 
%  associação (findClosestCentroids). Podemos executar o algoritmo k-means. 
%  Nessa fase, você irá executar o K-Means para o dataset ex7data2.mat. 

fprintf('\n Rodando o K-Means para o dataset. \n\n');

% Carregando o dataset
load('ex7data2.mat');

% Definindo os parâmetros iniciais
K = 3;
max_iters = 1;
initial_centroids = [3 3; 
                     6 2; 
                     8 5];

% O 'true' no último parâmetro da função indica que a execução do k-means
% deve ser apresentada a cada iteração
[centroids, idx] = runkMeans(X, initial_centroids, max_iters, true);
fprintf('\nK-Means executado.\n\n');

%% =============================================================================

%% Aplicar o K-Means na compressão de imagens 
fprintf('\n Rodando o K-Means nos pixels da imagem.\n\n');

% Cria uma matriz tridimensional A cujos os dois
% primeiros índices identificam a posição do pixel e o último índice 
% representa vermelho, verde ou azul. 
% Por exemplo, A (50, 33, 3) fornece a intensidade azul do pixel na linha 50 
%e na coluna 33.

B = imread('south_park.png');
%load('ex7data2.mat');

% Divide todos os valores por 255 para os mesmos obedeçam o intervalo [0-1]
A = B / 255; 

% Captura o tamanho da imagem
img_size = size(A);

% Dê um reshape na imagem para gerar uma matriz Nx3, onde N = número de pixels. 
% 3 -> valores do pixel no canal RGB e N=128x128 - 16384
% Isso nos dá a matriz de dataset X, na qual usaremos o K-Means.
X = reshape(A, img_size(1) * img_size(2), 3);

% Você deve testar diferentes valores de K e max_iters aqui 
K = 20; 
max_iters = 10;

% Aqui, foram definidos valores específicos para iniciar os centróides 
% você deve inicializá-los randomicamente através da função kMeansInitCentroids
initial_centroids = kMeansInitCentroids(X, K);

% Executa K-Means
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

%% Compressão da Imagem 
fprintf('\nAplicando K-Means para comprimir a imagem.\n\n');

% Depois de encontrar as K=16 cores (centroids) para representar a imagem
% Você utilizará a função findClosestCentroids.m para atribuir 
% cada posição do pixel ao seu centróide mais próximo. 
% Assim, a imagem X é representada em termos de idx 
idx = findClosestCentroids(X, centroids);

% É possivel recuperar a imagem comprimida através dos indices dos centróides
% mapeados no vetor idx
X_recovered = centroids(idx,:);

% Redimensiona a imagem recuperada 
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% Plota a figura original
subplot(1, 2, 1);
imagesc(B);
title('Original');

% Plota a figura comprimida
subplot(1, 2, 2);
imagesc(X_recovered)
title(sprintf('Comprimida pelo K-means, com %d cores.', K));

print -dpng 'Plot_depois_processo.png' -S1024,1024


