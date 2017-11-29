clear;
close all;
[y,fs] = audioread('Grandma.mp3');
cR = y(:,1);
cL = y(:,2);

n = length(y);

t = linspace(0, n/fs, n);
target = y;

pN = 3;

nY = yParsed;
for cont = 1:length(nY)
    r = 100.*rand(1,1) + 1;
    if(r <= pN)
        nY(cont,1) = 0;
        nY(cont,2) = 0;
    end
end

noiseY = y;
for cont = 1:length(noiseY)
    r = 100.*rand(1,1) + 1;
    if(r <= pN)
        noiseY(cont,1) = 0;
        noiseY(cont,2) = 0;
    end
end

tln1 = 1:length(nY);
gnY = awgn(y,1,'measured');

net = feedforwardnet([10 10]);
net = configure(net,nY,yParsed);

ny1 = net(nY);

net = train(net,nY,yParsed);
ny2 = net(nY);
figure();
plot(tln1,yParsed(:,2),'o',tln1,ny1(:,2),'x',tln1,ny2(:,2),'*');

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
plot(tln1,nY);
xlabel('Segundos');
ylabel('Amplitud');
title("Señal con Ruido");


%filtro = ones(1,fs)/fs;
%filtrada = filter(filtro,1,y);

% player = audioplayer(noiseY,fs);
% player.stop;
% player.play;