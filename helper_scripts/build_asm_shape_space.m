function [shape_space, sigma_coeff, mean_object_coeff] = build_asm_shape_space(training_data, k_num_eigenvectors)
%rotate and center all your training data
normed_data = [];
for i = 1:size(training_data,2)
    current_pdm = normalize_pdm_object(training_data(:,i));
    normed_data = [normed_data, current_pdm];
end

normed_data = reshape(normed_data, length(training_data),size(training_data,2));


%normalize all cases of the training data
normed_training_data = normed_data;

%subtract mean object
mean_object_coeff = mean(normed_training_data,2);
ready_training_data = bsxfun(@minus,normed_training_data,mean_object_coeff);
ready_training_data_final = transpose(ready_training_data);

%do PCA on training cases
[vectors, ~, eigenvalues] = pca(ready_training_data_final);
sigma_i = sqrt(eigenvalues);

%build shape space and sigma values
vector_space = [];
sigma_i_space = [];

for i = 1:k_num_eigenvectors
    vector_space = [vector_space,vectors(:,i)];
    sigma_i_space = [sigma_i_space, sigma_i(i)];
end

%Return shape space and sigma values
shape_space = vector_space;
sigma_coeff = sigma_i_space;
end