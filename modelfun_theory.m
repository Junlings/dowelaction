function yhat = modelfun_theory(b,X)
    global d L; 
    %d=0.375;
    E=29000;
    I=pi*(d^4)/64;
    EI = E*I;
    d1=1; 
    dl=d1;
    
    beta = b(1);
    k=beta^4*EI*4;
    [mX,nX] = size(X);
    yhat = zeros(mX,1);
    LD = d1*2;
    Ld = L - d1; 
    
    for ij = 1:mX
        P0 = -X(ij,1);
        xl = X(ij,2);
        Vd = P0/2.0;
    
        if xl>d1
            yt =P0 * beta / k * (0.4e1 * exp(-beta * (xl - dl)) * cos(beta * (xl - dl)) - (0.2e1 - beta * Ld) * exp(-beta * (xl - dl)) * (cos(beta * (xl - dl)) - sin(beta * (xl - dl)))) / 0.4e1;
        elseif 0<=xl<=d1
            yt =  P0 / EI * xl ^ 3 / 0.12e2 - P0 * (0.2e1 * EI * beta ^ 3 * Ld + dl ^ 2 * k) / EI / dl / k * xl ^ 2 / 0.8e1 + P0 * (0.6e1 * dl * EI * beta ^ 3 * Ld + 0.12e2 * EI * beta + 0.6e1 * EI * beta ^ 2 * Ld + dl ^ 3 * k) / EI / k / 0.24e2;
        elseif -1<=xl<0
            yt =-Vd*(2*(-xl)^3*beta^3-3*(-xl)^2*beta^3*d1-3*(-xl)^2*beta^2+3*beta*d1+d1^3*beta^3+3*d1^2*beta^2+3)/(24*beta^3*EI);
                
        else
            yt =Vd*exp(beta*(xl+d1))*(d1*beta*sin(beta*(-xl))*cos(beta*d1)-sin(beta*(-xl))*cos(beta*d1)-d1*beta*sin(beta*(-xl))*sin(beta*d1)-sin(beta*(-xl))*sin(beta*d1)-d1*beta*cos(beta*(-xl))*cos(beta*d1)-d1*beta*cos(beta*(-xl))*sin(beta*d1)+cos(beta*(-xl))*sin(beta*d1)-cos(beta*(-xl))*cos(beta*d1))/(8*beta^3*EI);
        end
        
        yhat(ij) = -yt; 
    end 

end