function yhat = modelfun_theory(b,X)
    global ds L; 
    %d=0.375;
    E=29000;
    I=pi*(ds^4)/64;
    EI = E*I;
    d = 1;
    
    beta = b(1);
    k=beta^4*EI*4;
    [mX,nX] = size(X);
    yhat = zeros(mX,1);

    Ld = L - d; 
    
    for ij = 1:mX
        P0 = X(ij,1);
        xl = X(ij,2);
        Vd = P0/2.0;
        %try half P0
        P0 = P0/2;
    
        if xl>d
            yt = P0 * beta / k * (0.4e1 * exp(-beta * (xl - d)) * cos(beta * (xl - d)) - (0.2e1 - beta * Ld) * exp(-beta * (xl - d)) * (cos(beta * (xl - d)) - sin(beta * (xl - d)))) / 0.4e1;
        elseif 0<=xl<=d
            yt =  P0 / EI * xl ^ 3 / 0.12e2 - P0 * (0.2e1 * EI * beta ^ 3 * Ld + d ^ 2 * k) / EI / d / k * xl ^ 2 / 0.8e1 + P0 * (0.6e1 * d * EI * beta ^ 3 * Ld + 0.12e2 * EI * beta + 0.6e1 * EI * beta ^ 2 * Ld + d ^ 3 * k) / EI / k / 0.24e2;
        elseif -1<=xl<0
           'error'
                
        else
             'error'
        end
        
        yhat(ij) = yt; 
    end 

end