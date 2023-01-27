function   motion_list= vec2list(motionVector)  % converting the motion_vector into a list to be able to encode it:

[l_motion_vector,w_motion_vector]= size(motionVector);
motion_list= [];
counter2= 0;
counter1= 0;
[l,cell_array_size]= size(motionVector{1,1});

for i=1:w_motion_vector
    counter1= counter1+1;

    for j =1:cell_array_size
        counter2=counter2+1;

     motion_list= [motion_list motionVector{1,counter1}{1,counter2}];

    end
    counter2=0;
end

end