#################################################################################
##   This is the K-means algorithm used for updating the centroids position    ##
##  based on their nearest points. The algorithm returns the matrix containing ##
## the final centroids and the "cost function", i.e. the mean squared distance ##
##       of each point of the dataset from the corresponding centroid.         ##
#################################################################################

function [y,J] = k_mean_clustering(A,MU,n_cl)          #Input parameters: dataset, initial centroid matrix, and number of centroids

[m,n] = size(A);                                       #Dataset dimension
ecc = zeros(1,n_cl);                                   #Matrix that will contain the distance of a point from each centroid during iteration
ZZ = zeros(m,n_cl);                                    #Matrix that will contain the distance of a point from each final centroid 
JJ = zeros(m,1);                                       #Vector that will contain the minimum squared distance of a point from the corresponding centroid

CC = zeros(m,n_cl);                                    #Matrix that will tell which centroid each point is closest to (1s and 0s)
for i=1:m
     for j=1:n_cl
          ecc(j) = sum( (A(i,:)-MU(j,:)).^2,2 );       #Distance of point i from each centroid j
     end;
     [val q] = min(ecc);                               #Find the minimum distance and centroid index for point i
     CC(i,q) = 1;                                      #Assign 1 for point i to its closest centroid q
end;

for i=1:n_cl
     MUg = zeros(n_cl,size(A,2));
     MEH = find(CC(:,i));
     for j=1:length(MEH)
          for q=1:n
               MUg(i,q) = MUg(i,q)+A(MEH(j),q);        #Sum of all data (i.e. sum of coordinates)
          end;
     end;
     MU(i,:) = MUg(i,:)/length(MEH);                   #Sum divided by the number of observation per cluster (i.e. mean value for each coordinate)
end;

y = MU;                                                #Matrix containing the final centroid coordinates


## The following function computes the minimum "cost function" (i.e. minimum mean squared distance) and chose the best centroids set
for i=1:n_cl
     ZZ(:,i) = ((sum(([A] - MU(i,:)).^2,2)) );        #Squared distance of each point from the final centroids
end;
for j=1:m
     [val,~] = min(ZZ(j,:));                          #Find the minimum sum of squared distances of each point j from the centroids
     JJ(j) = val;                                     #Assign that value to the matrix JJ
end

J = (1/m)*sum(JJ);                                    #Cost function, i.e. mean squared distance

end;
