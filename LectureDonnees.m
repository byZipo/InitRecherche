function readSubject

file = importdata('C:\Users\Thibault\Documents\InitRecherche\subject_3\S3_run1.mat')
info = file.info;

info.Label
C1 = info.Label(12);
C3 = info.Label(13);
C4 = info.Label(17);
C6 = info.Label(18);

startTrials = info.EVENT.POS(info.EVENT.TYP==768); %les positions (dans le signal) des débuts de tial
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
range = [8,30]; % filtrage entre 8 et 30 Hz
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

% on eleve les 250 premiers points qui presentent un pic trop important
filteredSignal18 = filteredSignal18(250:end);
filteredSignal17 = filteredSignal17(250:end);
filteredSignal13 = filteredSignal13(250:end);
filteredSignal12 = filteredSignal12(250:end);
%scatter(filteredSignal8, filteredSignal12);

%plot(filteredSignal8);
%figure;
%plot(filteredSignal12);

% Main droite
for f = 1:length(allRightHandPosition)

    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allRightHandPosition(f)+3072-1;
    
    filteredSignal_dixhuit(f,:) = filteredSignal18(allRightHandPosition(f):fin);
    filteredSignal_dixsept(f,:) = filteredSignal17(allRightHandPosition(f):fin);
    filteredSignal_treize(f,:) = filteredSignal13(allRightHandPosition(f):fin);
    filteredSignal_douze(f,:) = filteredSignal12(allRightHandPosition(f):fin);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
end

% Main gauche
for g = 1:length(allLeftHandPosition)
    
    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allLeftHandPosition(g)+3072-1;
    
    filteredSignal_dixhuit(g+20,:) = filteredSignal18(allLeftHandPosition(g):fin);
    filteredSignal_dixsept(g+20,:) = filteredSignal17(allLeftHandPosition(g):fin);
    filteredSignal_treize(g+20,:) = filteredSignal13(allLeftHandPosition(g):fin);
    filteredSignal_douze(g+20,:) = filteredSignal12(allLeftHandPosition(g):fin);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
end

% Deux mains
for h = 1:length(allBothHandsPosition)
    
    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allBothHandsPosition(h)+3072-1;
    
    filteredSignal_dixhuit(h+40,:) = filteredSignal18(allBothHandsPosition(h):fin);
    filteredSignal_dixsept(h+40,:) = filteredSignal17(allBothHandsPosition(h):fin);
    filteredSignal_treize(h+40,:) = filteredSignal13(allBothHandsPosition(h):fin);
    filteredSignal_douze(h+40,:) = filteredSignal12(allBothHandsPosition(h):fin);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
end

% Repos
for i = 1:length(allRestPosition)
    
    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allRestPosition(i)+3072-1;
    
    filteredSignal_dixhuit(i+60,:) = filteredSignal18(allRestPosition(i):fin);
    filteredSignal_dixsept(i+60,:) = filteredSignal17(allRestPosition(i):fin);
    filteredSignal_treize(i+60,:) = filteredSignal13(allRestPosition(i):fin);
    filteredSignal_douze(i+60,:) = filteredSignal12(allRestPosition(i):fin);
    
   % covSameSide = cov(filteredSignal_dixhuit(f,:),fil(teredSignal_dixsept(f,:));
   % covOppositeSide = cov(filteredSignal_dixhuit(f,:),filteredSignal_onze(f,:));
    
   % B(f) = covSameSide(1,2);
   % C(f) = covOppositeSide(1,2);
end



COV_SameSideRight = cov(filteredSignal_dixhuit(f,:),filteredSignal_dixsept(f,:))
COV_OppositeSideRight = cov(filteredSignal_dixsept(f,:),filteredSignal_treize(f,:))


% On trace les points

fDroite = figure;
movegui(fDroite,'southwest');
% pour le premier parametre du signal : 1->20 = droite, 20->40 = gauche,
% 40->60 = both, 60->80=rest
% exemple si je mets 15 j'aurai le 15eme trial main droite, si je mets 35
% j'aurai le 15eme mouvement main gauche
s1= scatter(filteredSignal_dixhuit(15,:),filteredSignal_dixsept(15,:),15,'w','filled');
s1.MarkerEdgeColor  = 'b';
hold on
s2 = scatter(filteredSignal_dixsept(15,:),filteredSignal_treize(15,:),15,'r','filled');
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
xlabel('En blanc entre C6 et C4, en couleur en C4 et C3')

fRest = figure;
movegui(fRest,'northeast');

s7 = scatter(filteredSignal_dixhuit(75,:),filteredSignal_dixsept(75,:),15,'w','filled');
s7.MarkerEdgeColor  = 'b';

hold on
s8 = scatter(filteredSignal_dixsept(75,:),filteredSignal_treize(75,:),15,'k','filled');
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
end


