function centroids = computeCentroids_deb(X, idx, K)
% Retorna os novos centróides calculados a partir do ponto médio de todas as
% amostras atribuídas a cada centróide.
%   X -> dataset
%   idx -> vetor com os centróides associados a amostras [1..K]
%   K -> número de centróides

[m n] = size(X);

% Inicializando a matrix com as posições dos centróides
centroids = zeros(K, n);

% ====================== Implemente seu código aqui ======================
% Cada linha do vetor de "centroids" corresponde a um centróide
% e cada coluna corresponde as coordenadas (x,y) respectivamente


%for k = 1:K
%  num_k = 0;
%  sum = zeros(n, 1);
%  sum = 0;
%  for i = 1:m
%    if ( idx(i) == k )
%      sum = sum + X(i, :)';
%      num_k = num_k + 1;
%    end
%  end
%  centroids(k, :) = (sum/num_k)';
%end


for i = 1:K
   centroids(i, :) = mean(X(idx == i, :), 1);
end


% =============================================================

end

