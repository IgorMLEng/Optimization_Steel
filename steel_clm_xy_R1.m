
%Igor M. Lima, Cleiton C. Pereira, Tiago S. Oliveira
%Dept. of Civil Engineering, IESB University Center
%SGAS Quadra 613/614 Asa Sul, 70200-730, Brasilia, Brazi
%i.g.moura@live.com, tiago.oliveira@iesb.br
%Brasilia, Brazil, June 29, 2021



function obj = steel_clm_xy_R1(xt)

%Dimensionando um pilar metálico
Ncx = 2326.42; %kN
Ncy = 2326.42; %kN
fy = 34.5; %kN/cm²
E  = 20000; %kN/cm²
Lex = 609.6; %cm
Ley = 426.72; %cm
bf = xt(1); %mm
tf = xt(2); %mm
tw = xt(3); %mm
h = xt(4); %mm

Ag = (2*(bf*tf)+(h*tw))/100;

Ix = ((((bf*((h+(2*tf))^3))/12)-(2*((((bf-tw)/2)*(h^3))/12)))/10000);

Iy = ((((h*(tw^3))/12)+(2*((tf*(bf^3))/12)))/10000);

rx = (Ix/Ag)^(1/2);

ry = (Iy/Ag)^(1/2);

fyd = fy/1.1;

% Eixo x
Lambdax = Lex/rx;

 if (Lambdax <= 200)
     
     Lambda0x = ((Lex/rx)*((fy/((pi^2)*E))^(1/2)));
     
     if(Lambda0x <= 1.5)
         Xx = ((0.688)^(Lambda0x^2));
     else(Lambda0x > 1.5);
         Xx = (0.877/(Lambda0x^2));
     end
     
Fcdx = Xx*fyd;

Ncdx = Ncx/Ag;

if(Fcdx >= Ncdx);
    
        if(h/tw <= 1.49*((E/fy)^1/2))
            objx = abs((Ncdx/Fcdx)-1);
        else(h/tw > 1.49*((E/fy)^1/2));
            
            hef = ((1.92*(tw/10)*((E/fy)^(1/2)))*(1-(((0.34*(tw/10))/(h/10))*((E/fy)^(1/2)))));
            
            Aef = (Ag-(((h/10)-(hef))*(tw/10)));
            
            Qa = (Aef/Ag);
            
            if((bf/(tf*2)) <= 0.56*((E/fy)^1/2))
                
                Qs = 1;
                
            else((bf/(tf*2)) > 0.56*((E/fy)^1/2));
                
                if((0.56*((E/fy)^1/2)) < (bf/(tf*2)) <= (1.03*((E/fy)^1/2)))
                    
                    Qs = (1.415-(0.74*(bf/(tf*2))*((E/fy)^1/2)));
                    
                else((bf/(tf*2)) > (1.03*((E/fy)^1/2)));
                    
                    Qs = ((0.69*E)/(fy*((bf/(tf*2))^2)));
                    
                end
                
            end
            
            Q = Qa*Qs;
            
            Lambda0x = ((Lex/rx)*(((Q*fy)/((pi^2)*E))^(1/2)));
            
            if(Lambda0x <= 1.5)
                
                Xx = ((0.688)^(Lambda0x^2));
                
            else(Lambda0x > 1.5);
                
                Xx = (0.877/(Lambda0x^2));
            end
            
            NcRdx = ((Xx*Q*Ag*fy)/1.1);
            
            if(NcRdx >= Ncx)
                objx = abs((Ncx/NcRdx)-1);
            else(NcRdx < Ncx);
                objx = 10;
            end
                
        end
    
else(Fcdx < Ncdx);
    objx = 10;
    
end

else(Lambdax > 200);
     objx = 10;
 end
 
 % Eixo y
 Lambday = Ley/ry;

 if (Lambday <= 200)
     
     Lambda0y = ((Ley/ry)*((fy/((pi^2)*E))^(1/2)));
     
     if(Lambda0y <= 1.5)
         Xy = ((0.688)^(Lambda0y^2));
     else(Lambda0x > 1.5);
         Xy = (0.877/(Lambda0y^2));
     end
     
