###############################################################################################################################################
################################## ---------- CLUSTERING ALGORITHM IN 2D ---------- ###########################################################
###############################################################################################################################################
## The code is an application of the K-mean clustering algorithm. The data file contains astrophysical data
## - The Eddington ratio (Log value) 
##        ---> It represents the strength of the radiation coming from the accretion disk of gas around a black hole. A small correction 
##             (i.e. -0.8) is applied to data (it depends on the black hole rotation).
## - The Observed disk luminosity (Log value) 
##        ---> It represents the amount of radiation produced by the accretion disk
## - The Observed luminosity ratio (Log value) 
##        ---> It is the ratio between the luminosity of the "torus" (i.e., a structure made of gas which absorbed a fraction of
##             the accretion disk and re-emits it) and the accretion disk one.
##
## The code needs an input data file ("Dati_Astro.txt") and the number of centroids to be found.
###############################################################################################################################################
###############################################################################################################################################

function y=Clustering_alg_2D(A,n_cl),

## Read the file containing three columns: "Eddington ratio", "Observed disk luminosity", "Observed ratio"
printf("\nReading the data file...\n");
A = load('Data_Astro.txt');
A = [A(:,1)-0.8,A(:,3)];

pkg load statistics
set (findobj (gcf, "-property", "interpreter"), "interpreter", "latex")
[m,n] = size(A);



## Randomly assign n_cl data-point from the dataset to initialize the centroids then run 
## K-mean algorithm. At each iteration (20 in total), the cost function (i.e., the sum of 
## the distance of each point from the closest centroid divided by the number of data) is 
## computed. The best centroids are those with the lowest cost function value.
##############################################################################################################

J_matrix = zeros(20,n_cl*size(A,2)+1);
output = fprintf("\nRunning the K-mean algorithm N° 0 (of 20) to find the %d centroids with the lowest cost function...", n_cl);
for k=1:20,
     fprintf(repmat('\b',1,output));
     output = fprintf("Running the K-mean algorithm N° %d (of 20) to find the %d centroids with the lowest cost function...", k, n_cl);
     MU = rand_point(A,n_cl);
     [MU,J] = k_mean_clustering(A,MU,n_cl);
     J_matrix(k,:) = [J,MU(:)'];
end;
printf("\n\n");

[val,q] = min(J_matrix(:,1));                                  
MU = reshape(J_matrix(q,2:end),n_cl,size(A,2));

MU


## Bidimentional plot of the dataset. Different colors are used for different clusters
printf("\nPlotting data, centroid positions and clusters...\n");
ZZ = zeros(m,n_cl); 
for i=1:n_cl
     ZZ(:,i) = ((sum(([A] - MU(i,:)).^2,2)) );
end;

[val q] = min(ZZ');                                          #Find the centroid set with the minimum cost function
MEH = [];
for i=1:n_cl
     MEH = find(q==i);
     plot(A(MEH,1),A(MEH,2),'o','MarkerSize', 2)
     hold on;
     grid on;
     plot(MU(i,1),MU(i,2), 'r+', 'MarkerSize', 10)
     xlabel ("Log Eddington ratio \\lambda_{Edd}");
     ylabel ("Log Observed luminosity ratio R_{obs}");
     xlim([-2.5 0]);
     ylim([-2 2]);
end;

end;
