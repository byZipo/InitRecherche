function readSubject

file = importdata('C:\Users\Thibault\Documents\InitRecherche\subject_3\S3_run1.mat')
info = file.info;

info.Label
C1 = info.Label(12);
C3 = info.Label(13);
C4 = info.Label(17);
C6 = info.Label(18);

startTrials = info.EVENT.POS(info.EVENT.TYP==768); %les positions (dans le signal) des débuts de trial
leftHand = info.EVENT.POS(info.EVENT.TYP==1089); %les positions du mouvement main gauche
rightHand = info.EVENT.POS(info.EVENT.TYP==1090); %les positions du mouvement de main droite
bothHands = info.EVENT.POS(info.EVENT.TYP==1104); %les positions du mouvement des deux mains
rest = info.EVENT.POS(info.EVENT.TYP==1108); %les positions de repos


gauche = length(leftHand);
droite = length(rightHand);
both = length(bothHands);
repos = length(rest);

totalActions = gauche + droite + both + repos
nbTrials = length(startTrials)

% nbTrials = totalActions : logique car un trial = une action
% exemple : premier trial à l'indice 7681, et c'est un mouvement both hands

% file.signal : 
% premiere dimsension les données du signal
% deuxième dimension l'electrode (26 au total)
% pour avoir les resultats de toutes les electrodes (:,:)
% pour avoir les resultats d'une electrode (ex : la premiere) (:,1)


%plot(signal)
% filtrage (Butterworth) du signal



% (premier trial compris entre 7681:10753)
%filteredSignal = filteredSignal(1:end);
% affichage du signal filtré 
%plot(filteredSignal);
% Recupération des signaux : 18 = C6, 17 = C4, 13 = C3, 12 = C1
signal_dixhuit = file.signal(:,18);
signal_dixsept = file.signal(:,17);
signal_treize = file.signal(:,13);
signal_douze = file.signal(:,12);



fs = 256;
order = 5;
range = [7,25]; % filtrage entre 8 et 30 Hz
[B,A] = butter(order,[range(1,1)*(2/fs),range(1,2)*(2/fs)]);




filteredSignal18 = filter(B,A,signal_dixhuit);
filteredSignal17 = filter(B,A,signal_dixsept);
filteredSignal13 = filter(B,A,signal_treize);
filteredSignal12 = filter(B,A,signal_douze);



% 1104 deux mains 1108 repos 1089 main gauche 1090 main droite
allBothHandsPosition = info.EVENT.POS(info.EVENT.TYP==1104);
allRestPosition = info.EVENT.POS(info.EVENT.TYP==1108);
allLeftHandPosition = info.EVENT.POS(info.EVENT.TYP==1089);
allRightHandPosition = info.EVENT.POS(info.EVENT.TYP==1090);


plot(signal_treize(info.EVENT.POS(info.EVENT.TYP==1090):info.EVENT.POS(info.EVENT.TYP==1090)+3072));
title('Signal brut pour un trial main droite')
set(gca,'XTick',[0 512 1024 1536 2048 2560 3072] );
set(gca,'XTickLabel',[0 2 4 6 8 10 12] ); 
xlabel('temps en secondes')
ylabel('différence de potentiel')
figure;

% on eleve les 250 premiers points qui presentent un pic trop important
%filteredSignal18 = filteredSignal18(250:end);
%filteredSignal17 = filteredSignal17(250:end);
%filteredSignal13 = filteredSignal13(250:end);
%filteredSignal12 = filteredSignal12(250:end);


BL13 = filteredSignal13(1:512);
BL17 = filteredSignal17(1:512);


%scatter(filteredSignal8, filteredSignal12);


%figure;
%plot(filteredSignal13(1:3072));
%figure
% Main droite


