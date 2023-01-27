function Comp_ratio =compression_ratio(rows_l,columns_l,num_frames,total_length)
%********** Takes dimensions of image ,rows_lenght and Columns lenght and
%number of frames in video and the totallength if encoded symbols
% ********* It returns the compression ratio

Comp_ratio=(rows_l*columns_l*num_frames*8)/total_length;


end