function [y,J] = k_mean_clustering(A,MU,n_cl)

[m,n] = size(A);
ecc = zeros(1,n_cl);
ZZ = zeros(m,n_cl);
JJ = zeros(m,1);

CC = zeros(m,n_cl);
for i=1:m
     for j=1:n_cl
          ecc(j) = sum( (A(i,:)-MU(j,:)).^2,2 );
     end;
     [val q] = min(ecc);
     CC(i,q) = 1;
end;

for i=1:n_cl
     MUg = zeros(n_cl,size(A,2));
     MEH = find(CC(:,i));
     for j=1:length(MEH)
          for q=1:n
               MUg(i,q) = MUg(i,q)+A(MEH(j),q);
          end;
     end;
     MU(i,:) = MUg(i,:)/length(MEH);
end;

y=MU;

##########################################################################
for i=1:n_cl
     ZZ(:,i) = ((sum(([A] - MU(i,:)).^2,2)) );
end;
for j=1:m
	[val,~] = min(ZZ(j,:));
	JJ(j) = val;
end

J = (1/m)*sum(JJ);

end;
