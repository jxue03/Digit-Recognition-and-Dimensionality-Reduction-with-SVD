% This function guesses the digit based that the image variable is.
% The image variable will be a column of test_patterns, so a 256x1 matrix
% Depending on how you write this function, you may want to add more
% variables as input
function digit_guess = classify_digit(image,projection_array)
    distance_list = zeros(1,9);
    for i = 1:10
        distance_vector = image - projection_array{i}*image;
        distance_list(i) = norm(distance_vector);
    end
    smallest_distance = min(distance_list);
    
    digit_guess = find(distance_list == smallest_distance)-1;
end