function Image = junzhi(image)

average=[1,1,1;1,1,1;1,1,1];
aimage(:,:,1)=conv2(image(:,:,1),average)/9;
aimage(:,:,2)=conv2(image(:,:,2),average)/9;
aimage(:,:,3)=conv2(image(:,:,3),average)/9;
[m, n, ~] = size(image);
Image = image;
for i=2:m-1
for j=2:n-1
Image(i,j,1)=aimage(i,j,1);
Image(i,j,2)=aimage(i,j,2);
Image(i,j,3)=aimage(i,j,3);
end
end
end

