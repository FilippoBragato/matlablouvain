function community = Louvain(adj)
% LOUVAIN divide un grafo in community tramite l'algoritmo di Louvain
%
%   community = LOUVAIN(adj) crea un array di dimensione n, numero di nodi,
%   in cui assegna ogni nodo ad una community, nell'ordine in cui questi
%   appaiono nella matrice delle adiacenze adj in input.
%
%   La notazione utilizzata è in accordo con la pagina Wikipedia <a
%   href="matlab: web('https://en.wikipedia.org/wiki/Louvain_method')"
%   >Louvain Method</a>
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
alive = community;
ending = false;
m = sum(matrix, 'all')/2;
while (ending == false)
    ending = true;
    for i_c = 1:length(matrix) %i_c rappresenta il nodo che si sta per spostare
        %uso una notazione in accordo con
        %https://en.wikipedia.org/wiki/Louvain_method
        sigma_tot = sum(matrix);
        sigma_tot = sigma_tot(:);
        sigma_tot(i_c) = 0;
        k_i = sum(matrix(:,i_c));
        k_i_in = matrix(:,i_c);
        k_i_in(i_c) = 0;
        diffModularity = k_i_in/m-(sigma_tot.*k_i)/(2*m^2);
        [maxValue, maxIndex]= max(diffModularity);
        if(maxValue>0)
            ending = false;
            matrix(i_c,maxIndex)=0;
            matrix(:,maxIndex)=matrix(:,maxIndex)+matrix(:,i_c);
            matrix(maxIndex,:)=matrix(maxIndex,:)+matrix(i_c,:);
            matrix(:,i_c) = zeros(size(matrix,1),1);
            matrix(i_c,:) = zeros(1,size(matrix,2));
            toDeplete = alive(i_c);
            dest = alive(maxIndex);
            community(community == toDeplete)=dest;
            alive(i_c) = 0;
        end
    end
    matrix = matrix((~alive==0),(~alive==0));
    alive = alive(~(alive==0));
end
%Allineo le community in modo che vengano rappresentate con un insieme di
%interi da 1 a C (numero di community)
uniComm = unique(community);
for i=1:length(uniComm)
    community(community==uniComm(i)) = max(uniComm) +i;
end
uniComm = unique(community);
for i=1:length(uniComm)
    community(community==uniComm(i)) = i;
end