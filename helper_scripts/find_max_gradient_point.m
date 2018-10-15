function [max_point] = find_max_gradient_point(single_point, its_normal, image_derivative_x, image_derivative_y)
intensity_points = get_intensity_points_along_normal(single_point,its_normal);
negative_u = -its_normal;
%Find max derivative
derivative_values = [];
for i = 1:length(intensity_points)
    %get your point and distance from point.
    x_point = intensity_points(i,1);
    y_point = intensity_points(i,2);
    delta_x = x_point - floor(x_point);
    delta_y = y_point - floor(y_point);
    
    %find the points where we are taking the derivative
    Derivative_point_one = [floor(x_point),floor(y_point)];
    Derivative_point_two = [floor(x_point),ceil(y_point)];
    Derivative_point_three = [ceil(x_point), floor(y_point)];
    Derivative_point_four = [ceil(x_point), ceil(y_point)];
    
    %get the gradient at all 4 of the surrounding points
    gradient_one = [image_derivative_x(Derivative_point_one(2),Derivative_point_one(1)),-image_derivative_y(Derivative_point_one(2),Derivative_point_one(1))];
    gradient_two = [image_derivative_x(Derivative_point_two(2),Derivative_point_two(1)),-image_derivative_y(Derivative_point_two(2),Derivative_point_two(1))];
    gradient_three = [image_derivative_x(Derivative_point_three(2),Derivative_point_three(1)),-image_derivative_y(Derivative_point_three(2),Derivative_point_three(1))];
    gradient_four = [image_derivative_x(Derivative_point_four(2),Derivative_point_four(1)),-image_derivative_y(Derivative_point_four(2),Derivative_point_four(1))];
    
    %interpolate the gradient
    final_gradient = (delta_y * (delta_x * gradient_four + (1-delta_x) * gradient_two)) + ((1 - delta_y) * (delta_x * gradient_three + (1-delta_x) * gradient_one));
    
    %dot product with the normal
    value = dot(negative_u,final_gradient);
    derivative_values = [derivative_values,value]; 
end
%pick your best point
[value, max_index] = max(derivative_values);
max_point = intensity_points(max_index,:);
end
