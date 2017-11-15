[y,fs] = audioread('Grandma.mp3');
cR = y(:,1);
cL = y(:,2);

n = length(y);

t = linspace(0, n/fs, n);

pN = 30;

nY = y;
for cont = 1:n
    r = 100.*rand(1,1) + 1;
    if(r <= pN)
        nY(cont,1) = 0;
        nY(cont,2) = 0;
    end
end

gnY = awgn(y,1,'measured');

figure();

subplot(3,1,1);
plot(t,cR);
xlabel('Segundos');
ylabel('Amplitud');
title("Canal Derecho");

subplot(3,1,2);
plot(t,cL);
xlabel('Segundos');
ylabel('Amplitud');
title("Canal Izquierdo");

subplot(3,1,3);
plot(t,nY);
xlabel('Segundos');
ylabel('Amplitud');
title("Señal con Ruido Gaussiano");

%%sound(gnY,fs);