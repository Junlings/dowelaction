
clear;
close all;

Loc = 0:0.001:6;

FF = 1.5*ones(length(Loc),1);
X = [FF, Loc' ];


b =1.0;

yhat = modelfun_derived(b,X);
yhat2 = modelfun_infinite(b,X);
yhat3 = modelfun_theory(b,X);

figure;
hold on;
plot(Loc',yhat,'b');
plot(Loc',yhat2,'r');
plot(Loc',yhat3,'k');
xlabel('Distance from center')
ylabel('Deformation')
legend('Exact Solution','Infinite Solution','Approximate Solution')

%FF = 2*ones(length(Loc),1);
%X = [FF, Loc' ];

%yhat = modelfun(b,X);
%yhat2 = modelfun_infinite(b,X);
%plot(Loc',yhat);
%plot(Loc',yhat2,'r');

%FF = 3*ones(length(Loc),1);
%X = [FF, Loc' ];
%yhat = modelfun(b,X);
%yhat2 = modelfun_infinite(b,X);
%plot(Loc',yhat);
%plot(Loc',yhat2,'r');


