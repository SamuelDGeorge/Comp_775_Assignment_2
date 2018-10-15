function [final_pdm] = rotate_and_project_into_shape_space(current_pdm, shape_space, sigma_values, mean_value)
%rotate and center 
[final_pdm,centers_of_gravity,second_moment] = normalize_pdm_object(current_pdm);

%project into shape space
values = project_pdm_into_shape_space(final_pdm,shape_space,sigma_values,mean_value);
final_pdm = mean_value + shape_space * transpose(values);
final_pdm = rotate_by_second_moment(final_pdm,second_moment);
final_pdm = final_pdm + centers_of_gravity; 
end