% main.m

%% 
% Base Case: 3-by-3 Square
function main()

% Random Template Figure Setup
block_initial = zeros(32,32); block_random = 256.*ones(32,32); 
check = sort(randperm(9,3));
figure('Name','Template','NumberTitle','off'); 
    for k = 1:9
        subplot(3,3,k)
        if (k == check(1)) || (k == check(2)) || (k == check(3))
            image(block_random); axis off
        else
            imagesc(block_initial); axis off
            colormap bone;
        end
    end  

pause(2)
close(figure)

%Match Test Figure Setup (mouse interaction and appearance)
block_initial = zeros(32,32);
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
% you clicked, scaled up by 100, rounded to nearest integer. Figure puts
% (0,0) in the bottom left corner, (100,100) in the top right

%% Callback Function executes once a click happens
    function CallBackEx(hObject,~)
        mousePos = get(hObject,'CurrentPoint');
        mousePos_x = round(100*mousePos(1)); mousePos_y = round(100*mousePos(3));

%Determining current block of a mouse click
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