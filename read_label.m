% This function reads the digit from a given label in
% train_label/test_label
function labels = read_label(k_lab)
    shape = size(k_lab);
    col = shape(2);
    labels = zeros(1,col);
    for i = 1:col
        num = find(k_lab(:,i) == 1) - 1;
        labels(i) = num;
    end
end