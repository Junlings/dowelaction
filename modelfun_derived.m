function yhat = modelfun_derived(b,X)
    global ds L;
    %d=0.375;          % rebar diameter
    E=29000;          % rebar modulus
    I=pi*(ds^4)/64;    % rebar second moment of inertia
    EI = E*I;       
    d = 1;             % half distance of hole
    Ld = L - d;
    beta =  b(1);
    [mX,nX] = size(X);
    yhat = zeros(mX,1);
    
    %L = 6;            % the half length of finite beam
    

    for ij = 1:mX
        P0 = X(ij,1);   % first column is load
        xl = X(ij,2);   % second column is displacement
        
        if xl > d
            yt = 1/8*1/beta^3/EI*P0*(-2*sinh(beta*Ld)*cos(beta*(-xl+d))*cosh(beta*(Ld-xl+d))*sin(beta*Ld)*cos(beta*Ld)+2*sin(beta*Ld)*cosh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*sinh(beta*Ld)*cosh(beta*Ld)+2*cos(beta*(-xl+d))*cosh(beta*(Ld-xl+d))*cosh(beta*Ld)-2*cos(beta*(-xl+d))*cosh(beta*(Ld-xl+d))*cosh(beta*Ld)^3-2*cosh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*cos(beta*Ld)^3+2*cosh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*cos(beta*Ld)-sinh(beta*Ld)*cosh(beta*(Ld-xl+d))*sin(beta*(-xl+d))*cos(beta*Ld)^2-sinh(beta*Ld)*sinh(beta*(Ld-xl+d))*cos(beta*(-xl+d))*cos(beta*Ld)^2-sin(beta*Ld)*sinh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*cos(beta*Ld)^2-sin(beta*Ld)*cosh(beta*(-xl+d))*sin(beta*(Ld-xl+d))*cos(beta*Ld)^2+sinh(beta*Ld)*cosh(beta*(Ld-xl+d))*sin(beta*(-xl+d))*cosh(beta*Ld)^2+sinh(beta*Ld)*sinh(beta*(Ld-xl+d))*cos(beta*(-xl+d))*cosh(beta*Ld)^2+sin(beta*Ld)*sinh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*cosh(beta*Ld)^2+sin(beta*Ld)*cosh(beta*(-xl+d))*sin(beta*(Ld-xl+d))*cosh(beta*Ld)^2-2*sinh(beta*Ld)*cos(beta*(-xl+d))*cosh(beta*(Ld-xl+d))*d*beta*cos(beta*Ld)^2-2*sinh(beta*Ld)*cos(beta*(-xl+d))*cosh(beta*(Ld-xl+d))*d*beta*cosh(beta*Ld)^2+2*sin(beta*Ld)*cosh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*d*beta*cos(beta*Ld)^2+2*sin(beta*Ld)*cosh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*d*beta*cosh(beta*Ld)^2-d^2*beta^2*sinh(beta*Ld)*cosh(beta*(Ld-xl+d))*sin(beta*(-xl+d))*cos(beta*Ld)^2-d^2*beta^2*sinh(beta*Ld)*sinh(beta*(Ld-xl+d))*cos(beta*(-xl+d))*cos(beta*Ld)^2-d^2*beta^2*sin(beta*Ld)*sinh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*cos(beta*Ld)^2-d^2*beta^2*sin(beta*Ld)*cosh(beta*(-xl+d))*sin(beta*(Ld-xl+d))*cos(beta*Ld)^2-d^2*beta^2*sinh(beta*Ld)*cosh(beta*(Ld-xl+d))*sin(beta*(-xl+d))*cosh(beta*Ld)^2-d^2*beta^2*sinh(beta*Ld)*sinh(beta*(Ld-xl+d))*cos(beta*(-xl+d))*cosh(beta*Ld)^2-d^2*beta^2*sin(beta*Ld)*sinh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*cosh(beta*Ld)^2-d^2*beta^2*sin(beta*Ld)*cosh(beta*(-xl+d))*sin(beta*(Ld-xl+d))*cosh(beta*Ld)^2-4*sin(beta*Ld)*cosh(beta*(-xl+d))*cos(beta*(Ld-xl+d))*d*beta+2*d^2*beta^2*sin(beta*Ld)*sinh(beta*(-xl+d))*cos(beta*(Ld-xl+d))+2*d^2*beta^2*sin(beta*Ld)*cosh(beta*(-xl+d))*sin(beta*(Ld-xl+d))+4*sinh(beta*Ld)*cos(beta*(-xl+d))*cosh(beta*(Ld-xl+d))*d*beta+2*d^2*beta^2*sinh(beta*Ld)*cosh(beta*(Ld-xl+d))*sin(beta*(-xl+d))+2*d^2*beta^2*sinh(beta*Ld)*sinh(beta*(Ld-xl+d))*cos(beta*(-xl+d)))/(-4*d*beta*cosh(beta*Ld)^2+2*d*beta*cosh(beta*Ld)^2*cos(beta*Ld)^2+4*d*beta-4*d*beta*cos(beta*Ld)^2+sin(beta*Ld)*cos(beta*Ld)*cosh(beta*Ld)^2-2*sin(beta*Ld)*cos(beta*Ld)-2*sinh(beta*Ld)*cosh(beta*Ld)+sinh(beta*Ld)*cosh(beta*Ld)*cos(beta*Ld)^2+d*beta*cosh(beta*Ld)^4+sinh(beta*Ld)*cosh(beta*Ld)^3+d*beta*cos(beta*Ld)^4+sin(beta*Ld)*cos(beta*Ld)^3);

        elseif 0<= xl <= d
            yt = -1/24*(-3*xl^2*beta^2*cosh(beta*Ld)^2+2*xl^3*beta^4*d*cosh(beta*Ld)^2-3*xl^2*beta^4*d^2*cosh(beta*Ld)^2+6*d^2*beta^2*cosh(beta*Ld)^2+3*cosh(beta*Ld)^2+d^4*beta^4*cosh(beta*Ld)^2+2*xl^3*beta^3*sinh(beta*Ld)*cosh(beta*Ld)+6*beta*d*sinh(beta*Ld)*cosh(beta*Ld)-6*xl^2*beta^3*d*cosh(beta*Ld)*sinh(beta*Ld)+4*d^3*beta^3*sinh(beta*Ld)*cosh(beta*Ld)-2*d^4*beta^4-4*xl^3*beta^4*d+2*xl^3*beta^3*sin(beta*Ld)*cos(beta*Ld)+6*xl^2*beta^4*d^2-6*xl^2*beta^3*d*cos(beta*Ld)*sin(beta*Ld)+d^4*beta^4*cos(beta*Ld)^2+3*xl^2*beta^2*cos(beta*Ld)^2-6*d^2*beta^2*cos(beta*Ld)^2+4*d^3*beta^3*sin(beta*Ld)*cos(beta*Ld)+2*xl^3*beta^4*d*cos(beta*Ld)^2-3*xl^2*beta^4*d^2*cos(beta*Ld)^2+3*cos(beta*Ld)^2-6*beta*d*sin(beta*Ld)*cos(beta*Ld))*P0/beta^3/EI/(-2*d*beta+d*beta*cos(beta*Ld)^2+d*beta*cosh(beta*Ld)^2+sin(beta*Ld)*cos(beta*Ld)+sinh(beta*Ld)*cosh(beta*Ld));
            
        elseif -1 <= xl < 0
            print 'error, now only consider the positive side, get negative location'
                
        else
            print 'error'    
        end
        


    
        yhat(ij) = -yt;   
        
    end 

end