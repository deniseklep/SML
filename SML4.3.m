N = 800; D = 28*28; X = uint8(zeros(N,D));
fid = fopen ('a012_images.dat', 'r');
for i = 1:N
X(i,:)  = fread(fid, [D], 'uint8');
end;
status = fclose(fid);
BW_map=[1,1,1; 0,0,0];
for i = 1:10
   im = X(i,:);
   im = reshape(im, [28,28])
   figure();
   image(im);
   colormap(BW_map);
end