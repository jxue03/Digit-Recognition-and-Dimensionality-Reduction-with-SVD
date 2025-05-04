% Convert from lists to matrices for image data
function patterns_square = pattern_to_square(patterns_list)  % Here we are feeding the 256x4649 training matrix to the function
    shape = size(patterns_list);       % Computing size will give vector [256 4649]
    n = sqrt(shape(1));                % We take the sqrt of the first entry (256) because this comes from a square pixel image
                                       % representing a given digit
    patterns_square = reshape(patterns_list, [n,n,shape(2)]);  % This reshapes the data into 4649 matrices of size 16x16
    % which fit into a 16 x 16 x 4649 multi-dimensional matrix
                                                           
    patterns_square = multi_dim_transpose(patterns_square);
end