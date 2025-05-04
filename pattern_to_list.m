% Convert from matrices to lists for image data
function patterns_list = pattern_to_list(patterns_square)
    shape = size(patterns_square);
    patterns_list = multi_dim_transpose(patterns_square);
    patterns_list = reshape(patterns_list, [shape(1)*shape(2), shape(3)]);
end