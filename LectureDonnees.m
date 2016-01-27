function readSubject

file = importdata('C:\Users\Thibault\Documents\InitRecherche\subject_3\S3_run1.mat')
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
signal = file.signal(:,1);

% filtrage (Butterworth) du signal
fs = 256;
order = 5;
range = [8,30]; % filtrage entre 8 et 30 Hz
[B,A] = butter(order,[range(1,1)*(2/fs),range(1,2)*(2/fs)]);
filteredSignal = filter(B,A,signal);


% (premier trial compris entre 7681:10753)
filteredSignal = filteredSignal(1:end);
% affichage du signal filtré 
plot(filteredSignal);

% nombre de points 
tailleSignal = length(filteredSignal)

%affichage moyenne du signal
average = mean2(filteredSignal)

%affichage variance du signal
variance = var(filteredSignal)

%somme des points du signal
sommeDesPoints = sum(filteredSignal)
end


