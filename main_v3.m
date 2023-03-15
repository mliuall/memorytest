% main.m

%% 
% Base Case: 3-by-3 Square
function main()
block_initial = zeros(32,32); %Initialization

%Figure Setup (mouse interaction and appearance)
figure('Name','Visual Memory','NumberTitle','off'); 
    k = 1;
    for ii = 1:3
        for jj = 1:3
        subplot(3,3,k)
        img = imagesc(block_initial);
        set(img,'HitTest','off'); axis off;
        k = k+1;
        end
    end   
ax = axes;
set(ax,'ButtonDownFcn',@CallBackEx,'PickableParts','all')
colormap bone;  axis off; 
mousePos_x = []; mousePos_y = []; current_block = []; %Initialization

% Mouse interaction: gives you the x value and y-values of the point where 
% you clicked, scaled up by 100, rounded to nearest integer.

%% Callback Function executes once a click happens
    function CallBackEx(hObject,~)
        mousePos = get(hObject,'CurrentPoint'); disp(mousePos)
        mousePos_x = round(100*mousePos(1)); mousePos_y = round(100*mousePos(3));
        disp(mousePos_x); disp(mousePos_y)


%Determining current block of a mouse click; There's a little bit of leeway
% in the dimensions
if (mousePos_x < 33)
    if (mousePos_y < 33)
        current_block = 7;
    elseif (mousePos_y < 66)
        current_block = 4;
    else
        current_block = 1;
    end
elseif (mousePos_x < 66)
    if (mousePos_y < 33)
        current_block = 8;
    elseif (mousePos_y < 66)
        current_block = 5;
    else
        current_block = 2;
    end
else
    if (mousePos_y < 33)
        current_block = 9;
    elseif (mousePos_y < 66)
        current_block = 6;
    else
        current_block = 3;
    end
end
disp(current_block);


% Changing square color.
for kk = 1:9
    if current_block == kk
        block_new = 256.*ones(32,32); 
        subplot(3,3,kk)
            im1 = image(block_new);
            set(im1,'HitTest','off'); axis off
            set(axes,'ButtonDownFcn',@CallBackEx,'PickableParts','all');
            axis off;
    end
end

end % of callback function



end % of main function