for f = 1:length(allRightHandPosition)

    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allRightHandPosition(f)+3072-1;
    
    filteredSignal_dixhuit(f,:) = filteredSignal18(allRightHandPosition(f)-512:fin);
    filteredSignal_dixsept(f,:) = filteredSignal17(allRightHandPosition(f)-512:fin);
    filteredSignal_treize(f,:) = filteredSignal13(allRightHandPosition(f)-512:fin);
    filteredSignal_douze(f,:) = filteredSignal12(allRightHandPosition(f)-512:fin);
    
    bl13rh(f,:) = filteredSignal13(allRightHandPosition(f)-1024:allRightHandPosition(f)-512);
    bl17rh(f,:) = filteredSignal17(allRightHandPosition(f)-1024:allRightHandPosition(f)-512);

 
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
end
   
 
% Main gauche
for g = 1:length(allLeftHandPosition)
    
    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allLeftHandPosition(g)+3072-1;
    
    filteredSignal_dixhuit(g+20,:) = filteredSignal18(allLeftHandPosition(g)-512:fin);
    filteredSignal_dixsept(g+20,:) = filteredSignal17(allLeftHandPosition(g)-512:fin);
    filteredSignal_treize(g+20,:) = filteredSignal13(allLeftHandPosition(g)-512:fin);
    filteredSignal_douze(g+20,:) = filteredSignal12(allLeftHandPosition(g)-512:fin);
    
    bl13lh(g,:) = filteredSignal13(allLeftHandPosition(g)-1024:allLeftHandPosition(g)-512);
    bl17lh(g,:) = filteredSignal17(allLeftHandPosition(g)-1024:allLeftHandPosition(g)-512);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
end

% Deux mains
for h = 1:length(allBothHandsPosition)
    
    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allBothHandsPosition(h)+3072-1;
    
    filteredSignal_dixhuit(h+40,:) = filteredSignal18(allBothHandsPosition(h)-512:fin);
    filteredSignal_dixsept(h+40,:) = filteredSignal17(allBothHandsPosition(h)-512:fin);
    filteredSignal_treize(h+40,:) = filteredSignal13(allBothHandsPosition(h)-512:fin);
    filteredSignal_douze(h+40,:) = filteredSignal12(allBothHandsPosition(h)-512:fin);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
   
    bl13bh(h,:) = filteredSignal13(allBothHandsPosition(h)-1024:allBothHandsPosition(h)-512);
    bl17bh(h,:) = filteredSignal17(allBothHandsPosition(h)-1024:allBothHandsPosition(h)-512);
end

% Repos
for k = 1:length(allRestPosition)
    
    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allRestPosition(k)+3072-1;
    
    filteredSignal_dixhuit(k+60,:) = filteredSignal18(allRestPosition(k)-512:fin);
    filteredSignal_dixsept(k+60,:) = filteredSignal17(allRestPosition(k)-512:fin);
    filteredSignal_treize(k+60,:) = filteredSignal13(allRestPosition(k)-512:fin);
    filteredSignal_douze(k+60,:) = filteredSignal12(allRestPosition(k)-512:fin);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),fil(teredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
   
   bl13r(k,:) = filteredSignal13(allRestPosition(k)-1024:allRestPosition(k)-512);
   bl17r(k,:) = filteredSignal17(allRestPosition(k)-1024:allRestPosition(k)-512);
   
end



%COV_SameSideRight = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:))
%COV_OppositeSideRight = cov(filteredSignal_dixsept(f,:),filteredSignal_treize(f,:))


% On trace les points
%BL13 = mean(filteredSignal_treize(1,1:512))^2;
%BL17 = mean(filteredSignal_dixsept(1,1:512))^2;
plot(filteredSignal_treize(1,:))
title('Signal filtré main droite (1er trial)')
set(gca,'XTick',[0 512 1024 1536 2048 2560 3072 3584] );
set(gca,'XTickLabel',[0 2 4 6 8 10 12 14] ); 
xlabel('temps en secondes')
ylabel('différence de potentiel')
figure

% mise au carré du signal
for i=1:3584
    for j=1:80
     filteredSignal_treize(j,i)=filteredSignal_treize(j,i)^2;
     filteredSignal_dixsept(j,i)=filteredSignal_dixsept(j,i)^2;
    end
end

plot(filteredSignal_treize(1,:))
title('Signal au carré main droite (1er trial)')
set(gca,'XTick',[0 512 1024 1536 2048 2560 3072 3584] );
set(gca,'XTickLabel',[0 2 4 6 8 10 12 14] ); 
xlabel('temps en secondes')
ylabel('différence de potentiel')
figure
% moyenne de tous les trials
for i=1:3584
     tmpRH13(i) = mean(filteredSignal_treize(1:20,i));
     tmpLH13(i) = mean(filteredSignal_treize(21:40,i));
     tmpRH17(i) = mean(filteredSignal_dixsept(1:20,i));
     tmpLH17(i) = mean(filteredSignal_dixsept(21:40,i));
     tmpBH13(i) = mean(filteredSignal_treize(41:60,i));
     tmpR13(i) = mean(filteredSignal_treize(61:80,i));
     tmpBH17(i) = mean(filteredSignal_dixsept(41:60,i));
     tmpR17(i) = mean(filteredSignal_dixsept(61:80,i));
     

