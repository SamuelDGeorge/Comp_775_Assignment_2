%import Data
cd C:\Users\sdgeo\Dropbox\Own\Graduate-School\First_Semester\COMP_775\Workspace\Assignment_2;
binary_images =  load('helper_files/binaryimages.mat');
correct_pdms = load('helper_files\correctpdms.mat');
grey_images = load('helper_files\greyimages.mat');
pdms = load('helper_files\greyimages.mat');


%Set up problem 
num_training = 24;
k_num_eigenvectors = 6;
training = randperm(32,num_training);

%import all data
%import all data
image_data = grey_images.greyimages;
all_data = correct_pdms.correctpdms;
raw_data = correct_pdms.correctpdms;
training_data = all_data(:,training);
test_data = raw_data;
test_correct_data = correct_data;
test_data(:, training) = [];
image_data(:, training) = [];

%build shape space and get shape space parameters
[shape_space, sigma_values, mean_value] = build_asm_shape_space(training_data,k_num_eigenvectors);


%test on all your cases

for j = 1:8
%Set up the test cases
%test case
t = j;

%run test case
test_pdm = test_data(:,t);
test_image = im2double(reshape(image_data(:,t),256,256));
[image_derivative_x, image_derivative_y] = Derivative(test_image, 5);


%Train the training casses


%optimization steps 

%Start with the base image
current_pdm = test_pdm;
for i = 1:10
%step one, move each point to its normal max
%move point to its position of greatest derivative normal value
final_pdm = take_image_gradient_step(current_pdm,image_derivative_x, image_derivative_y);

final_pdm = rotate_and_project_into_shape_space(final_pdm,shape_space, sigma_values,mean_value);
current_pdm = final_pdm;
end

%compare how well we did

imagesc(test_image),colormap('gray');
hold on;
plot(test_pdm(1:2:end),test_pdm(2:2:end), 'b');
hold off;
name = ['starting_pdm_auto' '_' num2str(t) '.png'];
print(name,'-dpng');

imagesc(test_image),colormap('gray');
hold on;
plot(final_pdm(1:2:end),final_pdm(2:2:end), 'b');
hold off;
name_2 = ['optomized_pdm_auto' '_' num2str(t) '.png'];
print(name_2,'-dpng');
end