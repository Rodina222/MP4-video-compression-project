function predicted_frame=Motion_compensation(ref_Frame,motionVector)

[length,width]= size(ref_Frame);
[l_motion_vector,w_motion_vector]= size(motionVector);
predicted_frame= zeros(length,width);
Block_size=8;
counter1=0;
counter2=0;
[l,cell_array_size]= size(motionVector{1,1});
counter1_size= w_motion_vector;
counter2_size= cell_array_size;

for row =1 : Block_size: length
    counter1= counter1+1;

    for column=1 :Block_size: width
        counter2=counter2+1;

        row_end= row+Block_size-1;
        column_end= column+Block_size-1;

        if counter2 <= counter2_size && counter1<= counter1_size

            shift = motionVector{1,counter1}{1,counter2}; % extracting the x and y shift of the current block

            x_index= shift(1);
            y_index= shift(2);

            if x_index+7 <=length && y_index+7<=width
            ref_block=ref_Frame(x_index:x_index+7,y_index:y_index+7);
            predicted_frame(row:row_end,column:column_end)= ref_block;
            else
            ref_block=ref_Frame(row:row_end,column:column_end);
            predicted_frame(row:row_end,column:column_end)= ref_block;
            end

        end
    end
    counter2=0;
end
end
