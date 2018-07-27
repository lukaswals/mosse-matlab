%% Debug mode
global debugMode;
debugMode = true;

%% Necessary paths
addpath('./mosse'); % Add MOSSE filter path

%% Load Sequence/s data
dataset_path = 'C:/Users/win10/Downloads/Datasets/OTB-100';
sequence = 'David';
[gt, img_files] = load_sequence_data(dataset_path, sequence);

%% PART OF "tracker.m" CODE, THIS SHOULD BE MOVED AFTERWARDS
% Select target from first frame
% Remember that we are passing img_file as a cell array, and imread only accepts
% a 'character vector'
im = imread( char(img_file(1)) );
% MOSSE worked for single channel (grayscale) images
if (size(im,3) == 3) 
    im = rgb2gray(im);  % Convert image to grayscale
end

% FILTER INITIALIZATION TEST
initialize_filter(gt(1,:), im);