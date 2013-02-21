function yhat = modelfun_infinite(b,X)
    global ds L ;
    %d=0.375;
    E=29000;
    I=pi*(ds^4)/64;
    EI = E*I;
    d=1;
    
    beta = b(1);
    [mX,nX] = size(X);
    yhat = zeros(mX,1);
    
    for ij = 1:mX
        P0 = X(ij,1); 
        Vd =P0/2.0;
        xl = X(ij,2);
    
        if xl>d
            %yt =Vd*exp(beta*(-xl+d1))*(d1*beta*sin(beta*xl)*cos(beta*d1)-sin(beta*xl)*cos(beta*d1)-d1*beta*sin(beta*xl)*sin(beta*d1)-sin(beta*xl)*sin(beta*d1)-d1*beta*cos(beta*xl)*cos(beta*d1)-d1*beta*cos(beta*xl)*sin(beta*d1)+cos(beta*xl)*sin(beta*d1)-cos(beta*xl)*cos(beta*d1))/(8*beta^3*EI); % change this expression
        
            yt = exp((beta * (-xl + d))) * Vd * (cos((beta * (-xl + d))) + cos((beta * (-xl + d))) * beta * d + sin((beta * (-xl + d))) * beta * d - sin((beta * (-xl + d)))) / EI / (beta ^ 3) / 0.4e1;
        elseif 0<=xl<=d
            %yt =-Vd*(2*xl^3*beta^3-3*xl^2*beta^3*d1-3*xl^2*beta^2+3*beta*d1+d1^3*beta^3+3*d1^2*beta^2+3)/(24*beta^3*EI);
            yt = (Vd * (2 * xl ^ 3 * beta ^ 3 - 3 * xl ^ 2 * beta ^ 2 - 3 * xl ^ 2 * beta ^ 3 * d + 3 * beta * d + beta ^ 3 * d ^ 3 + 3 + 3 * beta ^ 2 * d ^ 2) / EI / beta ^ 3) / 0.12e2;
        elseif -1<=xl<0
            
 
            %yt =-Vd*(2*(-xl)^3*beta^3-3*(-xl)^2*beta^3*d1-3*(-xl)^2*beta^2+3*beta*d1+d1^3*beta^3+3*d1^2*beta^2+3)/(24*beta^3*EI);
             xl     
        else
            %yt =Vd*exp(beta*(xl+d1))*(d1*beta*sin(beta*(-xl))*cos(beta*d1)-sin(beta*(-xl))*cos(beta*d1)-d1*beta*sin(beta*(-xl))*sin(beta*d1)-sin(beta*(-xl))*sin(beta*d1)-d1*beta*cos(beta*(-xl))*cos(beta*d1)-d1*beta*cos(beta*(-xl))*sin(beta*d1)+cos(beta*(-xl))*sin(beta*d1)-cos(beta*(-xl))*cos(beta*d1))/(8*beta^3*EI);
        end
               
        yhat(ij) = yt; 
    end 

end