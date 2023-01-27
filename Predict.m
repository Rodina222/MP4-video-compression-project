function [motionVector ,difference]=Predict(ref_frame,curr_frame,block_size)
%********************* function Predict takes 3 inputs reference frame,
%current frame and block_size
%********************* it returns difference between macro bolck and best
%match for all images , also the motion vector
[mR ,nR]=size(ref_frame);
[mC,nC]=size(curr_frame);
% Checking on frames sizes
if (mR~=mC || nR~=nC)
    disp("Error in frames Dimensions");
    return;
end
% convert frmaes to double to maje operations on
ref_frame=im2double(ref_frame);
curr_frame=im2double(curr_frame);
x=rem(mC, block_size);
% Padding Step to make image dividible by 8 in both dimensions
upCurr_frame=zeros(mC+x,nC+x);
upCurr_frame(1:mC,1:nC)=curr_frame;
% some Intializations
[new_n,new_m]=size(upCurr_frame);
motionVector={{}};
numberOfBlocks_row=new_n/block_size;
numberOfBlocks_col=new_m/block_size;
searchAre_size=24;
%
difference=zeros(mR,nR);
% Searching Best Match
for n=0:numberOfBlocks_row-1  % iterate on each block
    for m=0:numberOfBlocks_col-1
        row=n*block_size+1;   % row index of block of first pixel
        col=m*block_size+1;   % col index of block of first pixel
        row_end=row+block_size-1;   % row index of block of last pixel
        col_end=col+block_size-1;   % col index of block of last pixel
        if(row+block_size-1 <=mC && col+block_size-1<=nC)
            macroBlock=upCurr_frame(row:row_end,col:col_end);
        end
        % checking conditions to define search Area beacuse it depends on
        % position of macro block
        if(row==1 && col==1)    % case of first macro block in current frame
            row_SA=row; 
            col_SA=col;

        elseif(row==1 && col_end==nR)   % case of macroblocks in first row and last column
            row_SA=row;
            col_SA=col_end-searchAre_size;

        elseif(col==1 && row_end==mR)   % case of macroblocks in first column and last row
            row_SA=row_end-searchAre_size;
            col_SA=col;

        elseif(row_end==mR && col_end==nR)  % case of block in last row and last column
            row_SA=row_end-searchAre_size;
            col_SA=col_end-searchAre_size;

        elseif(row==1 && col~=1)      % case of first row but not first column
            row_SA=row;
            col_SA=col-block_size;

        elseif(row~=1 && col==1)      % case of first column but not first row
            row_SA=row-block_size;
            col_SA=col;

        elseif(row_end==mR && col_end~=nR)    % case of last row but not last column
            row_SA=row_end-searchAre_size;
            col_SA=col-block_size;

        elseif(row_end~=mR && col_end==nR)   % case of last column but not last row
            row_SA=row-block_size;
            col_SA=col_end-searchAre_size;

        else         % General Case (in the middle of the frame)
            row_SA=row-block_size;
            col_SA=col-block_size;

        end
        row_SA_end=row_SA+searchAre_size-1;
        col_SA_end=col_SA+searchAre_size-1;
        searchAreaBlock=ref_frame(row_SA:row_SA_end,col_SA:col_SA_end);   % Adjusting indices of search area
        [x ,y ,diff]=searchArea(macroBlock,searchAreaBlock,row_SA,col_SA);

        motionVector{n+1}{m+1}=[x,y];
        difference(row:row_end,col:col_end)=diff;

    end
end
difference=rescale(difference,0,255); % rescaling difference from double to integers
difference=difference-111;
difference=uint8(difference);
end