Fcdy = Xy*fyd;

Ncdy = Ncy/Ag;

if(Fcdy >= Ncdy)
    
        if(h/tw <= 1.49*((E/fy)^1/2))
            objy = abs((Ncdy/Fcdy)-1);
        else(h/tw > 1.49*((E/fy)^1/2));
            
            hef = ((1.92*(tw/10)*((E/fy)^(1/2)))*(1-(((0.34*(tw/10))/(h/10))*((E/fy)^(1/2)))));
            
            Aef = (Ag-(((h/10)-(hef))*(tw/10)));
            
            Qa = (Aef/Ag);
            
            if((bf/(tf*2)) <= 0.56*((E/fy)^1/2))
                
                Qs = 1;
                
            else((bf/(tf*2)) > 0.56*((E/fy)^1/2));
                
                if((0.56*((E/fy)^1/2)) < (bf/(tf*2)) <= (1.03*((E/fy)^1/2)))
                    
                    Qs = (1.415-(0.74*(bf/(tf*2))*((E/fy)^1/2)));
                    
                else((bf/(tf*2)) > (1.03*((E/fy)^1/2)));
                    
                    Qs = ((0.69*E)/(fy*((bf/(tf*2))^2)));
                    
                end
                
            end
            
            Q = Qa*Qs;
            
            Lambda0y = ((Ley/ry)*(((Q*fy)/((pi^2)*E))^(1/2)));
            
            if(Lambda0y <= 1.5)
                
                Xy = ((0.688)^(Lambda0y^2));
                
            else(Lambda0y > 1.5);
                
                Xy = (0.877/(Lambda0y^2));
            end
            
            NcRdy = ((Xy*Q*Ag*fy)/1.1);
            
            if(NcRdy >= Ncy)
                objy = abs((Ncy/NcRdy)-1);
            else(NcRdy < Ncy);
                objy = 10;
            end
                
        end
    
else(Fcdy < Ncdy);
    objy = 10;
    
end

else(Lambday > 200);
     objy = 10;
 end
 
 
 obj = min(objx,objy);
 
 %  T = readtable('Tabela de Bitolas.xlsx')
 T = readtable('Tabela de Bitolasx.csv');
 
 a1 =[152 102 153 154 100 102 102 133 134 165 166 203 204 207 205 206 209 101 102 102 102 146 147 148 256 254 255 260 256 257 259 101 101 102 102 165 166 167 306 308 305 306 310 307 312 127 128 171 171 172 203 204 205 254 255 256 257 140 140 177 178 179 180 181 152 153 154 190 191 192 193 194 165 207 166 209 166 209 210 211 228 228 229 230 324 325];%dummy data
 n = bf;
 [val,idx1]=min(abs(a1-n));
 bf = a1(idx1);

Perfil1 = T.Perfil(T.bf == a1(idx1));
 
 a2 =[4.9 7.1 6.6 10.3 9.3 11.6 5.2 6.5 8.0 8.4 10.2 10.2 11.8 11.0 12.6 11.3 14.2 17.4 20.6 5.3 6.9 8.4 10.0 9.1 11.2 13.0 10.7 14.2 15.6 14.4 17.3 19.6 22.1 5.7 6.7 8.9 10.8 9.7 11.2 13.2 11.0 13.1 15.4 17.0 15.5 18.7 17.4 8.5 10.7 9.8 11.6 13.1 13.5 15.1 16.8 16.4 18.3 19.9 21.7 8.8 11.2 10.9 12.8 14.4 16.0 18.2 10.8 13.3 15.4 14.5 16.0 17.7 19.0 20.6 11.4 10.9 13.6 13.3 16.5 15.6 17.4 18.8 14.9 17.3 19.6 22.2 19.0 21.6];%dummy data
 n = tf;
 [val,idx2]=min(abs(a2-n));
 tf = a2(idx2);
 
