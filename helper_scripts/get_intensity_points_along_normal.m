function [eleven_points_along_normal] = get_intensity_points_along_normal(single_point, its_normal)
%just get 1 -5 pixels away in each direction as well as the center
points = [(5 * its_normal) + single_point;(4 * its_normal) + single_point;(3 * its_normal) + single_point;(2 * its_normal) + single_point;(1 * its_normal) + single_point; single_point];
points = [points;(-1 * its_normal) + single_point;(-2 * its_normal) + single_point;(-3 * its_normal) + single_point;(-4 * its_normal) + single_point;(-5 * its_normal) + single_point];

%return points
eleven_points_along_normal = points;
end