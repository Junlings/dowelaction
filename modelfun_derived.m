function yhat = modelfun_derived(b,X)
    global d L;
    %d=0.375;          % rebar diameter
    E=29000;          % rebar modulus
    I=pi*(d^4)/64;    % rebar second moment of inertia
    EI = E*I;       
    d1 = 1;             % half distance of hole
    dl = d1;
    
    beta =  b(1);
    [mX,nX] = size(X);
    yhat = zeros(mX,1);
    
    %L = 6;            % the half length of finite beam
    

    for ij = 1:mX
        P0 = X(ij,1);   % first column is load
        xl = X(ij,2);   % second column is displacement
        Vd = P0/2.0;         % finite length beam end shear load
        
        M = -Vd*dl;       % finite length beam end moment
        
        
        
        
        if xl > d1
         yt = -0.1e1 / (beta ^ 3) / EI * (-Vd * sinh((beta * L)) * cos((beta * (xl - 1)))...
             * cosh((beta * (L - xl + 1))) + Vd * sin((beta * L)) * cosh((beta * (xl - 1))) * cos((beta * (L - xl + 1)))...
             - M * beta * sinh((beta * L)) * cosh((beta * (L - xl + 1))) * sin((beta * (xl - 1))) + M * beta * sinh((beta * L))...
             * sinh((beta * (L - xl + 1))) * cos((beta * (xl - 1))) - M * beta * sin((beta * L)) * sinh((beta * (xl - 1)))...
             * cos((beta * (L - xl + 1))) + M * beta * sin((beta * L)) * cosh((beta * (xl - 1))) * sin((beta * (L - xl + 1)))) / (cosh((beta * L)) ^ 2 - 0.2e1 + cos((beta * L)) ^ 2) / 0.2e1;

        elseif 0<= xl <= d1
            yt = ((2 * beta ^ 3 * dl ^ 4 * Vd) - 0.3e1 * (xl ^ 2) * beta * Vd * sinh((beta * L))...
                * sin((beta * (dl - 1))) * cosh((beta * (L - dl + 1))) - 0.3e1 * (xl ^ 2) * beta * Vd * sinh((beta * L)) * cos((beta * (dl - 1))) * sinh((beta * (L - dl + 1)))...
                - 0.3e1 * (xl ^ 2) * beta * Vd * sin((beta * L)) * sinh((beta * (dl - 1))) * cos((beta * (L - dl + 1))) - 0.3e1 * (xl ^ 2) * beta * Vd * sin((beta * L))...
                * cosh((beta * (dl - 1))) * sin((beta * (L - dl + 1))) + 0.6e1 * (xl ^ 2) * (beta ^ 2) * M * sinh((beta * L)) * cosh((beta * (L - dl + 1)))...
                * cos((beta * (dl - 1))) + 0.6e1 * (xl ^ 2) * (beta ^ 2) * M * sin((beta * L)) * cosh((beta * (dl - 1))) * cos((beta * (L - dl + 1)))...
                - 0.6e1 * sinh((beta * L)) * (beta ^ 2) * (dl ^ 2) * M * cosh((beta * (L - dl + 1))) * cos((beta * (dl - 1)))...
                + 0.6e1 * dl * M * beta * sinh((beta * L)) * cosh((beta * (L - dl + 1))) * sin((beta * (dl - 1))) + 0.3e1 * sinh((beta * L))...
                * beta * (dl ^ 2) * Vd * cos((beta * (dl - 1))) * sinh((beta * (L - dl + 1))) + 0.3e1 * sinh((beta * L)) * beta * (dl ^ 2) * Vd * sin((beta * (dl - 1))) * cosh((beta * (L - dl + 1)))...
                - 0.6e1 * dl * M * beta * sinh((beta * L)) * sinh((beta * (L - dl + 1))) * cos((beta * (dl - 1))) - 0.6e1 * (beta ^ 2)...
                * (dl ^ 2) * M * sin((beta * L)) * cosh((beta * (dl - 1))) * cos((beta * (L - dl + 1))) - 0.6e1 * dl * M * beta * sin((beta * L))...
                * cosh((beta * (dl - 1))) * sin((beta * (L - dl + 1))) + 0.3e1 * beta * (dl ^ 2) * Vd * sin((beta * L)) * sinh((beta * (dl - 1)))...
                * cos((beta * (L - dl + 1))) + 0.6e1 * dl * M * beta * sin((beta * L)) * sinh((beta * (dl - 1))) * cos((beta * (L - dl + 1)))...
                + 0.3e1 * beta * (dl ^ 2) * Vd * sin((beta * L)) * cosh((beta * (dl - 1))) * sin((beta * (L - dl + 1))) + (4 * Vd * xl ^ 3 * dl * beta ^ 3)...
                + 0.6e1 * dl * Vd * sinh((beta * L)) * cos((beta * (dl - 1))) * cosh((beta * (L - dl + 1))) - 0.6e1 * dl * Vd * sin((beta * L))...
                * cosh((beta * (dl - 1))) * cos((beta * (L - dl + 1))) - (beta ^ 3) * (dl ^ 4) * Vd * cosh((beta * L)) ^ 2 - (beta ^ 3) * (dl ^ 4)...
                * Vd * cos((beta * L)) ^ 2 - 0.2e1 * Vd * (xl ^ 3) * dl * (beta ^ 3) * cosh((beta * L)) ^ 2 - 0.2e1 * Vd * (xl ^ 3) * dl * (beta ^ 3)...
                * cos((beta * L)) ^ 2 + 0.3e1 * (xl ^ 2) * (beta ^ 3) * (dl ^ 2) * Vd * cosh((beta * L)) ^ 2 + 0.3e1 * (xl ^ 2) * (beta ^ 3) * (dl ^ 2)...
                * Vd * cos((beta * L)) ^ 2 - (6 * xl ^ 2 * beta ^ 3 * dl ^ 2 * Vd)) / EI / dl / (beta ^ 3) / (cosh((beta * L)) ^ 2 - 0.2e1 + cos((beta * L)) ^ 2) / 0.12e2;
            
        elseif -1 <= xl < 0
            print 'error, now only consider the positive side, get negative location'
                
        else
            print 'error'    
        end
        


    
        yhat(ij) = yt;   
        
    end 

end