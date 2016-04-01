raw_im = Tiff('trees.tif','r');
im = readRGBAImage(raw_im);
im = im2double(im(1:200,1:200,:));

threshold = 0.001;
centerPts = rand(10,3);
new_image = zeros(200,200);
newavg = zeros(10,3);
for K = 1:10
    pt = zeros(1,3);
    for i=1:200
        for j=1:200
            pt(1) = im(i,j,1);
            pt(2) = im(i,j,2);
            pt(3) = im(i,j,3);
            distance = zeros(10,1);
            for k=1:10
                distance(k) = norm(pt - centerPts(k,:));
            end
            [val_,index] = min(distance);
            new_image(i,j) = index;
        end
    end
    
    count = zeros(10,1);

    for i=1:200
        for j=1:200
            pt(1) = im(i,j,1);
            pt(2) = im(i,j,2);
            pt(3) = im(i,j,3);

            newavg(new_image(i,j),:) = newavg(new_image(i,j),:) + pt;
            count(new_image(i,j)) = count(new_image(i,j)) + 1;
        end
    end
    
    for i=1:10
        newavg(i,:) = newavg(i,:)/count(i);
    end
    
    centerPts = newavg;
end


outputimage = zeros(size(im));
for i=1:200
    for j=1:200
        for k=1:3
            outputimage(i,j,k) = newavg(new_image(i,j),k);
        end
    end
end
imwrite(outputimage, 'output.jpg');

