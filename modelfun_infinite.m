function yhat = modelfun_infinite(b,X)
    global d L ;
    %d=0.375;
    E=29000;
    I=pi*(d^4)/64;
    EI = E*I;
    d1=1;
    
    beta = b(1);
    [mX,nX] = size(X);
    yhat = zeros(mX,1);
    
    for ij = 1:mX
        Vd = -X(ij,1)/2.0;
        xl = X(ij,2);
    
        if xl>1
            yt =Vd*exp(beta*(-xl+d1))*(d1*beta*sin(beta*xl)*cos(beta*d1)-sin(beta*xl)*cos(beta*d1)-d1*beta*sin(beta*xl)*sin(beta*d1)-sin(beta*xl)*sin(beta*d1)-d1*beta*cos(beta*xl)*cos(beta*d1)-d1*beta*cos(beta*xl)*sin(beta*d1)+cos(beta*xl)*sin(beta*d1)-cos(beta*xl)*cos(beta*d1))/(8*beta^3*EI); % change this expression
         
        elseif 0<=xl<=1
            yt =-Vd*(2*xl^3*beta^3-3*xl^2*beta^3*d1-3*xl^2*beta^2+3*beta*d1+d1^3*beta^3+3*d1^2*beta^2+3)/(24*beta^3*EI);
            
        elseif -1<=xl<0
            yt =-Vd*(2*(-xl)^3*beta^3-3*(-xl)^2*beta^3*d1-3*(-xl)^2*beta^2+3*beta*d1+d1^3*beta^3+3*d1^2*beta^2+3)/(24*beta^3*EI);
                
        else
            yt =Vd*exp(beta*(xl+d1))*(d1*beta*sin(beta*(-xl))*cos(beta*d1)-sin(beta*(-xl))*cos(beta*d1)-d1*beta*sin(beta*(-xl))*sin(beta*d1)-sin(beta*(-xl))*sin(beta*d1)-d1*beta*cos(beta*(-xl))*cos(beta*d1)-d1*beta*cos(beta*(-xl))*sin(beta*d1)+cos(beta*(-xl))*sin(beta*d1)-cos(beta*(-xl))*cos(beta*d1))/(8*beta^3*EI);
        end
        
        yhat(ij) = yt; 
    end 

end