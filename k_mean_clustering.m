## K-means algorithm for updating the centroid position
#############################################################################

function [y,J] = k_mean_clustering(A,MU,n_cl)

[m,n] = size(A);
ecc = zeros(1,n_cl);
ZZ = zeros(m,n_cl);
JJ = zeros(m,1);

CC = zeros(m,n_cl);
for i=1:m
     for j=1:n_cl
          ecc(j) = sum( (A(i,:)-MU(j,:)).^2,2 );      #Distance from each centroid
     end;
     [val q] = min(ecc);                              #Find the minimum distance and centroid index
     CC(i,q) = 1;                                     #Assign centroid to instance
end;

for i=1:n_cl
     MUg = zeros(n_cl,size(A,2));
     MEH = find(CC(:,i));
     for j=1:length(MEH)
          for q=1:n
               MUg(i,q) = MUg(i,q)+A(MEH(j),q);       #Sum of all data (i.e. coordinates)
          end;
     end;
     MU(i,:) = MUg(i,:)/length(MEH);                  #Sum divided by the number of observation per cluster (i.e. mean)
end;

y=MU;

## Function to compute the minimum cost function and chose the best centroids set
##################################################################################
for i=1:n_cl
     ZZ(:,i) = ((sum(([A] - MU(i,:)).^2,2)) );
end;
for j=1:m
     [val,~] = min(ZZ(j,:));                          #Minimum sum of distances
     JJ(j) = val;
end

J = (1/m)*sum(JJ);                                    #Cost function

end;
