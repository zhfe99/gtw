function shAliCmp(Xs, X0s, alis, aliT, parCca, parDtw)
% Show alignments.
% 
% Input
%   Xs      -  used by GTW
%   X0s     -  used by other method
%   alis
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 08-19-2010
%   modify  -  Feng Zhou (zhfe99@gmail.com), 07-04-2012

% parameter
parPca = st('d', 3, 'homo', 'y');
parPca0 = st('d', 3, 'homo', 'n');
parMk = st('mkSiz', 1, 'lnWid', 1, 'ln', '-');
parChan = st('nms', {'x', 'y', 'z'}, 'gapWid', 1, 'all', 'y');
parAx = st('mar', .1, 'ang', [30 80], 'tick', 'n');

m = length(alis);
rows = 2; cols = m + 2;
axs = iniAx(1, rows, cols, [250 * rows, 250 * cols]);

% ori
XX0s = pcas(X0s, parPca0);
shs(XX0s, parMk, parAx, 'ax', axs{1, 1}); 
title(['original sequence']);
xlabel('x'); ylabel('y'); zlabel('z');
shChans(XX0s, parMk, parChan, 'ax', axs{2, 1});
% legend('binary', 'Euclidean', 'Poisson');
% legend('Rotation', 'Euclidean', 'G-Force');

algs = cellFld(alis, 'cell', 'alg');
for i = 1 : m
    col = i + 1;
    ali = alis{i};
    alg = algs{i};

    % truth
    if strcmp(alg, 'truth')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % uni
    elseif strcmp(alg, 'utw')
        shs(XX0s, parMk, parAx, 'ax', axs{1, col}); title(alg);
        set(gca, 'xlabel', 'x', 'ylabel', 'y', 'zlabel', 'z');
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});
        
    % dtw    
    elseif strcmp(alg, 'dtw')
        shs(XX0s, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % ddtw
    elseif strcmp(alg, 'ddtw')
        YYs = pcas(ali.Ys, parPca0);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % pdtw
    elseif strcmp(alg, 'pdtw')
        shs(XX0s, parMk, parAx, 'ax', axs{1, col}); title(alg);
        xlabel('x'); ylabel('y'); zlabel('z');
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % pddtw
    elseif strcmp(alg, 'pddtw')
        YYs = pcas(ali.Ys, parPca0);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        xlabel('x'); ylabel('y'); zlabel('z');
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});
        
    % pimw
    elseif strcmp(alg, 'pimw')
        Ys = pimwTra(X0s, ali);
        YYs = pcas(Ys, parPca0);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        xlabel('x'); ylabel('y'); zlabel('z');
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % ctw
    elseif strcmp(alg, 'ctw')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % hctw
    elseif strcmp(alg, 'hctw')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % ftw    
    elseif strcmp(alg, 'ftw')
        shs(XX0s, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});

    % hftw
    elseif strcmp(alg, 'hftw')
        shs(XX0s, parMk, parAx, 'ax', axs{1, col}); title(alg);
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});
    
    % gtw
    elseif strcmp(alg, 'gtw')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', axs{1, col}); title(alg);
        xlabel('x'); ylabel('y');
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', axs{2, col});
%         h = legend('distance transform', '3-d joint', 'shape context');
%         set(h, 'Orientation', 'horizontal');

    else
        error('unknown algorithm: %s', alg);
    end
end

% all
if ~isempty(aliT)
    alis = cellCat({aliT}, alis);
end
algs = cellFld(alis, 'cell', 'alg');
shAlis(alis, 'ax', axs{1, m + 2}, 'legs', algs, 'ang', [-55, 60]);
grid on;
title('time warping paths');

difs = cellFld(alis, 'double', 'dif');
shHstBar(difs', 'ax', axs{2, m + 2}, 'leg', algs);
title('error of alignment');
