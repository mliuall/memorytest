% main.m

% imagesc(one_op_art(50,2))
% axis image; axis off;
%% 
% Base Case: 3-by-3 Square
function main()
height = 100;
background = zeros(height);
for ii = 1:floor(height)
    for jj = 1:floor(height)
        if (mod(jj,30) == 1) || (mod(jj,30) == 2) || (mod(jj,30) == 3)
            background(:,jj) = 1; 
        end
        if (mod(ii,30) == 1) || (mod(ii,30) == 2) || (mod(ii,30) == 3)
            background(ii,:) = 1;
            % Need to keep height always 100 because I couldn't find a way
            % to make the mouse interaction work not on a 0 to 100 scale.
            % Need to adjust the squares so that they fit evenly. 3 is uneven. 
        end
    end
end
display = background;

%Image display and Setup of the interactive figure. Find a way to get 
% rid of the axes. 
figure(1)
image = imagesc(display);
set(image,'HitTest','off')
axis([0 100 0 100]);
ax = axes;
set(ax,'ButtonDownFcn',@CallBackEx,'PickableParts','all')
colormap bone;  axis off; colorbar
mousePos_x = []; mousePos_y = []; %Initialization
% Mouse interaction: gives you the x value and y-values of the point where 
% you clicked, scaled up by 100. 
    function CallBackEx(hObject,~)
        mousePos = get(hObject,'CurrentPoint');
        mousePos_x = 100*mousePos(1); mousePos_y = 100*mousePos(3);
    end

%Changing square colors
if display(round(mousePos_x),round(mousePos_y)) == 0
    %Need block positions to define each separate block


end
end