function readSubject

file = importdata('C:\Users\Utilisateur\Documents\Master\InitResearch\InitRecherche\S3_run1.mat')
info = file.info;

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
% Recupération des signaux 8 et 12
signal_huit = file.signal(:,8);
signal_douze = file.signal(:,12);
fs = 256;
order = 5;
range = [8,30]; % filtrage entre 8 et 30 Hz
[B,A] = butter(order,[range(1,1)*(2/fs),range(1,2)*(2/fs)]);
filteredSignal8 = filter(B,A,signal_huit);
filteredSignal12 = filter(B,A,signal_douze);
allRightHandPosition = info.EVENT.POS(info.EVENT.TYP==1090);

for f = 1:length(allRightHandPosition)

    %endrightHand = info.EVENT.POS(info.EVENT.TYP==1090)+3072;
    fin = allRightHandPosition(f)+3072-1;

    filteredSignal_huit(f,:) = filteredSignal8(allRightHandPosition(f):fin);
    filteredSignal_douze(f,:) = filteredSignal12(allRightHandPosition(f):fin);
    
    A = cov(filteredSignal_huit,filteredSignal_douze);
    B(f) = A(1,2);
end
plot(B)
% nombre de points 
%tailleSignal = length(filteredSignal)

%affichage moyenne du signal
%average = mean2(filteredSignal)

%affichage variance du signal
%variance = var(filteredSignal)

%somme des points du signal
%sommeDesPoints = sum(filteredSignal)
end


