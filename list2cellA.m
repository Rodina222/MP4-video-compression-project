function motion_vec=list2cellA(vector1d,row,col)
%********** This function returns a list to motion vector of type cell
%array with dimension row* col
%************ it retuns motion vector

if (row*col*2~=length(vector1d))
    disp("Error in sizes in function list2cellA");
    return;
end

motion_vec={{}};
index=1;
for i=1:row
    for j=1:col
        % Put each two numbers in vector1d in a list and assign the list to the
        % motion vector
        l=[vector1d(index),vector1d(index+1)];
        motion_vec{i}{j}=l;
        l=[];  % empties list 
        index=index+2;
    end
end


end