function [mean_object_tuple] = project_pdm_into_shape_space(training_pdm, shape_space, sigma_values, mean_object)
%subtract the mean object
mean_subtracted_pdm = training_pdm - mean_object;
a_sigma_vector = [];

%for each dimension find a and limit it to 2.5 or -2.5
for i = 1:length(sigma_values)
    %calculate a * sigma
    a_sigma = dot(shape_space(:,i),mean_subtracted_pdm);
    
    %get a
    a = a_sigma/sigma_values(i);
    if a > 2.5
        a = 2.5;
    elseif a < -2.5
        a = -2.5;
    end
    
    %get the final full eigenvalue
    a_sigma = a * sigma_values(i);
    
    
    a_sigma_vector = [a_sigma_vector, a_sigma];
    
end

%return the tuple
mean_object_tuple = a_sigma_vector;
end