end

plot(tmpRH13)
title('Moyenne des trials main droite')
set(gca,'XTick',[0 512 1024 1536 2048 2560 3072 3584] );
set(gca,'XTickLabel',[0 2 4 6 8 10 12 14] ); 
xlabel('temps en secondes')
ylabel('différence de potentiel')
figure


%bl = filteredSignal18(1:512);

%BL13 = filteredSignal_treize(1,1:512);
%BL17 = filteredSignal_dixsept(1,1:512);



%BL13 = BL13.^2;
%BL17 = BL17.^2;

%tmpRH13 = tmpRH13';
%tmpLH13 = tmpLH13';
%tmpRH17 = tmpRH17';
%tmpLH17 = tmpLH17';

%BL = mean(BL)
%BL13 = BL13;
%BL17 = BL17;

%BL13 = mean(BL13);
%BL17 = mean(BL17);

j = 1;
for i=0:32:3072
 %erd_ers(i:i+512) = (test(i:i+512)-bl(1:512))/bl(1:512);
 %erd_ers(i) = (test(1+i:512+i)-bl)/bl;
     BL13RH = mean(bl13rh(j,:).^2);
     BL17RH = mean(bl17rh(j,:).^2);
     BL13LH = mean(bl13rh(j,:).^2);
     BL17LH = mean(bl17rh(j,:).^2);
     
     BL13BH = mean(bl13bh(j,:).^2);
     BL17BH = mean(bl17bh(j,:).^2);
     BL13R = mean(bl13rh(j,:).^2);
     BL17R = mean(bl17rh(j,:).^2);
     
     erd_ersRH13(i+1) = ((mean(tmpRH13(i+1:i+512))-BL13RH)/BL13RH)*100;
     erd_ersLH13(i+1) = ((mean(tmpLH13(i+1:i+512))-BL13LH)/BL13LH)*100;
     
     erd_ersRH17(i+1) = ((mean(tmpRH17(i+1:i+512))-BL17RH)/BL17RH)*100;
     erd_ersLH17(i+1) = ((mean(tmpLH17(i+1:i+512))-BL17LH)/BL17LH)*100;
     
     erd_ersBH13(i+1) = ((mean(tmpBH13(i+1:i+512))-BL13BH)/BL13BH)*100;
     erd_ersR13(i+1) = ((mean(tmpR13(i+1:i+512))-BL13R)/BL13R)*100;
     
     erd_ersBH17(i+1) = ((mean(tmpBH17(i+1:i+512))-BL17BH)/BL17BH)*100;
     erd_ersR17(i+1) = ((mean(tmpR17(i+1:i+512))-BL17R)/BL17R)*100;
    
    
    
 %erd_ers(i+1) = mean(tmp);
end

cmpt = 1;
for i=1:32:3072
    
       erd_ersRH13FINAL(cmpt) = erd_ersRH13(i);
       erd_ersLH13FINAL(cmpt) = erd_ersLH13(i);
       erd_ersRH17FINAL(cmpt) = erd_ersRH17(i);
       erd_ersLH17FINAL(cmpt) = erd_ersLH17(i);
       erd_ersBH13FINAL(cmpt) = erd_ersBH13(i);
       erd_ersR13FINAL(cmpt) = erd_ersR13(i);
       erd_ersBH17FINAL(cmpt) = erd_ersBH17(i);
       erd_ersR17FINAL(cmpt) = erd_ersR17(i);
       cmpt = cmpt+1;
       
end

