function idx = findClosestCentroids(X, centroids)
% essa função associa o centróide mais próximo a cada exemplo de treinamento e 
% guarda o valor associado no vetor idx. Portanto, se temos m exemplos de 
% treinamento, o vetor deve possuir a dimensão idx = m x 1 
%

% Definindo o valor de K
K = zeros(size(centroids));

% inicializando idx
idx = zeros(size(X,1), 1);

% ====================== Implemente seu código aqui ======================
% idx(i) deve conter o índice do centróide mais próximo do exemplo i. 
% Portanto, deve ser um valor dentro do intervalo de 1 a K

for i = 1:size(X,1)   
  [a idx(i)] = min(sum(((X(i,:) - centroids).*(X(i,:) - centroids)),2)); 
end 
  

% =============================================================

end

