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
        if (mod(jj,33) == 1)
            background(:,jj) = 256; 
        end
        if (mod(ii,33) == 1)
            background(ii,:) = 256;
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
colorbar
axis image; axis off

%Testing change in color block
figure(2)
new_color = 150*ones((100-(3+1))/3);
displayed = display;
displayed(end-32:end-1, end-32:end-1) = new_color;
imagesc(displayed)
axis image; axis off
%Creating the 9 Squares
    block1 = display(2:33,2:33);
    block2 = display(2:33,(2:33)+33);
    block3 = display(2:33,end-32:end-1);
    block4 = display((2:33)+33,2:33);
    block5 = display((2:33)+33,(2:33)+33);
    block6 = display((2:33)+33, end-32:end-1);
    block7 = display(end-32:end-1,2:33);
    block8 = display(end-32:end-1,(2:33)+33);
    block9 = displayed(end-32:end-1,end-32:end-1);
    parts = zeros(32,32,3,3);
    parts(:,:,1,1) = block1;
    parts(:,:,1,2) = block2;
    parts(:,:,1,3) = block3;
    parts(:,:,2,1) = block4;
    parts(:,:,2,2) = block5;
    parts(:,:,2,3) = block6;
    parts(:,:,3,1) = block7;
    parts(:,:,3,2) = block8;
    parts(:,:,3,3) = block9;
%%Showing each square on a subplot
    figure(3)
    k = 1;
    for ii = 1:3
        for jj = 1:3
        subplot(3,3,k)
        imagesc(parts(:,:,ii,jj))
        k = k+1;
        end
    end
        
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