

%%%%%%%%%function to compute feature vector of leading eigenvalues of
            %%%%%%%%%(Laplacian based Laplacian)%%%%
            
%%%% Arguments of the function %%%%%
%%% 1st: number of leading eigenvalues to consider 
%%% 2nd: exponent of Laplacian, lambda
%%% 3rd: directory of images
%%% 4th: image type
%%% 5th: number of points/vertices of Delanay graph
%%% 6th&7th: cordinates of the extreme corner points to be deleted 



function egMat = computeFeatureVectorLaplace(s,lambda,direc,imagetype, thres, rup, rdown)
    numview = (0:5:355);                                   % list of view angles
    egMat = zeros(s,length(numview));                      % initialise matrix to contain feature vectors
    cc=1;                                                  % initialise column index
    
    for i =numview
        img = imread(strcat(direc,num2str(i),imagetype));   % read image
        im=rgb2gray(img);                                   % change gray scale
        
        [cim,r,c]= harris4(im,1,thres,2);                   % find corner points, maximum is thres
        
        %discard corner points at the extremes
        cod = [c(:), r(:)];
        cod = cod(rup:end,:);
        cod = cod(1:end-rdown,:);
        
        % Delaunay triangulation
        tri = delaunay(cod(:,1),cod(:,2));
        
        %create graph from delanauy, compute adjacency and Laplacian
        %matrices
        g = digraph(tri, tri(:, [2 3 1]));
        A = adjacency(g);
        A = sparse(A | A');
        
        %Extract Graph
        G = graph(A);
        
        %Compute Laplace based Laplacian
        L = computeLaplace(G,lambda);
        
        %column vector of eigenvalues of Laplacian
        eg = sort(eig(full(L)), 'descend');                      % sort in descending order
        eg = eg(1:s,:);                                          % select s leading values
        
        %append result to matrix
        egMat(:,cc) = eg;
        cc = cc+1;
    end
end