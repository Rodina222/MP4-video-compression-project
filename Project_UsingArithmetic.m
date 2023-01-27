clc;
clear all;
close all;
tic

video=VideoReader("input_video.mp4");    % reading the video
writerObj = VideoWriter('myVideo_arith.avi');  %initializing an object for writing the video after decoding
writerObj.FrameRate = video.FrameRate;
rows_len= 360;
col_len= 640;

frames= cell(video.NumFrames,1);    % converting the input frames of the video into a cell array 
Ref_Frame=read(video,1);            % reading the reference frame
Ref_Frame=rgb2gray(Ref_Frame);      % converting the frame to gray scale

Quantization_type= 1;   % low quantization
[vect,ref_image,dict]=JPEG_encoder_arth(Ref_Frame,Quantization_type);     % encoding the reference frame
predicted_ref = JPEG_decoder(ref_image,dict,rows_len,col_len,Quantization_type);  % decoding the reference frame
Ref_Frame= predicted_ref ;

images= cell(video.NumFrames,1);    % converting the decoded frames of the video into a cell array  
images{1}= predicted_ref;    % assigning the first element in the cell array by the reference frame
num_frames= 1;            % initializing the 1st frame -> it will be increased at the end of every iteration
total_length=0;
open(writerObj);

for i =2:video.NumFrames    % looping on the frames of the video starting from the 2nd frame
   
frames{i}=read(video,i);     % reading frame(i)
cuFrame=frames{i};          
cuFrame=rgb2gray(cuFrame);   % converting the frame to gray scale

% Motion estimation:

motionVector=Predict(Ref_Frame,cuFrame,8);    % estimating the current frame motion vector

% motion compensation:
cuFrame= double(cuFrame);
predicted_frame=Motion_compensation(Ref_Frame,motionVector);  % compensating the reference frame to represent the current frame
[len_rows,len_columns]= size(predicted_frame); 


%calculating the difference between the predicted and the current frames
difference= cuFrame - predicted_frame;
[encoded_diff, d,dicto]= JPEG_encoder_arth(difference,Quantization_type);


% converting the motion_vector into a list to be able to encode it using
% entropy encoding:
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

 
%Run_length_diff=Run_length_encoder(diff_zigzag);   %rulength encoder for the difference
Run_length_motion_vector=Run_length_encoder(motion_list); %rulength encoder for the motion list


frame_vector=[rows_len,col_len,encoded_diff,Run_length_motion_vector]; % concatenating the difference vector and the motion list together
[symbols_low, probabilities_low] = Probability_calculation(frame_vector);   
symbols_unique = length(unique(symbols_low));
seq = symbols_low;
% applying arthmetic encoding on the frame vector
encoded_image = arithEncod(probabilities_low, symbols_low,seq);


%/////////////////////////////////////////////////////////Decoding////////////////////////////////////////////////////////////////
before_runlength =my_Arithmetic_decoder(encoded_image,symbols_unique,probabilities_low,symbols_low);       % Arithmetic decoding
stream_integers =runlength_decoder(before_runlength);   

% separating the difference vector from the motion list:
decoded_diff=[];
stop_size1=stream_integers(1)*stream_integers(2)+2;

for k =3: stop_size1
decoded_diff= [decoded_diff stream_integers(k)];

end

stop_size2=(stream_integers(1)/8)*(stream_integers(2)/8)*2;
decoded_motionV=[];

for j =stop_size1+1:stop_size1+stop_size2
decoded_motionV= [decoded_motionV stream_integers(j)];
end
motion_vec=list2cellA(decoded_motionV,45,80);


recovered_diff= vec2image(decoded_diff,rows_len,col_len,true,Quantization_type);

predicted_frame=Motion_compensation(predicted_ref,motion_vec);
predicted_frame= uint8(predicted_frame);

decoded_frame= predicted_frame+ recovered_diff; 
Ref_Frame= decoded_frame;
predicted_ref= decoded_frame;
images{i}= decoded_frame;

outputFrame = imresize(images{i}, [rows_len, col_len]);
 writeVideo(writerObj, outputFrame);



num_frames= num_frames+1;
total_length=total_length+length(encoded_image);

end

 close(writerObj);

total_length=total_length+length(ref_image);
Comp_ratio =compression_ratio(rows_len,col_len,num_frames,total_length);


title("Image with high compression", 'FontSize', 14);
disp("Compression Ratio = " +Comp_ratio);



 % close the writer object


toc