Perfil2 = T.Perfil(T.tf == a2(idx2));

 a3 =[4.3 5.8 5.8 6.6 6.6 8.1 4.3 5.8 6.2 5.8 6.4 6.2 7.2 7.2 7.9 11.3 9.1 10.2 13.0 4.8 5.8 6.1 6.4 6.1 6.6 7.6 10.5 8.6 9.4 14.4 10.7 11.9 13.5 5.1 5.6 6.0 6.6 5.8 6.6 7.6 11.0 13.1 9.9 10.9 15.4 11.9 17.4 5.8 6.5 6.9 7.2 7.9 7.7 8.6 9.4 9.5 10.5 11.4 13.0 6.4 7.0 7.5 7.7 8.8 9.7 10.9 7.6 8.0 9.1 9.0 9.9 10.5 11.4 12.6 8.9 9.0 9.7 9.5 10.3 10.2 10.9 11.6 10.5 11.2 11.9 13.1 12.7 14.0];%dummy data
 n=tw;
 [val,idx3]=min(abs(a3-n));
 tw = a3(idx3);
 
Perfil3 = T.Perfil(T.tw == a3(idx3));
 
a4 =[138 139 139 139 138 139 190 190 190 190 190 181 181 181 181 181 182 181 181 240 240 240 240 240 240 240 225 225 225 225 225 225 225 292 292 291 291 291 291 291 277 277 277 277 277 277 277 332 332 332 332 332 320 320 320 320 320 320 320 381381 381 381 381 381 381 428 428 428 428 428 428 428 428 502 502 502 501 502 502 502 501 573 573 573 573 573 573];%dummy data
 n=h;
 [val,idx4]=min(abs(a4-n));
 h = a4(idx4);
 
Perfil4 = T.Perfil(T.h == a4(idx4));

idx = min([idx1,idx2,idx3,idx4]);

if idx == idx1
    Perfil = string(Perfil1(1,1));
end
if idx == idx2
    Perfil = string(Perfil2(1,1));
end
if idx == idx3
    Perfil = string(Perfil3(1,1));
end
if idx == idx4
    Perfil = string(Perfil4(1,1));
end

Tlist = table2cell(T) ;
indf = find(contains(Tlist(:,1),Perfil));

Tarray = table2array(T(:,2:5));

bf = Tarray(indf,1); %mm
tf = Tarray(indf,3); %mm
tw = Tarray(indf,2); %mm
h = Tarray(indf,4); %mm

Ag = (2*(bf*tf)+(h*tw))/100;

Ix = ((((bf*((h+(2*tf))^3))/12)-(2*((((bf-tw)/2)*(h^3))/12)))/10000);

Iy = ((((h*(tw^3))/12)+(2*((tf*(bf^3))/12)))/10000);

rx = (Ix/Ag)^(1/2);

ry = (Iy/Ag)^(1/2);

fyd = fy/1.1;

% Eixo x
Lambdax = Lex/rx;

 if (Lambdax <= 200)
     
     Lambda0x = ((Lex/rx)*((fy/((pi^2)*E))^(1/2)));
     
     if(Lambda0x <= 1.5)
         Xx = ((0.688)^(Lambda0x^2));
     else(Lambda0x > 1.5);
         Xx = (0.877/(Lambda0x^2));
     end
     
Fcdx = Xx*fyd;

Ncdx = Ncx/Ag;

