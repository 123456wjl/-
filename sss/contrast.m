function duibidu =contrast (image)
m=size(image,1);
n=size(image,2);
num=m*n;
mean_R=sum(sum(image(:,:,1)))/num;
mean_G=sum(sum(image(:,:,2)))/num;
mean_B=sum(sum(image(:,:,3)))/num;
pingfang_R=0;
pingfang_G=0;
pingfang_B=0;
for i=1:m
  for   j=1:n
      
     pingfang_R=pingfang_R+(image(i,j,1)-mean_R).^2
    
  end
    
end

  for i=1:m
  for   j=1:n
      
     pingfang_G=pingfang_G+(image(i,j,2)-mean_G).^2
    
  end
    
  end  
for i=1:m
  for   j=1:n
      
     pingfang_B=pingfang_B+(image(i,j,3)-mean_B).^2
    
  end
    
end  


duibidu=sqrt((pingfang_R+pingfang_G+pingfang_B)/num)/(mean_R+mean_G+mean_B)
end

