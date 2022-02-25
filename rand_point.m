## Function to assign random point form the dataset to the initial centroids
#############################################################################

function MU = rand_point(A, n_cl),

m = size(A,1);
MU = [];
for i=1:n_cl
     MU = [MU; A(randsample(m,1),:)];
end;

end;
