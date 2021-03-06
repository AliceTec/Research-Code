%%%%%%plots of leading coefficients function against view number %%%
             %%%normalised Lalacian %%%%%

% arguments to the computeFeatureVectorObjectNorm() function
%first : list of coefficients
%second: directory of image
%third  : image type
%fouth  : number of points/vertices of Delanay graph
%fifth&sixth  : cordinates of the extreme corner points to be deleted  

z_num = (1:72);                                                            % list of view numbers
q = [1,2,3,4];                                                             

zGlass     = computeFeatureVectorObjectNorm(q,'glass/obj18__','.png',90,4,3);      
zToy       = computeFeatureVectorObjectNorm(q,'toys/obj48__','.png',55,4,4);     
zBowl      = computeFeatureVectorObjectNorm(q,'bowls/obj25__','.png',150,5,4);
zCup       = computeFeatureVectorObjectNorm(q,'cups/obj11__','.png',40, 8,7);
zBottle    = computeFeatureVectorObjectNorm(q,'bottles/obj50__','.png',40,3,3);
zContainer = computeFeatureVectorObjectNorm(q,'container/obj70__','.png',70, 3, 5);
zBirds     = computeFeatureVectorObjectNorm(q,'birds/obj74__','.png',60, 4, 4);
zIcecream  = computeFeatureVectorObjectNorm(q,'icecream/obj72__','.png',80, 4,3);

%%%%Plots for q_1%%%%

figure(1)
plot(z_num, zGlass(1,:), 'c',...
     z_num, zToy(1,:), 'g',...,
     z_num,zBowl(1,:), 'b',...
     z_num,zCup(1,:), 'c',...            
     z_num,zBottle(1,:),'m',...
     z_num,zContainer(1,:),'y',...
     z_num,zBirds(1,:), 'r',...
     z_num,zIcecream(1,:),'k')  
xlabel('View number') % x-axis label
ylabel('q_1') % y-axis label
legend('Glass','Toy','Bowl','Cup','Bottle','Container','Birds', 'Icecream')


%%%%Plots for q_2%%%%

figure(2)
plot(z_num, zGlass(2,:), 'c',...
     z_num, zToy(2,:), 'g',...,
     z_num,zBowl(2,:), 'b',...
     z_num,zCup(2,:), 'c',...            
     z_num,zBottle(2,:),'m',...
     z_num,zContainer(2,:),'y',...
     z_num,zBirds(2,:), 'r',...
     z_num,zIcecream(2,:),'k')  
xlabel('View number') % x-axis label
ylabel('q_2') % y-axis label
legend('Glass','Toy','Bowl','Cup','Bottle','Container','Birds', 'Icecream')


%%%%Plots for q_3 %%%%

figure(3)
plot(z_num, zGlass(3,:), 'c',...
     z_num, zToy(3,:), 'g',...,
     z_num,zBowl(3,:), 'b',...
     z_num,zCup(3,:), 'c',...            
     z_num,zBottle(3,:),'m',...
     z_num,zContainer(3,:),'y',...
     z_num,zBirds(3,:), 'r',...
     z_num,zIcecream(3,:),'k')  
xlabel('View number') % x-axis label
ylabel('q_3') % y-axis label
legend('Glass','Toy','Bowl','Cup','Bottle','Container','Birds', 'Icecream')

%%%%Plots for q_4 %%%%

figure(4)
plot(z_num, zGlass(4,:), 'c',...
     z_num, zToy(4,:), 'g',...,
     z_num,zBowl(4,:), 'b',...
     z_num,zCup(4,:), 'c',...            
     z_num,zBottle(4,:),'m',...
     z_num,zContainer(4,:),'y',...
     z_num,zBirds(4,:), 'r',...
     z_num,zIcecream(4,:),'k')  
xlabel('View number') % x-axis label
ylabel('q_4') % y-axis label
legend('Glass','Toy','Bowl','Cup','Bottle','Container','Birds', 'Icecream')