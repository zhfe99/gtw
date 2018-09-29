function h = shHstBar(Hst, varargin)
% Plot histogram in 2-D.
%
% Input
%   Hst       -  histogram, k x n
%                k: #bar in x-axis
%                n: #repetition for each bar
%   varargin
%     show option
%     barWid  -  width of histogram bar, {.8} <= 1
%     devWid  -  width of deviation line in terms of the 'barWid', {1} <= 1
%     bdWid   -  width of boundary of bar, {1}
%     lnWid   -  width of deviation line, {2}
%     dev     -  dev flag, {'y'} | 'n'
%     val     -  value flag, 'y' | {'n'}
%     form    -  value form, {'%d'}
%     yLim    -  threshold in y axis, {[]}
%     leg     -  legend, {[]}
%
% Hstory
%   create    -  Feng Zhou (zhfe99@gmail.com), 03-03-2009
%   modify    -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% show option
psSh(varargin);

% function option
barWid = ps(varargin, 'barWid', .8); barWid2 = barWid / 2;
devWid = ps(varargin, 'devWid', 1);  devWid2 = devWid / 2;
bdWid = ps(varargin, 'bdWid', 1);
lnWid = ps(varargin, 'lnWid', 2);
isDev = psY(varargin, 'dev', 'y');
isVal = psY(varargin, 'val', 'n');
form = ps(varargin, 'form', '%d');
yLim = ps(varargin, 'yLim', []);
leg = ps(varargin, 'leg', []);

hold on;

% class
[markers, colors] = genMkCl;
k = size(Hst, 1);
xs = 1 : k;

% mean
mes = mean(Hst, 2);
for c = 1 : k
    x = xs(c);
    y = mes(c);    
    xL = x - barWid2;
    xR = x + barWid2;

    cl = colors{1 + mod(c - 1, length(colors))};

    if bdWid == 0
        fill([xL xR xR xL], [0 0 y y], cl, 'EdgeColor', cl);
    else
        fill([xL xR xR xL], [0 0 y y], cl, 'LineWidth', bdWid);
    end
end
may = max(mes);

% legend
if ~isempty(leg)
    h.leg = legend(leg{:}, 'orientation', 'vertical');
end

% standard deviation
if isDev
    devs = std(Hst, 0, 2);
    for c = 1 : k
        x = xs(c);
        y = mes(c);
        dev = devs(c);
        
        xL = x - barWid2 * devWid2;
        xR = x + barWid2 * devWid2;

        cl = colors{1 + mod(c - 1, length(colors))};
        
        % vertical line
        line([x x], [0 dev] + y, 'Color', cl, 'LineWidth', lnWid);
        
        % horizontal line
        line([xL xR], [dev dev] + y, 'Color', cl, 'LineWidth', lnWid); 
    end
    may = may + max(devs);
end

% value
if isVal
    [val, vals] = vec2str(mes, form);
    for c = 1 : k
        text('Position', [xs(c), mes(c) + may * .1], 'String', vals{c}, ...
            'HorizontalAlignment', 'center');
    end
end

% boundary
xlim([xs(1) - 1, xs(end) + 1]);
if isempty(yLim)
    mi = 0;
    ma = may * 1.1;
else
    mi = yLim(1); ma = yLim(2);
end
if abs(mi - ma) > eps
    ylim([mi, ma]);
end