plot(erd_ersLH13FINAL,'LineWidth',3)
hold on
plot(erd_ersRH13FINAL,'LineWidth',3)
hold on
plot(erd_ersBH13FINAL,'LineWidth',3)
hold on
plot(erd_ersR13FINAL,'LineWidth',3)
title('ERS/ERS% sur electrode C3')
legend('Main droite','Deux mains','Repos')
axis([-inf,inf,-50,50])
set(gca,'XTick',[0 8 16 24 32 40 48 56 64 72 80 88 96] );
set(gca,'XTickLabel',[-2 0 1 2 3 4 5 6 7 8 9 10 12] ); 
xlabel('temps en secondes')
ylabel('ERD/ERS%')
figure


%scatter(erd_ersLH13(1:512),erd_ersLH17(1:512))
%hold on
%scatter(erd_ersRH13(1:512),erd_ersRH17(1:512))
%figure
 figure;
 scatter(erd_ersRH13FINAL, erd_ersRH17FINAL, 'b', 'filled')
 hold on
 scatter(erd_ersLH13FINAL, erd_ersLH17FINAL, 'r', 'filled')
 hold on
 scatter(erd_ersBH13FINAL, erd_ersBH17FINAL, 'g', 'filled')
 hold on
 scatter(erd_ersR13FINAL, erd_ersR17FINAL, 'y', 'filled')
 legend('Main droite','Main gauche','Deux mains', 'Repos')
title('ERD/ERS% sur electrode c4 en fonction de ERD/ERS% sur electrode c3')
xlabel('C3')
ylabel('C4')




% Calculs de moyennes des trials
for i = 1 : 3072
 
   meanAllPatientsRH13(i) = mean(filteredSignal_treize(1:20,i)); 
   meanAllPatientsLH13(i) = mean(filteredSignal_treize(21:40,i)); 
   meanAllPatientsBH13(i) = mean(filteredSignal_treize(41:60,i)); 
   meanAllPatientsR13(i) = mean(filteredSignal_treize(61:80,i)); 
   
   meanAllPatients13(i) = mean(filteredSignal_treize(:,i)); 
   
   meanAllPatientsRH17(i) = mean(filteredSignal_dixsept(1:20,i)); 
   meanAllPatientsLH17(i) = mean(filteredSignal_dixsept(21:40,i)); 
   meanAllPatientsBH17(i) = mean(filteredSignal_dixsept(41:60,i)); 
   meanAllPatientsR17(i) = mean(filteredSignal_dixsept(61:80,i)); 
   
   meanAllPatients17(i) = mean(filteredSignal_dixsept(:,i)); 
   
end


% BaseLine
BL13 =  mean(meanAllPatients13(1:512))^2;
BL17 =  mean(meanAllPatients17(1:512))^2;

%Formule pour calculer ERD/ERS
for i = 1 : 2560
    
    %((mean(filteredSignal_treize(1,i).^2)-BL13)/BL13)*100
    
   ERDERS_13RH(i) = ((mean(meanAllPatientsRH13(i:511+i).^2)-BL13)/BL13);
   ERDERS_17RH(i) = ((mean(meanAllPatientsRH17(i:511+i).^2)-BL17)/BL17);
   
   ERDERS_13LH(i) = ((mean(meanAllPatientsLH13(i:511+i).^2)-BL13)/BL13);
   ERDERS_17LH(i) = ((mean(meanAllPatientsLH17(i:511+i).^2)-BL17)/BL17);
   
   ERDERS_13BH(i) = ((mean(meanAllPatientsBH13(i:511+i).^2)-BL13)/BL13);
   ERDERS_17BH(i) = ((mean(meanAllPatientsBH17(i:511+i).^2)-BL17)/BL17);
   
   ERDERS_13R(i) = ((mean(meanAllPatientsR13(i:511+i).^2)-BL13)/BL13);
   ERDERS_17R(i) = ((mean(meanAllPatientsR17(i:511+i).^2)-BL17)/BL17);
   
