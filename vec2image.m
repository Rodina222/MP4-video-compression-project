function total_image=vec2image(total_vector,row_size,col_size,idct,quantization_table)
%************** This Function convert a vector of 1d to image by reverse
%zigzag function also it perorms idct if = True if idct= flase , it
%performs only reverse zigzag 
%****************** inputs: Total 1d vector , desired dimension of image
%row_size , col_size 
% idct boolean and quantization table for IDCT
if(idct==true)
    if nargin~=5
        disp("Error in function vec2image");
        return;
    end
end
if (length(total_vector)~=row_size*col_size)
    disp("Error in sizes of total vector");
    return
end
%intializations
total_image=zeros(row_size,col_size);
block_size=8;
index=0;
vec_size=64;

for i=0:row_size/block_size-1
    for j=0:col_size/block_size-1
        total_image(i*block_size+1:(i+1)*block_size,j*block_size+1:(j+1)*block_size)=reverse_zigzag(total_vector(index*vec_size+1:(1+index)*vec_size)); % applying reverse zigzag
        if(idct==true) % performing idct and multiplying by quantization table
            total_image(i*block_size+1:(i+1)*block_size,j*block_size+1:(j+1)*block_size)=total_image(i*block_size+1:(i+1)*block_size,j*block_size+1:(j+1)*block_size).*quantization_table;
            total_image(i*block_size+1:(i+1)*block_size,j*block_size+1:(j+1)*block_size)=Block8_IDCT(total_image(i*block_size+1:(i+1)*block_size,j*block_size+1:(j+1)*block_size));
        end
        index=index+1;
    end
end
total_image=uint8(total_image);

end