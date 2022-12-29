clear;
close all;

% Create a list of image filenames in the folder
imgs_path = 'silex_dvpt/RTI/jpeg-exports/';
extension = '*.JPG';
imageFiles = dir(strcat(imgs_path,extension)); % Replace 'folder_name' with the name of your folder
numFiles = length(imageFiles);

% Initialize the 3D tensor for storing the images
scale = 0.25; % resize factor
[row, col, ~] = size(imresize(imread(strcat(imgs_path,imageFiles(1).name)), scale));
data.I = zeros(row, col, numFiles); % Replace 'row' and 'col' with the desired size for the images

% Open the file for reading
lights_path = 'silex_dvpt/RTI/assembly-files/lumiere.txt';
fid = fopen(lights_path, 'r');

% Initialize the matrix to hold the data
calib.S = zeros(numFiles, 3); % traditional CV coordinate system

% Loop through all the image files
for i = 1:numFiles
    % Read the image file
    image = imread(strcat(imgs_path,imageFiles(i).name));

    % Convert the image to grayscale
    image = im2double(rgb2gray(image));

    % Resize the image
    image = imresize(image, scale);

    % Store the image in the 3D tensor
    data.I(:,:,i) = image;

    % Read the current line
    line = fgetl(fid);
    
    % Split the line into tokens using the space character as the delimiter
    tokens = strsplit(line, ' ');
    
    % Store the data in the matrix
    calib.S(i,:) = [str2double(tokens{2}); -str2double(tokens{3}); -str2double(tokens{4})];
end

% Close the file
fclose(fid);

% Save
save('data.mat', 'data');
save('calib.mat', 'calib');