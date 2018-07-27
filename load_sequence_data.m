function [gt, img_files] = load_sequence_data(sequences_path, seq_name)

seq_path = [sequences_path '/' seq_name];
%seq_name = 'David';
%gt = load('./David/groundtruth_rect.txt');
%init_rect = gt(1,:);
%img_file = dir('./David/img/*.jpg');
%img_file = fullfile('./David/img/', {img_file.name});
gt_file = [seq_path '/groundtruth_rect.txt'];
if ~exist(gt_file, 'file')
  % File don't exists.  Do stuff....
  disp('More than one ground truth file exist, choosing the first one :)');
  gt_file = [seq_path '/groundtruth_rect.2.txt'];
end
gt = load(gt_file);
img_files = dir([seq_path '/img/*.jpg']);
img_files = fullfile([seq_path '/img/'], {img_files.name});

end