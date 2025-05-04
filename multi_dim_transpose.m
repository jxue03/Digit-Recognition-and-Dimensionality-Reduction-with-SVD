function matrix2 = multi_dim_transpose(matrix)
% multi_dimension_transpose(matrix)
% Transposes each matrixplane of a multi-dimensional matrix
% while maintaining the original matrix structure
    if isfinite(matrix)
        matrix2=permute(matrix,[2 1 3:ndims(matrix)]); % If the entirety of the multidimensional array has finite values
      % then the algorithm proceeds and permutes the first and second
      % dimension of the 16x16x4649 array since the process of partitioning
      % the vector in R256 consists of building the 16x16 image row by row using the transposes of the
      % 16-dimensional columns that are cut from the original pixel vector.
                                                     
end