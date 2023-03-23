% main.m

%%
%
function main()
score = 0;
setGlobalx(3); %Change number to get different output
setup(getGlobalx)
end % of main function

function setGlobalx(val)
global x
x = val;
end

function r = getGlobalx
global x
r = x;
end

function setCheck
r = getGlobalx;
global check
check = sort(randperm(r^2,r));
check = check';
end

function r = getCheck
global check
r = check;
end

function setup(x)
% Random Template Figure Setup
block_initial = zeros(floor(100/x)-1);
block_random = 256.*ones(floor(100/x)-1);
setCheck;
check = getCheck;
figure('Name','Template','NumberTitle','off');
for k = 1:x^2
    subplot(x,x,k)
    selected = false;
    for m = 1:x
        if (k == check(m))
            selected = true;
        end
    end
    if(selected)
        image(block_random); axis off
    else
        imagesc(block_initial); axis off
        colormap bone;
    end
end
pause(2)
close 'Template'

%Match Test Figure Setup (mouse interaction and appearance
figure('Name',convertCharsToStrings(strcat('Level', {' '}, num2str(x))),'NumberTitle','off');
for k = 1:x^2
    subplot(x,x,k)
    set(gca,'tag', num2str(k))
    img = imagesc(block_initial);
    set(img,'HitTest','off'); axis off;
    k = k+1;
end
ax = axes;
set(ax,'ButtonDownFcn',@CallBackEx,'PickableParts','all')
colormap bone;  axis off;

% Mouse interaction: gives you the x value and y-values of the point where
% you clicked, scaled up by 100, rounded to nearest integer. Figure puts
% (0,0) in the bottom left corner, (100,100) in the top right


end % of setup function

%% Callback Function executes once a click happens
function CallBackEx(hObject,~)

n = getGlobalx;
mousePos_x = []; mousePos_y = []; current_block = []; %Initialization
match = zeros(n,1); wrong = []; match_index = 1;

mousePos = get(hObject,'CurrentPoint');
mousePos_x = round(100*mousePos(1)); mousePos_y = round(100*mousePos(3));
%Determining current block of a mouse click
for ii = 1:n
    if (mousePos_x < ii*floor(100/n))
        for jj = 1:n
            if (mousePos_y < jj*floor(100/n))
                current_block = ii+n*(n-jj);
                break;
            end
        end
        break;
    else
        continue
    end
end

% Changing square color. White is a correct square, black is a wrong
% square. Sets up two spanning column vectors one which records all the
% current_block value of the right squares clicked and another of the wrong
% blocks clicked. match and wrong respectively.
block_correct = 256.*ones(floor(100/n)-1);
block_wrong = zeros(floor(100/n)-1);
check = getCheck;
selected = false;
for m = 1:n
    if (current_block == check(m))
        selected = true;
        break;
    end
end
if(selected)
    for kk = 1:n^2
        if current_block == kk
            subplot(n,n,kk)
            im1 = image(block_correct);
            set(im1,'HitTest','off'); axis off
            set(axes,'ButtonDownFcn',@CallBackEx,'PickableParts','all'); axis off;
            match(match_index) = kk;
            match_index = match_index + 1;
        end
    end    
else
    for zz = 1:n^2
        if current_block == zz
            subplot(n,n,zz)
            im2 = image(block_wrong);
            set(im2,'HitTest','off'); axis off
            set(axes,'ButtonDownFcn',@CallBackEx,'PickableParts','all'); axis off;
            wrong = [wrong; zz]; %#ok<AGROW>
        end
    end
end
    % Checking a match and determining a failure.
    if length(wrong) > 2
        close 'Visual Memory' % Need to set up a way to display a score
    elseif check == sort(match)
        close 'Visual Memory' %% need to set up a way to go to the next stage
        score = score + 1; disp(score)
        setup();
    end
end % of callback function