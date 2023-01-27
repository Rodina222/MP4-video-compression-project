function image = JPEG_decoder(stream_bits,dict,row,col,Quantization_type)
%********** This functions takes stream of bits the represent an image and
% desired dimension of image roe, col also Quatization Type that was
% previously used in Encoder, dictionary of codeword used in encoder
%********** it returns an image with dimension row*col


before_runlength=huffmanDecoder(stream_bits,dict); % huffman deconding 
total_integers =runlength_decoder(before_runlength);  

if (Quantization_type==1)
image=vec2image(total_integers,row,col,true,QuantizationTable(1));
elseif (Quantization_type==2)
image=vec2image(total_integers,row,col,true,QuantizationTable(2));
elseif (Quantization_type==0)
image=vec2image(total_integers,row,col,true,QuantizationTable(0));
end

image=uint8(image);

end