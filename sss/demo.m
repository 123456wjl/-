tic
image=imread('dd.jpeg');
image=im2double(image);
figure(1),imshow(image)

[m, n, ~] = size(image);
win_size=15;

pad_size = floor(win_size/2);

padded_image = padarray(image, [pad_size pad_size], Inf);
figure(2),imshow(padded_image);


dark_channel = zeros(m, n); 
%将图像相应块的颜色通道最小值赋给暗通道矩阵的相应位置上
for j = 1 : m
    for i = 1 : n
        patch = padded_image(j : j + (win_size-1), i : i + (win_size-1), :);
        dark_channel(j,i) = min(patch(:));
     end
end             


figure(3),imshow(dark_channel)
imwrite(dark_channel,'暗通道.jpg')
num=m*n;
A=reshape(dark_channel,num,1);
image_vec=reshape(image,num,3);
[B,I]=sort(A,'descend');
ber=round(num/1000);
T=zeros(num,1);
for k=1:num
   T(k)=max(image_vec(k,:))-min(image_vec(k,:));
end
 t=sum(T)/num;
 nn=0;
 while(1)   
 if(max(image_vec(I(nn*ber+1),:))-min(image_vec(I(nn*ber+1),:))>1.5*t)  
     atmosphere=image_vec(I(nn*ber+1),:);
    break
 else
    nn=nn+1;      
 end           
 end
 
omega=0.95;

rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);
trans_est = 1 - omega * get_dark_channel( image ./ rep_atmosphere, win_size);

figure(5),imshow(trans_est)
L = get_laplacian(image);
lambda = 0.0001;

A = L + lambda * speye(size(L));
b = lambda * trans_est(:);

x = A \ b;

transmission_R = reshape(x, m, n);

figure(6),imshow(transmission_R);

  gain_1=image(:,:,2)./image(:,:,1);
  gain_2=image(:,:,3)./image(:,:,1);
  alpha=1.2;
  bata=1.1;
  
  
  gainG=alpha*(atmosphere(1)/atmosphere(2))*gain_1;
  gainB=bata*(atmosphere(1)/atmosphere(3))*gain_2;

  transmission_G=transmission_R.^gainG; 
  transmission_B=transmission_R.^gainB; 
  rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);
  
  
   max_transmissionR=max(transmission_R,0.1);
   max_transmissionG=max(transmission_G,0.1);
   max_transmissionB=max(transmission_B,0.1);
   figure(7),imshow(max_transmissionR);
   figure(8),imshow(max_transmissionG);
   figure(9),imshow(max_transmissionB);
   transmision_final=cat(3,max_transmissionR, max_transmissionG, max_transmissionB);
   
   radiance=(image-rep_atmosphere)./transmision_final+rep_atmosphere;
   figure(10),imshow(radiance)
   
    duibidu2=contrast(radiance);
    
   avgR=sum(sum(radiance(:,:,1)))/num;
   avgG=sum(sum(radiance(:,:,2)))/num;
   avgB=sum(sum(radiance(:,:,3)))/num;
    
    dd=[ avgR; avgG ;avgB];
   [ddd,II]=sort(dd,'descend');
    Radiance=zeros(m,n,3);
    Radiance(:,:,II(2))=radiance(:,:,II(2));
    Radiance(:,:,II(1))=radiance(:,:,II(1))*dd(II(2))/ dd(II(1));
    Radiance(:,:,II(3))=radiance(:,:,II(3))*dd(II(2))/ dd(II(3));
    figure(14),imshow(Radiance)
     imwrite(trans_est,'未精细化传输图.jpg');
     imwrite(transmission_R,'精细化传输图.jpg');
     imwrite(transmission_B,'B传输图.jpg');
     imwrite(transmission_G,'G传输图.jpg');
     imwrite(radiance,'色平衡前.jpg');
  % imwrite(image_t,'饱和度.jpg');
     imwrite(Radiance,'结果图.jpg');
     figure(15),imshow(Radiance)
    duibidu1=contrast(image);
    
    duibidu3=contrast(Radiance);
    Image = junzhi(image);
    figure(16),imshow(Image)
    [ss,pp]=bianyuan(image);   %ss为边缘图，pp为边缘精度
    [SS,PP]=bianyuan(Radiance);
    figure(17),imshow(ss)
    figure(18),imshow(SS)
    imwrite(SS,'本文边缘.jpg');
    imwrite(ss,'均值边缘.jpg');
    toc