function pozymiai = pozymiai_raidems_atpazinti(title, pvz_eiluciu_sk)
% Features = pozymiai_raidems_atpazinti(title, Number_of_symbols_lines) 
% example of function use:
% Read image with written symbols
V = imread(title);
figure(12), imshow(V)
%% Perform segmentation of the symbols and write into cell variable 
% RGB image is converted to grayscale
V_semitone = rgb2gray(V);
% a threshold value is calculated for binary image conversion
threshold = graythresh(V_semitone);
% a grayscale image is converte to binary image
V_binary = im2bw(V_semitone,threshold);
% show the resulting image
figure(1), imshow(V_binary)
% search for the contour of each object
V_kontur = edge(uint8(V_binary));
% show the resulting image
figure(2),imshow(V_kontur)
% fill the contours
se = strel('square',3); 
V_filled = imdilate(V_kontur, se); 
% show the result
figure(3),imshow(V_filled)
% fill the holes
V_solid= imfill(V_filled,'holes');
% show the result
figure(4),imshow(V_solid)
% set labels to binary image objects
[O_suzymeti Number] = bwlabel(V_solid);
% calculate features for each symbol
O_pozymiai = regionprops(O_suzymeti);
% find/read the bounding box of the symbol
O_limits = [O_pozymiai.BoundingBox];
% change the sequence of values, describing the bounding box
O_limits = reshape(O_limits,[4 Number]);
% reag the mass center coordinate
O_centres = [O_pozymiai.Centroid];
% group center coordinate values
O_centres = reshape(O_centres,[2 Number]);
O_centres = O_centres';
% set the label/number for each object in the image
O_centres(:,3) = 1:Number;
% arrange objects according to the column number
O_centres = sortrows(O_centres,2);
% sort accordign to the number of rows and number of symbols in the row
letter_number = Number/pvz_eiluciu_sk;
for k = 1:pvz_eiluciu_sk
    O_centres((k-1)*letter_number+1:k*letter_number,:) = ...
        sortrows(O_centres((k-1)*letter_number+1:k*letter_number,:),3);
end
% cut the symbol from initial image according to the bounding box estimated in binary image
for k = 1:Number
    object{k} = imcrop(V_binary,O_limits(:,O_centres(k,3)));
end
% show one of the symbol's image
figure(5),
for k = 1:Number
   subplot(pvz_eiluciu_sk,letter_number,k), imshow(object{k})
end
% image segments are cutt off
for k = 1:Number 
    V_fragment = object{k};
    % estimate the size of each segment
    [aukstis, plotis] = size(V_fragment);
    
    % eliminate white spaces
    stulpeliu_sumos = sum(V_fragment,1);
    V_fragment(:,stulpeliu_sumos == aukstis) = [];
    [aukstis, plotis] = size(V_fragment);
    eiluciu_sumos = sum(V_fragment,2);
    V_fragment(eiluciu_sumos == plotis,:) = [];
    object{k}=V_fragment;
end
% show the segment
figure(6),
for k = 1:Number
   subplot(pvz_eiluciu_sk,letter_number,k), imshow(object{k})
end
%% Make all segments of the same size 70x50
for k=1:Number
    V_fragment=object{k};
    V_fragmentas_7050=imresize(V_fragment,[70,50]);
    % divide each image into 10x10 size segments
    for m=1:7
        for n=1:5
            % calculate an average intensity for each 10x10 segment
            Vid_sviesumas_eilutese=sum(V_fragmentas_7050((m*10-9:m*10),(n*10-9:n*10)));
            Vid_openess((m-1)*5+n)=sum(Vid_sviesumas_eilutese);
        end
    end
    % perform normalization
    Vid_openess = ((100-Vid_openess)/100);
    % transform features into column-vector
    Vid_openess = Vid_openess(:);
    % save all fratures into single variable
    pozymiai{k} = Vid_openess;
end