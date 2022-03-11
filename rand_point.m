################################################################################
##  The following function assigns random points, extracted form the dataset, ##
## to initialize the centroids that will be used in the clustering algorithm. ##
################################################################################

function MU = rand_point(A, n_cl),        #Input parameters: dataset, number of clusters

m = size(A,1);                            #Number of rows
MU = [];                                  #Matrix that will contain the initial centroids
for i=1:n_cl
     MU = [MU; A(randsample(m,1),:)];
end;

end;
