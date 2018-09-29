% A demo file for comparing temporal alignment algorithm on the toy data set.
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 06-04-2012
%   modify  -  Feng Zhou (zhfe99@gmail.com), 07-05-2012

clear variables;
prSet(1);
tag = 3; l = 300; m = 3;

%% parameter
inp = 'linear'; qp = 'matlab'; dp = 'c';
parGtw = st('nItMa', 50, 'th', 0);
parDtw = st('nItMa', 50, 'th', 0, 'inp', inp);
parPimw = st('nItMa', 50, 'th', 0, 'lA', 1, 'lB', 1);
parCca = st('d', 2, 'lams', 0);
parFtw = st('nItMa', 2, 'th', 0, 'lam', 0, 'nor', 'n', 'qp', qp, 'inp', inp);

%% src
wsSrc = toyAliSrc(tag, l, m, 'svL', 1);
[Xs, aliT] = stFld(wsSrc, 'Xs', 'aliT');

%% basis
ns = cellDim(Xs, 2);
bas = baTems(l, ns, 'pol', [3 .4], 'tan', [3 .6 1]);

%% utw (initialization)
aliUtw = utw(Xs, bas, aliT);

%% pdtw
aliPdtw = pdtw(Xs, aliUtw, aliT, parDtw);

%% pddtw
aliPddtw = pddtw(Xs, aliUtw, aliT, parDtw);

%% pimw
aliPimw = pimw(Xs, aliUtw, aliT, parPimw, parDtw);

%% gtw
aliGtw = gtw(Xs, bas, aliUtw, aliT, parGtw, parCca, parFtw);

%% show result
shAliCmp(Xs, Xs, {aliPdtw, aliPddtw, aliPimw, aliGtw}, aliT, parCca, parDtw);

%% show basis
shGtwPs(bas{1}.P);

