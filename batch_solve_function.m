function [ beta1,beta2,beta3,beta_total ] = batch_solve_function( resfilename,fun,start_perc,end_perc)
%curve fitting function
%   resfilename: input result file name
%   fun: curve fitting function handle
%   start_perc: start fit load percentage [0,1]
%   end_perc:   end fit load percentage [0,1]


% load and plot raw data
% The right side results are added to the left side after load data from
% result file
[force,lvdt,xl,table_disp] = loadfile(resfilename,'True'); % not plot moving average results

% use portion within force range
[ym,im] = max(force);
im1 = find(force > start_perc*ym);
im2 = find(force < end_perc*ym);
imp = intersect(im1(1):im,im2);

% whether or not to include table displacement
includetable = 0;

% now distribute observations for location into column vector
X = [];
y = [];
yoc = {};  % to save results based on locations along the rebar
for kl = 1:length(xl),   % xl  =[3.5,2.5,1.5,0];
    xval = xl(kl);
    
    if xval < 0
        print 'error'  % now only use the positive side
        
    elseif xval == 0
        dvec = table_disp(imp);  % table movement
        
    elseif xval > 0
        %dvec = lvdt_right(imp,kl-4);
        dvec = lvdt(imp,kl);     
    end
    
    if force(imp) < 0
        fforce = -force(imp);
    else
        fforce = force(imp);
    end
    
    newdata = [fforce xval*ones(size(force(imp)))];
    
    if includetable == 0 & xval == 0
        % skip the table movement if required,(default)
    else
        X = [X;newdata];
        y = [y;dvec];
        yoc{kl,1} = [fforce,xval*ones(size(force(imp))),dvec];
        
    end
end

%{
% curve for location 1
figure;
h1 = plot(yoc{1,1}(:,3),yoc{1,1}(:,1));
set(gca,'FontSize',30)
saveas(h1,'h1.jpg') 

% curve for location 2
figure;
h2 = plot(yoc{2,1}(:,3),yoc{2,1}(:,1));
set(gca,'FontSize',30)
saveas(h2,'h2.jpg') 

% curve for location 3
figure;
h3 = plot(yoc{3,1}(:,3),yoc{3,1}(:,1));
set(gca,'FontSize',30)
saveas(h3,'h3.jpg') 
%}

beta0 = 1;
%L = 6;
%d = 0.375;

% fit for beta value for individual locations, some of them may fail due to
% the imperfection of the recorder data points
%  [beta1,R1,J1,CovB1,MSE1] = nlinfit(yoc{1,1}(:,1:2),yoc{1,1}(:,3),fun,beta0);%,options);
try
    [beta1,R1,J1,CovB1,MSE1] = nlinfit(yoc{1,1}(:,1:2),yoc{1,1}(:,3),fun,beta0);%,options);
catch err
     beta1 = -1 ; % use -1 to denote the failure of the curvefitting
end
try
    [beta2,R2,J2,CovB2,MSE2] = nlinfit(yoc{2,1}(:,1:2),yoc{2,1}(:,3),fun,beta0);%,options);
catch err
     beta2 = -1 ; % use -1 to denote the failure of the curvefitting
end
    
try
    [beta3,R3,J3,CovB3,MSE3] = nlinfit(yoc{3,1}(:,1:2),yoc{3,1}(:,3),fun,beta0);%,options);
catch err
     beta3 = -1 ; % use -1 to denote the failure of the curvefitting
end
% save X
% nonlinear regression


try
    
    [beta_total,R_total,J_total,CovB_total,MSE_total] = nlinfit(X(1:nnn,1:2),y(1:nnn),fun,beta0);%,options);
 %calculate the corresponding k values
catch err
     beta_total = -1 ; % use -1 to denote the failure of the curvefitting
end
 
kstiff1 = beta1(1)^4*28.15;
kstiff2 = beta2(1)^4*28.15;
kstiff3 = beta3(1)^4*28.15;

% check with plots versus data to see residuals
%Pvals = [0.3,0.6,0.9,1.2,1.5,0.9*ym];
Pvals = linspace(start_perc,end_perc,10) *ym ;

xcont = linspace(0,4,25)';

figure;

for kl = 1:length(Pvals);
    Pl = Pvals(kl);
    yhat = fun(beta3,[Pl*ones(size(xcont)) xcont]);
    plot(xcont,yhat,'b-',-xcont,yhat,'b-');
    hold on;
    
    ij = find(force > Pl);
    %plot(xl,[lvdt(ij(1),:),table_disp(ij(1))],'rx-.'); % plot table movements
    plot(xl(1:3),lvdt(ij(1),:),'rx-.'); % plot comparison, table movement if too big
end

grid on;
xlabel('Location (in)');
ylabel('Displacement (in)');



end

