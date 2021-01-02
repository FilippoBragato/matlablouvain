function [community]= Louvain(adj)

if(~issymmetric(adj))
    ME = MException('Input matrix is not symmetric');
    throw(ME);
end
if(~isa(adj, 'double'))
    ME = MException("Input matrix's entry are not double");
    throw(ME);
end

matrix = adj;
community = 1:size(adj,1);
ending = false;
m = sum(matrix, 'all');
alive = community;
while (ending == false)
    ending = true;
    initialComm = size(matrix,1);
    for i_c = 1: initialComm
        %uso una notazione in accordo con 
        %https://en.wikipedia.org/wiki/Louvain_method
        sigma_in = diag(matrix(2:end,2:end));
        sigma_tot = sum(matrix(:,2:end));
        sigma_tot = sigma_tot(:);
        k_i = ones(size(matrix,1)-1,1)*sum(matrix(:,1));
        k_i_in = matrix(2:end,1);
        diffModularity = ((sigma_in+2*k_i_in)./2*m-((sigma_tot+k_i)./(2*m)).^2) ...
                         -(sigma_in./(2*m)-(sigma_tot./(2*m)).^2-(k_i./(2*m)).^2);
        [maxValue, maxIndex]= max(diffModularity);
        if(maxValue>0)
            ending = false;
            matrix(1,maxIndex+1)=matrix(1,1);
            matrix(:,maxIndex+1)=matrix(:,maxIndex+1)+matrix(:,1);
            matrix(maxIndex+1,:)=matrix(maxIndex+1,:)+matrix(1,:);
            matrix = matrix(2:end,2:end);
            toDeplete = alive(i_c);
            dest = alive(mod(i_c + maxIndex,size(alive,2)));
            f = community == toDeplete;
            community(f)=dest;
            alive = [alive(1:i_c-1),alive(i_c+1:end)];
        else
            %Faccio un cambiamento di base per mettere l'elemento in
            %analisi in prima posizione
            baseChange = eye(size(matrix,1));
            baseChange = baseChange(:,[size(matrix,1),1:size(matrix,1)-1]);
            matrix=baseChange*matrix*(eye(size(matrix,1))/baseChange);
        end
    end
end

uniComm = unique(community);
for i=1:uniComm.length
    community(community==uniComm(i)) = max(uniComm) +i;
end
uniComm = unique(community);
for i=1:uniComm.length
    community(community==uniComm(i)) = i;
end