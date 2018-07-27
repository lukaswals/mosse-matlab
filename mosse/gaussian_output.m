function val = gaussian_output(x, y, sigma, center)
% ------------------------------------------------------------------------------
%GAUSSIAN_OUTPUT
%   Generates a training output with gaussian shape
%   PARAMETER EXPLANATION COMING SOON
%
%   Lucas Wals
% ------------------------------------------------------------------------------
    xc = center(1);
    yc = center(2);
    exponent = ((x-xc).^2 + (y-yc).^2)./(2*sigma);
    val = (exp(-exponent)); 
end