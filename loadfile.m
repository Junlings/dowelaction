function [ force,lvdt,xl,table_disp ] = loadfile( resfilename ,plotkey)
%Load results from resfilename
%   plotkey: if plot the details data figures
%   Return:  force vector, lvdt, xl, and table disp


% Here specify the result csv file name
A = load(resfilename,'-ascii');
A = A(:,2:end);   % the effective data start from column 2


% Assign to corresponding variables
force = A(:,1);
table_disp = A(:,2);
lvdt_left = A(:,3:5);   % location [-3.5,-2.5,-1.5]
lvdt_right = A(:,6:8);  % location [1.5,2.5,3.5]


% define the moving filter number n
n = 50;
b = 1/n*ones(1,n);
force = moving_aver(force,b);
table_disp = moving_aver(table_disp,b);
lvdt_left(:,1) = moving_aver(lvdt_left(:,1),b);
lvdt_left(:,2) = moving_aver(lvdt_left(:,2),b);
lvdt_left(:,3) = moving_aver(lvdt_left(:,3),b);
lvdt_right(:,1) = moving_aver(lvdt_right(:,1),b);
lvdt_right(:,2) = moving_aver(lvdt_right(:,2),b);
lvdt_right(:,3) = moving_aver(lvdt_right(:,3),b);

% reflect the right part and addon to the left part
lvdt1 = (lvdt_left(:,1) + lvdt_right(:,3))/2.0;  %location 3.5
lvdt2 = (lvdt_left(:,2) + lvdt_right(:,2))/2.0;  %location 2.5
lvdt3 = (lvdt_left(:,3) + lvdt_right(:,1))/2.0;  %location 1.5

lvdt = [lvdt1,lvdt2,lvdt3];

% finish filtering

xl0 =[-3.5,-2.5,-1.5,0,1.5,2.5,3.5];  % both sides
xl =[3.5,2.5,1.5,0];                  % single sides

step = linspace(1,length(A),15);      % 15 data points for distribution
step = round(step');


if strcmp(plotkey,'True')
    
    figure;
    plot(xl0,[lvdt_left(step,:),table_disp(step),lvdt_right(step,:)],'x--');
    grid on;
    xlabel('Location (in)');
    ylabel('Displacement (in)');
    %legendCell = num2str(num2str(force(step)', 'Load=%-f,'))
    %legend(legendCell);



    figure;
    plot(table_disp,force);
    xlabel('Table displacement (in)');
    ylabel('Load (k)');
    grid on;

    figure;
    plot(xl,[lvdt(step,:),table_disp(step)],'x--');
    grid on;
    xlabel('Location (in)');
    ylabel('Displacement (in)');

end
end

