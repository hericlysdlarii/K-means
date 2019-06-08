function [centroids, idx] = runkMeans(X, initial_centroids, max_iters, plot_progress)
% essa função é responsável por executar o algoritmo K-means
%   X -> dataset
%   initial_centroids -> coordenadas da posição inicial dos centróides  
%   max_iters -> especifica o número máximo de iterações  
%   plot_progress -> flag booleana (true/false) que indica se o progresso do 
%   algoritmo deve ser plotado 
%  
%   runkMeans retorna: 
%   centroids -> matriz com a posição final dos centróides
%   idx -> vetor (m x 1) contendo a associação entre as amostras e os seus centróides 


% Define "false" como valor padrão, caso o parâmetro que plota o progresso do 
% algoritmo não seja definido
if ~exist('plot_progress', 'var') || isempty(plot_progress)
    plot_progress = false;
end

% Plota o progresso, se essa opçãp for True
if plot_progress
    figure;
    hold on;
end

% Inicializando os parâmetros de entrada do algoritmo
[m n] = size(X);
K = size(initial_centroids, 1);
centroids = initial_centroids;
previous_centroids = centroids;
idx = zeros(m, 1);

% Loop iterativo
for i=1:max_iters
    
    % Progresso da saída
    fprintf('Iteração %d/%d...\n', i, max_iters);
    if exist('OCTAVE_VERSION')
        fflush(stdout);
    end
    
    % Etapa de associação: para cada amostra de X, associar o cluster mais próximo
    idx = findClosestCentroids(X, centroids);
    
    % Plota o progresso da aprendizagem (opcional) 
    if plot_progress
        plotProgresskMeans(X, centroids, previous_centroids, idx, K, i);
        previous_centroids = centroids;
        fprintf('Pausa para mostrar cada iteração.\n');
        pause;
    end
    
    % Etapa de movimentação do centróide: calcula o novo centróide
    centroids = computeCentroids(X, idx, K);
end

% comando de Hold off, caso o progresso do algoritmo esteja sendo plotado
if plot_progress
    hold off;
end

end