end


 %Dessin des ERD/ERS en fonction du temps
 figure
 plot(ERDERS_13LH)
 hold on
 plot(ERDERS_13RH)
 title('ERD/ERS en fonction du temps (C3)')
 xlabel('temps')
 ylabel('ERD/ERS')
 
 %Decoupe du signal pour ne conserver que les deux premières secondes
 ERDERS_13RH = ERDERS_13RH(1:512);
 ERDERS_17RH = ERDERS_17RH(1:512);
 
 ERDERS_13LH = ERDERS_13LH(1:512);
 ERDERS_17LH = ERDERS_17LH(1:512);
 
 ERDERS_13BH = ERDERS_13BH(1:512);
 ERDERS_17BH = ERDERS_17BH(1:512);
 
 ERDERS_13R = ERDERS_13R(1:512);
 ERDERS_17R = ERDERS_17R(1:512);
 
 cov13 = cov(ERDERS_13RH,ERDERS_13LH);
 cov17 = cov(ERDERS_17RH,ERDERS_17LH);
 
 
 
 %Dessin du nuage de points des 4 classes entre les electrodes C3 et C4
 figure;
 scatter(ERDERS_13RH, ERDERS_17RH, 'b')
 hold on
 scatter(ERDERS_13LH, ERDERS_17LH, 'r')
 hold on
 scatter(ERDERS_13BH, ERDERS_17BH, 'g')
 hold on
 scatter(ERDERS_13R, ERDERS_17R, 'y')
 
title('4 Classes:  b= main droite, r= main gauche, g= deux mains, y= repos')
xlabel('C3')
ylabel('C4')

 
 cov1 = cov(filteredSignal_dixsept(15,:),filteredSignal_treize(15,:));
 cov2 = cov(filteredSignal_dixsept(75,:),filteredSignal_treize(75,:));
 
 %figure;
 %plot(filteredSignal_dixsept(35,:))
% hold on
 %plot(filteredSignal_dixsept(36,:))
  
 %figure;
% scatter(filteredSignal_dixsept(15,:), filteredSignal_treize(15,:))
 %hold on
 %scatter(filteredSignal_dixsept(35,:), filteredSignal_treize(15,:))
 
 
 
%{ 
  
fDroite = figure;
movegui(fDroite,'southwest');
% pour le premier parametre du signal : 1->20 = droite, 20->40 = gauche,
% 40->60 = both, 60->80=rest
% exemple si je mets 15 j'aurai le 15eme trial main droite, si je mets 35
% j'aurai le 15eme mouvement main gauche
s1= scatter(filteredSignal_treize(15,:),filteredSignal_dixsept(15,:),15,'w','filled');
s1.MarkerEdgeColor  = 'b';
hold on
s2 = scatter(filteredSignal_treize(35,:),filteredSignal_dixsept(35,:),15,'r','filled');
s2.MarkerEdgeColor  = 'b';
title('Main Droite')
xlabel('En blanc entre C6 et C4, en couleur en C4 et C3')

fGauche = figure;
movegui(fGauche,'southeast');

s3 = scatter(filteredSignal_dixhuit(35,:),filteredSignal_dixsept(35,:),15,'w','filled');
s3.MarkerEdgeColor  = 'b';

hold on
s4 = scatter(filteredSignal_dixsept(35,:),filteredSignal_treize(35,:),15,'g','filled');
s4.MarkerEdgeColor  = 'b';
title('Main Gauche')
xlabel('En blanc entre C6 et C4, en couleur en C4 et C3')

fBoth = figure;
movegui(fBoth,'northwest');

s5 = scatter(filteredSignal_dixhuit(55,:),filteredSignal_dixsept(55,:),15,'w','filled');
s5.MarkerEdgeColor  = 'b';

hold on
s6 = scatter(filteredSignal_dixsept(55,:),filteredSignal_treize(55,:),15,'y','filled');
s6.MarkerEdgeColor  = 'b';
title('Deux mains')
xlabel('En blanc entre C6 et C4, en couleur en C1 et C3')

fRest = figure;
movegui(fRest,'northeast');

s7 = scatter(filteredSignal_treize(75,:),filteredSignal_dixsept(75,:),15,'w','filled');
s7.MarkerEdgeColor  = 'b';

hold on
s8 = scatter(filteredSignal_treize(75,:),filteredSignal_dixsept(75,:),15,'k','filled');
s8.MarkerEdgeColor  = 'b';
title('Repos')
xlabel('En blanc entre C6 et C4, en couleur en C4 et C3')

%D = var(filteredSignal_huit);
%C = var(filteredSignal_douze);
%scatter(D,C)
% nombre de points 
%tailleSignal = length(filteredSignal)

%affichage moyenne du signal
%average = mean2(filteredSignal)

%affichage variance du signal
%variance = var(filteredSignal)

%somme des points du signal
%sommeDesPoints = sum(filteredSignal)
 
 
 %}
end


