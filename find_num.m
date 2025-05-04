% This function finds the images depicting a certain digit (num) in the data,
%  by reading the labels (digit_labels)
function images_num = find_num(num, digit_labels, images)
    % Make a list of all indices where that digit occurs
    pos_num = find(digit_labels == num);
    images_num = [];   % We initialize images_num as an array that will eventually be a multi-dimensional matrix
    for i = 1:length(pos_num)   % There are (length(pos_num)) images that correspond to the num casted
        images_num(:,:,i) = images(:,:,pos_num(i));    % The ith plane(or layer) of the multidimatrix corresponds to the 
        % ith entry of the index list containing the indeces of the picture list that coincide with the asked number
    end
end

% In the end a list is returned. The list has all the images in the training set that are
% associated with the number being given