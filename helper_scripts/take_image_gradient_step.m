function [new_pdm] = take_image_gradient_step(pdm, image_derivative_x, image_derivative_y)

%get the normals for all points in the space
[point_normals,point_tuple] = point_normal_calculate(pdm);
new_points = [];
for i = 1:length(point_tuple)
    
    %isolate a single point
    single_point = point_tuple(i,:);
    its_normal = point_normals(i,:);
    
    %find the max gradient along the normal at that point
    new_point = find_max_gradient_point(single_point,its_normal,image_derivative_x, image_derivative_y);
    new_points = [new_points,new_point];
end

%return new pdm
new_pdm = transpose(new_points);
end