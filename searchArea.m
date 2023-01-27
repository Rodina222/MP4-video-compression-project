function [x ,y , diff]=searchArea(macroBlock,Area,row_SA,col_SA)
[r, c]=size(macroBlock);
if( r~=c && r~=8)
    disp("Error")
    return
end
[rA ,cA]=size(Area);
if(rA~=cA && rA~=24)
    disp("Error")
    return
end
block_size=8;
min=inf;
% loop over search area to find best match
for i=0:rA-1 % loop over rows
    for j=0:cA-1 % loop over columns

        if(i+block_size<=rA && j+block_size<=cA)
            match=Area(i+1:i+block_size,j+1:j+block_size);
            error=immse(match,macroBlock);
            if(error<min)
                min=error;
                x= row_SA+i+1; % new row index of macro block 
                y=col_SA+j+1;  % new col index of macro block 
                diff=macroBlock-match;    % difference matric between macro block and best match
            end
        end
    end

end