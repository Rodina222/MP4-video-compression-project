function [vector_all_image,encoded_image,dict]=JPEG_encoder_arth(Image,Q_type)

% initializations:
[image_rows, image_columns]= size(Image);
Block_size= 8;
image_block=[];
%DCT_block=[];
encoded_block=[];
encoded_image= [];
vector_all_image= [];
padded_rows= image_rows;
padded_columns= image_columns; 


if rem(image_rows,8) ~= 0
     padded_rows=image_rows + rem(image_rows,8);
end

% padding the image in case it is not divisible by 8:

if rem(image_columns,8) ~= 0
    padded_columns= image_columns + rem(image_columns,8);
end

padded_image= zeros(padded_rows, padded_columns); 
padded_image(1:image_rows,1:image_columns) = Image;
[padded_image_rows, padded_image_columns] = size(padded_image);


%lopping on the padded image

for row =1 : Block_size: padded_image_rows
    for column=1 :Block_size: padded_image_columns
  
       row_end= row+Block_size-1;         
       column_end= column+Block_size-1;
 
       image_block= Image(row:row_end,column:column_end);

      % DCT_block=Block8_DCT(double(image_block));  


       if Q_type == 1 
           quantized_low=double(image_block)./QuantizationTable(1); 
           from_2D_to_1D_low= zigzag_order(quantized_low);
           Rounded_1D_vector_low= round(from_2D_to_1D_low);
           vector_low=Run_length_encoder(Rounded_1D_vector_low);
           vector_all_image= [vector_all_image, vector_low] ; 

       elseif Q_type == 2
           quantized_high= double(image_block)./QuantizationTable(2); 
           from_2D_to_1D_high= zigzag_order(quantized_high);  
           Rounded_1D_vector_high= round(from_2D_to_1D_high); 
           vector_high=Run_length_encoder(Rounded_1D_vector_high);  
           vector_all_image= [vector_all_image,vector_high ];
        elseif Q_type == 0
           quantized_high= double(image_block)./QuantizationTable(0); 
           from_2D_to_1D_high= zigzag_order(quantized_high);  
           Rounded_1D_vector_high= round(from_2D_to_1D_high); 
           vector_high=Run_length_encoder(Rounded_1D_vector_high);  
           vector_all_image= [vector_all_image,vector_high ];

       else
           disp("Invalid number! you should only write 1 ( for low quantization) or 2 (for high quantization");
       end
   end
end
   
    [symbols, probabilities] = Probability_calculation(vector_all_image);
    dict= huffmandict(symbols,probabilities);
    encoded_image = huffmanenco(vector_all_image,dict);


end