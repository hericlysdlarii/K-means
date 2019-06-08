function centroids = kMeansInitCentroids(X, K)
% Essa função escolhe aleatoriamente K exemplos do conjunto de dados
% para inicializar os K centróides 

% Inicializando a matrix de centróides
centroids = zeros(K, size(X, 2));

% ====================== Implemente seu código aqui ======================
% Você deve escolher randomicamente exemplos do dataset X 

rand = randperm(size(X, 1));
centroids = X(rand(1:K), :);
% =============================================================

end

