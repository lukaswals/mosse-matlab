%% Debug mode
global debugMode;
debugMode = true;

%% Necessary paths
addpath('./mosse'); % Add MOSSE filter path

%% Load Sequence/s data
dataset_path = 'C:/Users/win10/Downloads/Datasets/OTB-100';
sequence = 'David';
%sequence = 'Dudek';
[gt, img_files] = load_sequence_data(dataset_path, sequence);

%tracker(gt, img_files)
% COMEBACK AND TEST INITIALIZE FILTER

% Initialize filter, from first frame. 
im = imread( char(img_files(1)) );
% MOSSE worked for single channel (grayscale) images
if (size(im,3) == 3) 
    im = rgb2gray(im);  % Convert image to grayscale
end
% Desired output G is always at the center (not updated later)
[H, G] = initialize_filter(gt(1,:), im);