if(Fcdx >= Ncdx);
    
        if(h/tw <= 1.49*((E/fy)^1/2))
            objx = abs((Ncdx/Fcdx)-1);
        else(h/tw > 1.49*((E/fy)^1/2));
            
            hef = ((1.92*(tw/10)*((E/fy)^(1/2)))*(1-(((0.34*(tw/10))/(h/10))*((E/fy)^(1/2)))));
            
            Aef = (Ag-(((h/10)-(hef))*(tw/10)));
            
            Qa = (Aef/Ag);
            
            if((bf/(tf*2)) <= 0.56*((E/fy)^1/2))
                
                Qs = 1;
                
            else((bf/(tf*2)) > 0.56*((E/fy)^1/2));
                
                if((0.56*((E/fy)^1/2)) < (bf/(tf*2)) <= (1.03*((E/fy)^1/2)))
                    
                    Qs = (1.415-(0.74*(bf/(tf*2))*((E/fy)^1/2)));
                    
                else((bf/(tf*2)) > (1.03*((E/fy)^1/2)));
                    
                    Qs = ((0.69*E)/(fy*((bf/(tf*2))^2)));
                    
                end
                
            end
            
            Q = Qa*Qs;
            
            Lambda0x = ((Lex/rx)*(((Q*fy)/((pi^2)*E))^(1/2)));
            
            if(Lambda0x <= 1.5)
                
                Xx = ((0.688)^(Lambda0x^2));
                
            else(Lambda0x > 1.5);
                
                Xx = (0.877/(Lambda0x^2));
            end
            
            NcRdx = ((Xx*Q*Ag*fy)/1.1);
            
            if(NcRdx >= Ncx)
                objx = abs((Ncx/NcRdx)-1);
            else(NcRdx < Ncx);
                objx = 10;
            end
                
        end
    
else(Fcdx < Ncdx);
    objx = 10;
    
end

else(Lambdax > 200);
     objx = 10;
 end
 
 % Eixo y
 Lambday = Ley/ry;

 if (Lambday <= 200)
     
     Lambda0y = ((Ley/ry)*((fy/((pi^2)*E))^(1/2)));
     
     if(Lambda0y <= 1.5)
         Xy = ((0.688)^(Lambda0y^2));
     else(Lambda0x > 1.5);
         Xy = (0.877/(Lambda0y^2));
     end
     
Fcdy = Xy*fyd;

Ncdy = Ncy/Ag;

if(Fcdy >= Ncdy);
    
        if(h/tw <= 1.49*((E/fy)^1/2))
            objy = abs((Ncdy/Fcdy)-1);
        else(h/tw > 1.49*((E/fy)^1/2));
            
            hef = ((1.92*(tw/10)*((E/fy)^(1/2)))*(1-(((0.34*(tw/10))/(h/10))*((E/fy)^(1/2)))));
            
            Aef = (Ag-(((h/10)-(hef))*(tw/10)));
            
            Qa = (Aef/Ag);
            
            if((bf/(tf*2)) <= 0.56*((E/fy)^1/2))
                
                Qs = 1;
                
            else((bf/(tf*2)) > 0.56*((E/fy)^1/2));
                
                if((0.56*((E/fy)^1/2)) < (bf/(tf*2)) <= (1.03*((E/fy)^1/2)))
                    
                    Qs = (1.415-(0.74*(bf/(tf*2))*((E/fy)^1/2)));
                    
                else((bf/(tf*2)) > (1.03*((E/fy)^1/2)));
                    
                    Qs = ((0.69*E)/(fy*((bf/(tf*2))^2)));
                    
                end
                
            end
            
            Q = Qa*Qs;
            
            Lambda0y = ((Ley/ry)*(((Q*fy)/((pi^2)*E))^(1/2)));
            
            if(Lambda0y <= 1.5)
                
                Xy = ((0.688)^(Lambda0y^2));
                
            else(Lambda0y > 1.5);
                
                Xy = (0.877/(Lambda0y^2));
            end
            
            NcRdy = ((Xy*Q*Ag*fy)/1.1);
            
            if(NcRdy >= Ncy)
                objy = abs((Ncy/NcRdy)-1);
            else(NcRdy < Ncy);
                objy = 10;
            end
                
        end
    
else(Fcdy < Ncdy);
    objy = 10;
    
end

else(Lambday > 200);
     objy = 10;
 end
 
 Perfil
 obj = min(objx,objy)

end
