function shGtwPs(P)
% Show basis used for GTW.
% 
% Input
%   P       -  warping path vectors, t x m
%   varargin
%     show option
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 08-19-2010
%   modify  -  Feng Zhou (zhfe99@gmail.com), 07-05-2012

[mks, cls] = genMkCl;

rows = 1; cols = 1;
Ax = iniAx(2, rows, cols, [400 * rows, 400 * cols]);

shP(P, 'lnWid', 1, 'mkSiz', 0, 'cl', cls, 'G', eye(size(P, 2)), 'ax', Ax{1});

title('basis used for GTW');
