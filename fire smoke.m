
image = imread('fire_smoke_image.jpg');  % Replace with your image file

% Convert the image to LAB color space
lab_image = rgb2lab(image);

% Extract the L (luminance) channel
L = lab_image(:, :, 1);

% Define thresholds for detecting smoke and fire
smoke_threshold = 40;  % Adjust as needed
fire_threshold = 60;   % Adjust as needed

% Create binary masks for smoke and fire
smoke_mask = L <= smoke_threshold;
fire_mask = L >= fire_threshold;

% Combine the smoke and fire masks
combined_mask = smoke_mask | fire_mask;

% Apply morphological operations to clean up the mask
combined_mask = imclose(combined_mask, strel('disk', 10));
combined_mask = imfill(combined_mask, 'holes');

% Find and label connected components (regions) in the mask
labeled_mask = bwlabel(combined_mask);

% Get region properties (bounding boxes) of detected regions
region_props = regionprops(labeled_mask, 'BoundingBox');

% Display the original image
imshow(image);
hold on;

% Draw bounding boxes around detected regions
for i = 1:numel(region_props)
    rectangle('Position', region_props(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end

hold off;
