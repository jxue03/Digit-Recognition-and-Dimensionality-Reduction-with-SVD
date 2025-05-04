load("usps_resampled.mat");
% Reshape images for training into 16 by 16 matrices
train_patterns_square = pattern_to_square(train_patterns);

% Display a number of images, and the corresponding labels
%  This is just to make sure data is in proper format
interval = 40:55;
montage(train_patterns_square(:,:,interval));

% Sanity check that pattern_to_list undoes pattern_to_square
train_patterns_list = pattern_to_list(train_patterns_square);
train_patterns_square2 = pattern_to_square(train_patterns_list);
%montage(train_patterns_square2(:,:,interval));

read_label(train_labels(:,interval));  % If the methods correctly deconstruct into list and then reconstruct into square
                                      % then our functions work as desired

% digit_labels is a list whose i-th spot is the digit of the 
%  i-th image
digit_labels = read_label(train_labels);

% collect all images of 0-9 into the 0-9 image cluster.
images_num_0 = find_num(0, digit_labels, train_patterns_square);
images_num_1 = find_num(1, digit_labels, train_patterns_square);
images_num_2 = find_num(2, digit_labels, train_patterns_square);
images_num_3 = find_num(3, digit_labels, train_patterns_square);
images_num_4 = find_num(4, digit_labels, train_patterns_square);
images_num_5 = find_num(5, digit_labels, train_patterns_square);
images_num_6 = find_num(6, digit_labels, train_patterns_square);
images_num_7 = find_num(7, digit_labels, train_patterns_square);
images_num_8 = find_num(8, digit_labels, train_patterns_square);
images_num_9 = find_num(9, digit_labels, train_patterns_square);

% We supress the montages and show separately in the slides given
% MATLAB only shows one figure at a time

%montage(images_num_0(:,:,1:36))
%montage(images_num_1(:,:,1:36))
%montage(images_num_2(:,:,1:36))
%montage(images_num_3(:,:,1:36))
%montage(images_num_4(:,:,1:36))
%montage(images_num_5(:,:,1:36))
%montage(images_num_6(:,:,1:36))
%montage(images_num_7(:,:,1:36))
%montage(images_num_8(:,:,1:36))
%montage(images_num_9(:,:,1:36))


% Convert them to lists, rather than 
images_num_0_list = pattern_to_list(images_num_0);
images_num_1_list = pattern_to_list(images_num_1);
images_num_2_list = pattern_to_list(images_num_2);
images_num_3_list = pattern_to_list(images_num_3);
images_num_4_list = pattern_to_list(images_num_4);
images_num_5_list = pattern_to_list(images_num_5);
images_num_6_list = pattern_to_list(images_num_6);
images_num_7_list = pattern_to_list(images_num_7);
images_num_8_list = pattern_to_list(images_num_8);
images_num_9_list = pattern_to_list(images_num_9);

% Perform SVD on the digit clusters (list format!)
[U0,S0,V0] = svd(images_num_0_list);
[U1,S1,V1] = svd(images_num_1_list);
[U2,S2,V2] = svd(images_num_2_list);
[U3,S3,V3] = svd(images_num_3_list);
[U4,S4,V4] = svd(images_num_4_list);
[U5,S5,V5] = svd(images_num_5_list);
[U6,S6,V6] = svd(images_num_6_list);
[U7,S7,V7] = svd(images_num_7_list);
[U8,S8,V8] = svd(images_num_8_list);
[U9,S9,V9] = svd(images_num_9_list);

