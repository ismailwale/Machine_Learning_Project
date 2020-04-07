
%reading of the file
D=importdata('wdbc.data');
% seperating features from class
z=D.data;
o=D.textdata
% converting cell colum to logical 
otn=strcmp(o(:,2),'M');
id= [z,otn];% adding a colum
[a,b]=size(id);
kn=o(:,2);
wa=id(:,31); %seperate M% B cloum
q=size(kn);
% split data into  train set and test
aj=kn(1:round(0.7*q),:);
am=kn((round(0.7*q)+1:end),:)
%rng('default');
% cv = cvpartition(size(id,1),'HoldOut',0.3);
% idx = cv.test;
trn=id(1:round(0.7*a),:);
tst=id((round(0.7*a)+1:end),:)
% selection of two fields for train data
%Train = trn(~idx,:); 
tc1= trn(:,1 );
tc5= trn(:,5);
tc31=trn(:,31);
%new Train data
newTn=[tc1,tc5,tc31];
t=[tc1,tc5];
q=size(t)
%colum extraction for testdata
%Test  = id(idx,:);
Tcts1= tst(:,1);
Tcts5 =tst(:,5);
Tcts31=tst(:,31);
%new Tesst data
newTs=[Tcts1,Tcts5,Tcts31];

ztn = size(newTn,1);   % Number of students to test
zts= size(newTs,1);
 s=171
% Loop through all test data
for k=1:10
    for i = 1:zts % loop throgh the test data
        countM=0;
        countB=0;
        sd = 1;         % Smallest euclidean distance
        cj = 1;         % Closest training j    
        
    for j = 1:ztn    % Loop through all data in training set
        
      % Calculate Euclidean distance between test vector and training vector

        d(j) = sqrt((newTn(j,1)-newTs(i,1))^2 + (newTn(j,2)-newTs(i,2))^2);
    end
    [D_STN,index]=sort(d(:),'ascend');
    for row_vc=1:k
        if strcmp(aj(index(row_vc)),('M'));
            countM=countM+1;
        else
            strcmp(aj(index(row_vc)),('B'));
            countB=countB+1;
        end
    end
        if countM>countB
            N(i,k)=('M');
        elseif countM<=countB
            N(i,k)=('B');
        end
    end
    end
    %error for value of k rangingin from 1:10
    for itr =1:k
        e=(i-sum(strcmp(N(:,itr),am)'))/s;
        disp(['Percent error for k: ', num2str(itr), ' is ',num2str(e*100), '%']);
    end
    
    ky=id(:,[1,6]);   %Radious and smoothness data
    ky_newTn=ky(1:round(0.7*a),:);
    ky_newTs=ky((round(0.7*a)+1:end),:);  %testing data set
    
    %Radius vs Smoothness plot
    for sd=1:171
        if strcmp(am(sd,1),'M');
            scatter(ky_newTs(sd,1),ky_newTs(sd,2),'ro')
            hold on;
        else
            scatter(ky_newTs(sd,1),ky_newTs(sd,2),'bo')
        end
    end
    
    
    %prediction plot
    for sd=1:171;
        if strcmp(N(sd,1),'M')
            scatter(ky_newTs(sd,1),ky_newTs(sd,2),'r+')
            hold on
        else
            scatter(ky_newTs(sd,1),ky_newTs(sd,2),'b+') 
        end
    end
    
        
   
    


