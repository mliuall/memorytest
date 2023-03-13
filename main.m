% main.m
% written on May 29, 1997
% by Jeff Buckley
% This script does not do much. It simply prints ‘hello world’

imagesc(one_op_art(50,2))
axis image; axis off;
%% 
% Base Case: 3-by-3 Square
height = 58;
background = zeros(height);
for ii = 1:height
    for jj = 1:height
        if (mod(jj,19) == 1)
            background(:,jj) = 256; 
        end
        if (mod(ii,19) == 1)
            background(ii,:) = 256;
        end
    end
end
new_color = ones(19);
new_color = 150;
displayed = background;
displayed(end-18:end-1, end-18:end-1) = new_color;
imagesc(displayed)
colorbar
axis image; 
axis off;
%% 
% Decreasing Squares Code
function [ decreasing_squares ] = one_op_art( height,height_difference )
colormap gray
decreasing_squares = zeros(height);
choose_number = false;
start = 1;
new_end = height;
while (height > 2 * height_difference)
    start = start + height_difference;
    choose_number = ~choose_number;
    height = height - 2*height_difference;
    new_end = new_end - height_difference;
    
    if (choose_number)
        decreasing_squares(start:new_end,start:new_end) = ones(height);
    else
        decreasing_squares(start:new_end,start:new_end) = zeros(height);
    end
    
end
axis image
axis off
end