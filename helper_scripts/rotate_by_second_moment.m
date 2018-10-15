function [rotated_pdm] = rotate_by_second_moment(pdm, second_moment)

%get x and y
x = pdm(1:2:end);
y = pdm(2:2:end); 


final_pdm = [];

%the rotation matrix
rotate_180 = [-1,0;0,-1];

%for every point rotate it in the space
for i = 1:(length(x))
    to_rotate = [x(i),y(i)];
    final_rotate = (to_rotate * rotate_180) * transpose(second_moment);
    final_pdm = [final_pdm, final_rotate(1), final_rotate(2)]; 
end

rotated_pdm = transpose(final_pdm);
end
