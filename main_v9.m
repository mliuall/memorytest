% main.m
%$ Authors: Matthew Liu & Tommy Wang

%% Main Call Function
function main()
score = 0;
x = 3; y = 3; % Starts with a 3 x 3 grid with 3 blocks to click.
setup(x,y)
    %% Setup Function to Make the Template & The Test Figure
    function setup(numberofblocks,dimensions)
        % Random Template Figure Setup
        
        %Variable Initiation
        block_initial = zeros(floor(100/dimensions)-1); block_random = 256.*ones(floor(100/x)-1);
        randstring = sort(randperm((dimensions)^2,numberofblocks)); check = zeros(1,(dimensions^2));
        match_template = randstring';
        
        % Sets up a vector in which the number of the blocks to be changed
        % to white are placed in the same position as their index. E.g. 2
        % will be in check(2).
        for vv = 1:numberofblocks
            check(randstring(vv)) = randstring(vv);
        end

        %Creates the Template that the User Needs to Memorize, Shows for 2
        %Seconds, and then Disappears
        figure('Name','Template','NumberTitle','off','MenuBar','none');
        for k = 1:(dimensions)^2
            subplot(dimensions,dimensions,k)
            if k == check(k)
                image(block_random); axis off
            else
                imagesc(block_initial); axis off
                colormap bone;
            end
        end
        pause(2)
        close 'Template'

        %Match Test Figure Setup (mouse interaction and appearance)
        block_initial = zeros(floor(100/dimensions)-1);
        figure('Name','Visual Memory','NumberTitle','off','MenuBar','none');
        for k = 1:(dimensions)^2
            subplot(dimensions,dimensions,k)
            img = imagesc(block_initial);
            set(img,'HitTest','off'); axis off
        end
        ax = axes;
        set(ax,'ButtonDownFcn',@CallBackEx,'PickableParts','all')
        colormap bone;  axis off;
        mousePos_x = []; mousePos_y = []; current_block = []; %Initialization
        match = zeros(numberofblocks,1); wrong = []; match_index = 1;

        % Mouse interaction: gives you the x value and y-values of the point where
        % you clicked, scaled up by 100, rounded to nearest integer. Figure puts
        % (0,0) in the bottom left corner, (100,100) in the top right

        %% Callback Function executes once a click happens
        function CallBackEx(hObject,~)
            mousePos = get(hObject,'CurrentPoint');
            mousePos_x = round(100*mousePos(1)); mousePos_y = round(100*mousePos(3));

            %Determines current block of a mouse click
            current_block = blocknumber(mousePos_x,mousePos_y,dimensions);

            % Changing square color. White is a correct square, black is a wrong
            % square. Sets up two vectors one which records all the
            % current_block value of the right squares clicked and another of the wrong
            % blocks clicked. match and wrong respectively.
            block_correct = 256.*ones(floor(100/dimensions)-1);
            block_wrong = zeros(floor(100/dimensions)-1);
            % Changes the right blocks clicked to white
            if current_block == check(current_block)
                for kk = 1:(dimensions)^2
                    if current_block == kk
                        subplot(dimensions,dimensions,kk)
                        im1 = image(block_correct);
                        set(im1,'HitTest','off'); axis off
                        set(axes,'ButtonDownFcn',@CallBackEx,'PickableParts','all'); axis off;
                        match(match_index) = kk;
                        match_index = match_index + 1;
                    end
                end
            else
                % Changes the wrong blocks clicked to black
                for zz = 1:(dimensions^2)
                    if current_block == zz
                        subplot(dimensions,dimensions,zz)
                        im2 = image(block_wrong);
                        set(im2,'HitTest','off'); axis off
                        set(axes,'ButtonDownFcn',@CallBackEx,'PickableParts','all'); axis off;
                        wrong = [wrong; zz]; %#ok<AGROW>
                    end
                end
            end

            % Checking a match and determining a failure.
            % Makes it so y is incremented based on the size of the board.
            % A 3 x 3 will stay for 2 iterations. A 4 x 4 will stay for 3,
            % etc... and will cap at a 7 x 7 board at which point it gets
            % laggy so not much point in continuing past.
            if dimensions == 3
                y_increment = 0.5;
            elseif dimensions == 4
                y_increment = (1/3);
            elseif dimensions == 5
                y_increment = 0.25;
            elseif dimensions == 6
                y_increment = 0.2;
            else
                y_increment = (0);
            end

            if length(wrong) > 2
                % If three mistakes are made, the figure will close and
                % display the score.
                close 'Visual Memory'
                score_figure = score_display(score);
                figure('Name','','NumberTitle','off')
                imagesc(score_figure); colormap gray; axis off
            elseif match_template == sort(match)
                close 'Visual Memory' %% need to set up a way to go to the next stage
                score = score + 1; disp(score)
                x = x + 1; y = y + y_increment;
                % If executed correctly, it will run again with the setup 
                % function. X and y are changed during the process.
                setup(x,floor(y))
            end
        end % of callback function
    end % of setup function
end % of main function

%% Function to Determine Which Current Block is Clicked
function current_block = blocknumber(mousePos_x,mousePos_y,dimensions)
for ii = 1:dimensions
    if (mousePos_x < ii*floor(100/dimensions))
        for jj = 1:dimensions
            if (mousePos_y < jj*floor(100/dimensions))
                current_block = ii+dimensions*(dimensions-jj);
                break;
            end
        end
        break;
    else
        continue
    end
end
end
