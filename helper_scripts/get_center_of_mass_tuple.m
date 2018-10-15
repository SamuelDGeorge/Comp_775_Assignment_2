function [center_of_mass_tuple] = get_center_of_mass_tuple(pdm)
x = pdm(1:2:end);
y = pdm(2:2:end);

x_mean = mean(x);
y_mean = mean(y);

return_tuple = [];
for i = 1:length(x)
    return_tuple = [return_tuple,x_mean,y_mean];
end
center_of_mass_tuple = transpose(return_tuple);
end