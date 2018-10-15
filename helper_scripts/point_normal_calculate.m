function [normals_tuple, point_tuple] = point_normal_calculate(pdm)
%seperate x and y
x = pdm(1:2:end);
y = pdm(2:2:end);
point_tuple = [x,y];
normals = [];

%find the normal direction at each point
for i = 0:length(x) - 1
    %get a starting point and what is to its right and left
    start_point = i + 1;
    left_point = mod((i + 1),length(x)) + 1;
    right_point = mod(i - 1, length(x)) + 1;

    %calculate the apporpriate normal from the right
    a_right = x(right_point) - x(start_point);
    b_right = y(right_point) - y(start_point);
    
    unit_normal_right = [-b_right,a_right]/sqrt(a_right^2 + b_right^2);
    
    %calculate the appropriate normal from the left
    a_left = x(left_point) - x(start_point);
    b_left = y(left_point) - y(start_point);
    unit_normal_left = [b_left,-a_left]/sqrt(a_left^2 + b_left^2);
    
    %find the average normal and store that
    final_unit = (unit_normal_left + unit_normal_right)/2;
    final_unit = final_unit/norm(final_unit);
    normals = [normals;final_unit];

end

%return normal
normals_tuple = normals;
end