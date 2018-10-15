function [normalized_pdm, centers_of_gravity, second_moment] = normalize_pdm_object(pdm_vector)
%Obtain x,y from the pdm
x = pdm_vector(1:2:end);
y = pdm_vector(2:2:end);

%mean center the points
x_norm = x - mean(x);
y_norm = y - mean(y);

%make a row vector and build point, space
x_norm = reshape(x_norm,1,length(x));
y_norm = reshape(y_norm,1,length(y));
point_space = reshape([x_norm,y_norm], length(x),2);

%get eigenvectors for rotation and arrange by larger eigenvalue
matrix = [dot(x_norm,x_norm), dot(x_norm,y_norm); dot(x_norm,y_norm), dot(y_norm,y_norm)];
[v,d] = eig(matrix);
eigenvalue_vector = sum(d);
[~,larger_index] = max(eigenvalue_vector);
[~,smaller_index] = min(eigenvalue_vector);
rotation_pre_matrix = [v(:,larger_index),v(:,smaller_index)];

%rotate points
rotate_180 = [-1,0;0,-1];
second_moment = rotation_pre_matrix;
rotated_points = (point_space * rotation_pre_matrix) * rotate_180;

%build final pdm to return
x_final = rotated_points(:,1);
y_final = rotated_points(:,2);
final_pdm = [];
centers_of_gravity = [];

for i = 1:(length(x_final))
    final_pdm = [final_pdm, x_final(i), y_final(i)]; 
    centers_of_gravity = [centers_of_gravity, mean(x), mean(y)];
end
centers_of_gravity = transpose(centers_of_gravity);
normalized_pdm = reshape(final_pdm,2*length(x),1); 
end
