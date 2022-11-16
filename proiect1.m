clear all
load("product_12.mat");
plot(time,y,"g");hold on
n_id=floor(0.8*length(y))+1
yid = zeros(n_id,1);
for i = 1:n_id
    yid(i) = y(i);
end

yval = zeros(length(y)-n_id,1);
r=1;
for i =n_id:length(y)
    yval(r)=y(i);
    r=r+1;
end

for i = 1:n_id
    kid(i) = time(i);
end
a=1;
for i =n_id:length(time)
    kval(a) = time(i);
    a = a+1;
end
for m=1:7
    for i=1:length(kid)
        for j=1:m
            vect1(j)=cos((2*pi*j*kid(i))/12);
            vect2(j)=sin((2*pi*j*kid(i))/12);
        end
        l=1;
        p=1;
        vect(1)=1;
        vect(2)=kid(i);
        for k=3:2*m+2
            if (mod(k,2)==0)
                vect(k)=vect2(l);
                l=l+1;
            end
            if (mod(k,2)==1)
                vect(k)=vect1(p);
                p=p+1;
            end
        end

        phi1(i,1:2*m+2)=vect;
    end
    clear vect1 vect2 vect
    for i=1:length(kval)
        for j=1:m
            vect1(j)=cos((2*pi*j*kval(i))/12);
            vect2(j)=sin((2*pi*j*kval(i))/12);

        end

        l=1;
        p=1;
        vect(1)=1;
        vect(2)=kval(i);
        for k=3:2*m+2
            if (mod(k,2)==0)
                vect(k)=vect2(l);
                l=l+1;
            end
            if (mod(k,2)==1)
                vect(k)=vect1(p);
                p=p+1;
            end
        end

        phi2(i,1:2*m+2)=vect;
    end

    teta = phi1 \ yid

    yhatval = phi2*teta;
    yhatid = phi1*teta;
    if(m==4)
        plot(kid,yhatid,"r");
        hold on
        plot(kval,yhatval,"b");
        title('Grafic date de iesire initiale si aproximate')
        legend('y','yhatid','yhatval')
    end
    eval=yval-yhatval;
    eid=yid-yhatid;
    suma=0;
    for i=1:length(eval)
        suma=suma+eval(i)^2;
    end
    MSEval(m)=suma/length(eval)
    suma1=0;
    for i=1:length(eid)
        suma1=suma1+eid(i)^2;
    end
    MSEid(m)=suma1/length(eid)
end
[val,id]=min(MSEval);
figure
plot(MSEval)
hold on
plot(MSEid)
title('Grafic MSE pentru m de la 1-7')
legend('MSEval','MSEid')
mbun=id
