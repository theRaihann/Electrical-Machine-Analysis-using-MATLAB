%%
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 36;
% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
  % User does not have the toolbox installed.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end
%===============================================================================
% Read in a standard MATLAB color demo image.
folder = 'E:\MATLAB CODES\CODES';
baseFileName = 'temporary.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
  % Didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);
% Display the original color image.
subplot(2, 2, 1);
imshow(rgbImage);
axis on;
title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'Outerposition', [0, 0, 1, 1]);
% Extract the individual red, green, and blue color channels.
% redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
% blueChannel = rgbImage(:, :, 3);
% Get the binaryImage
binaryImage = greenChannel < 200;
% Display the original color image.
subplot(2, 2, 2);
imshow(binaryImage);
axis on;
title('Binary Image', 'FontSize', fontSize);
% Find the baseline
verticalProfile  = sum(binaryImage, 2);
lastLine = find(verticalProfile, 1, 'last');
% Scan across columns finding where the top of the hump is
for col = 1 : columns
  yy = lastLine - find(binaryImage(:, col), 1, 'first');
  if isempty(yy)
    y(col) = 0;
  else
    y(col) = yy;
  end
end
subplot(2, 2, 3);
plot(1 : columns, y, 'b-', 'LineWidth', 3);
grid on;
title('Y vs. X', 'FontSize', fontSize);
ylabel('Y', 'FontSize', fontSize);
xlabel('X', 'FontSize', fontSize);



%%

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 22;
%--------------------------------------------------------------------------------------------------------
%    READ IN IMAGE
folder = 'E:\MATLAB CODES\CODES';
baseFileName = 'temporary.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% The file doesn't exist -- didn't find it there in that folder.
	% Check the entire search path (other folders) for the file by stripping off the folder.
	fullFileNameOnSearchPath = baseFileName; % No path this time.
	if ~exist(fullFileNameOnSearchPath, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorChannels should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns, numberOfColorChannels] = size(grayImage)
if numberOfColorChannels > 1
	% It's not really gray scale like we expected - it's color.
	% Use weighted sum of ALL channels to create a gray scale image.
	grayImage = rgb2gray(grayImage);
	% ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
	% which in a typical snapshot will be the least noisy channel.
	% grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the image.
subplot(2, 2, 1);
imshow(grayImage);
axis('on', 'image');
title('Original Grayscale Image', 'FontSize', fontSize, 'Interpreter', 'None');
impixelinfo;
hFig = gcf;
hFig.WindowState = 'maximized'; % May not work in earlier versions of MATLAB.
drawnow;
%--------------------------------------------------------------------------------------------------------
% Get a mask that is the entire image.
% mask = true(size(grayImage));
% Alternative : get a mask that is the thresholded part of the image.
threshold = 195;
binaryImage = grayImage ~= threshold;
subplot(2, 2, 2);
imshow(binaryImage, []);
axis('on', 'image');
title('Mask Image', 'FontSize', fontSize, 'Interpreter', 'None');
impixelinfo;
% Find the top boundary
yTop = zeros(1, columns);
for col = 1 : columns
	top = find(binaryImage(:, col), 1, 'first');
	if ~isempty(top)
		yTop(col) = top;
	end
end
subplot(2, 2, 3);
x = 1 : columns;
plot(x, yTop, 'b-', 'LineWidth', 3);
grid on;
title('Y vs. X', 'FontSize', fontSize);
xlabel('Xtop', 'FontSize', fontSize);
ylabel('Ytop', 'FontSize', fontSize);
% Plot the borders of all the blobs in the overlay above the original grayscale image 
% using the coordinates returned by bwboundaries().
% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
subplot(2, 2, 4);
imshow(grayImage); % Optional : show the original image again.  Or you can leave the binary image showing if you want.
% Here is where we actually get the boundaries for each blob.
boundaries = bwboundaries(binaryImage);
% boundaries is a cell array - one cell for each blob.
% In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
% Column 1 is rows, or y.    Column 2 is columns, or x.
numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
% Here is where we actually plot the boundaries of each blob in the overlay.
hold on; % Don't let boundaries blow away the displayed image.
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k}; % Get boundary for this specific blob.
	x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	y = thisBoundary(:,1); % Column 1 is the rows, which is x.
	plot(x, y, 'r-', 'LineWidth', 3); % Plot boundary in red.
end
hold off;
title('Binary Image with Full Boundary', 'FontSize', fontSize); 
axis('on', 'image'); % Make sure image is not artificially stretched because of screen's aspect ratio.