%{
Again we supress the montages and show them in the slides to allow for
inspection of one at a time. First we convert each of the singular matrices
for each cluster into a multi-dim array each with the corresponding
eigen-digit on each layer

first_12_U0_k = pattern_to_square(U0_k_singular_vectors);
first_12_U1_k = pattern_to_square(U0_k_singular_vectors);
first_12_U2_k = pattern_to_square(U0_k_singular_vectors);
first_12_U3_k = pattern_to_square(U0_k_singular_vectors);
first_12_U4_k = pattern_to_square(U0_k_singular_vectors);
first_12_U5_k = pattern_to_square(U0_k_singular_vectors);
first_12_U6_k = pattern_to_square(U0_k_singular_vectors);
first_12_U7_k = pattern_to_square(U0_k_singular_vectors);
first_12_U8_k = pattern_to_square(U0_k_singular_vectors);
first_12_U9_k = pattern_to_square(U0_k_singular_vectors);

Then we montage the first 12 layers for each cluster 

montage(first_12_U0_k(:,:,1:12))
montage(first_12_U1_k(:,:,1:12))
montage(first_12_U2_k(:,:,1:12))
montage(first_12_U3_k(:,:,1:12))
montage(first_12_U4_k(:,:,1:12))
montage(first_12_U5_k(:,:,1:12))
montage(first_12_U6_k(:,:,1:12))
montage(first_12_U7_k(:,:,1:12))
montage(first_12_U8_k(:,:,1:12))
montage(first_12_U9_k(:,:,1:12))
%}

% We initialize accuracies as a 1x50 vector that will contain the
% respective accuracies for the ith possible k value on the ith spot
accuracies = zeros(1,50);

for k = 1:50
    % for each particular k at a time, we take k many column vectors from
    % each Un matrix for each cluster corresponding to digit n
    
    U0_k_singular_vectors = U0(:,1:k);
    U1_k_singular_vectors = U1(:,1:k);
    U2_k_singular_vectors = U2(:,1:k);
    U3_k_singular_vectors = U3(:,1:k);
    U4_k_singular_vectors = U4(:,1:k);
    U5_k_singular_vectors = U5(:,1:k);
    U6_k_singular_vectors = U6(:,1:k);
    U7_k_singular_vectors = U7(:,1:k);
    U8_k_singular_vectors = U8(:,1:k);
    U9_k_singular_vectors = U9(:,1:k);
    
    % We build the projection matrix Pu for each collection of column
    % vectors. Given that Un are orthogonal matrices we have that
    % Pu = Un(Un'*Un)^-1*Un' = Un(I)^-1*Un' = Un*Un'
    
    Pu_0 = U0_k_singular_vectors*U0_k_singular_vectors';
    Pu_1 = U1_k_singular_vectors*U1_k_singular_vectors';
    Pu_2 = U2_k_singular_vectors*U2_k_singular_vectors';
    Pu_3 = U3_k_singular_vectors*U3_k_singular_vectors';
    Pu_4 = U4_k_singular_vectors*U4_k_singular_vectors';
    Pu_5 = U5_k_singular_vectors*U5_k_singular_vectors';
    Pu_6 = U6_k_singular_vectors*U6_k_singular_vectors';
    Pu_7 = U7_k_singular_vectors*U7_k_singular_vectors';
    Pu_8 = U8_k_singular_vectors*U8_k_singular_vectors';
    Pu_9 = U9_k_singular_vectors*U9_k_singular_vectors';
    
    % We collect each of the projection matrices into an array
    
    projections_array = {Pu_0,Pu_1,Pu_2,Pu_3,Pu_4,Pu_5,Pu_6,Pu_7,Pu_8,Pu_9};
    
    % We follow initiliaze number of erros to zero and we will add one for 
    % each time the for loop detects disparity b/w our prediction and the
    % actual assigned number to each test patter
    num_error = 0;
    for i = 1:4649
       if read_label(test_labels(:,i)) ~= classify_digit(test_patterns(:,i),projections_array)
         num_error = num_error + 1;
       end
    end
    % at the end of every 'i' for loop in the major 'k' for loop we will 
    % assign to index k the actual accuracy in percentages
    accuracies(k) = 100*(4649-num_error)/4649;
end

% We collect all the accuracies from k=1 to k=50 and finally plot one
% against the other

x = 1:50;
y = accuracies;
plot(x,y,'r.')

str = "The best accuracy was of %" + max(accuracies) + "!!";
fprintf(str)


    



