function [ss,pp]= bianyuan(image)


soble1=[1,0,-1;1,0,-1;1,0,-1];
soble2=[1,1,1;0,0,0;-1,-1,-1];
soble3=[0,-1,0;1,0,-1;0,1,0];
soble4=[0,1,0;1,0,-1;0,-1,0];

s11=conv2(image(:,:,1),soble1);
s21=conv2(image(:,:,1),soble2); 
s31=conv2(image(:,:,1),soble3); 
s41=conv2(image(:,:,1),soble4); 
s12=conv2(image(:,:,2),soble1);
s22=conv2(image(:,:,2),soble2); 
s32=conv2(image(:,:,2),soble3); 
s42=conv2(image(:,:,2),soble4); 
s13=conv2(image(:,:,3),soble1);
s23=conv2(image(:,:,3),soble2); 
s33=conv2(image(:,:,3),soble3); 
s43=conv2(image(:,:,3),soble4); 
[m, n, ~] = size(image);
pp=0;
ss=zeros(m-2,n-2);
for i=1:(m-2)
    for j=1:(n-2)
               
       ss(i,j)=sqrt((s11(i,j)^2+s21(i,j)^2+s31(i,j)^2+s41(i,j)^2+s12(i,j)^2+s22(i,j)^2+s32(i,j)^2+s42(i,j)^2+s13(i,j)^2+s23(i,j)^2+s33(i,j)^2+s43(i,j)^2)/2);
       pp=pp+ss(i,j);
    end
end

pp=pp/((m-2)*(n-2))
end

