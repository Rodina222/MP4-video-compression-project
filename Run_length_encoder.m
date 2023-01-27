function encoded_output=Run_length_encoder(quantized_image)
encoded_output=[];
counter=0;
flag=false;
for i = 1:length(quantized_image) %looping on the quantized image vector 
 
    if  i~= 1 && quantized_image(i) == 0 && quantized_image(i-1) ~= 0   % counting all the adjacent zeros along the vector 
    
        for j= i+1:1:length(quantized_image)
           
           if quantized_image(j) == 0 
              counter = counter +1;
           else
               break;
           end
        end
        
        if  counter ~= 0
            encoded_output= [encoded_output,0,counter+1];
        end
                    
    end
     
    counter=0;
    if i==1 && quantized_image(i) ==0 && quantized_image(i+1) == 0 % handling the case of zeros at the beginning of the vector
        for k =i+1:length(quantized_image)
            if quantized_image(k)==0
                counter = counter+1;
                flag = true;
           else
                break;
            end
        end
        encoded_output= [encoded_output,0,counter+1];
    end
    if  i ~= 1 && i~= length(quantized_image) && quantized_image(i) == 0 && quantized_image(i-1) ~= 0 && quantized_image(i+1) ~= 0 && flag == false
      encoded_output= [encoded_output,0,1];       %handling the case of finding only one zero along the vector 
    end
     if quantized_image(i) ~= 0            
        encoded_output= [encoded_output, quantized_image(i)]; 
     end
     if quantized_image(i) == 0 && i== length(quantized_image) && quantized_image(i-1)~=0 %handling the case of finding only one zero at the end of the vector
          encoded_output= [encoded_output,0,1]; 
     end
     if quantized_image(i) ==0  && i ==1 && quantized_image(i+1) ~= 0 %handling the case of finding only one zero at the beginning of the vector
         encoded_output= [encoded_output,0,1]; 
     end
      
counter= 0;
flag= false;
end
end
