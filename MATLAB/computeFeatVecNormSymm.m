
%%%%%%%%%function to compute feature vector of symmetric polynomial of 
%%%%%%%%leading eigenvalues of(Normalised Laplacian)%%%%


%%%% Arguments of the function %%%%%
%%% 1st: number of leading eigenvalues to consider 
%%% 2nd: directory of images
%%% 3rd: image type
%%% 4th: number of points/vertices of Delanay graph
%%% 5th&6th: cordinates of the extreme corner points to be deleted 

function egMat = computeFeatVecNormSymm(s,direc,imagetype, thres, rup, rdown)
    numview = (0:5:355);                                   % list of view angles
    egMat = zeros(s,length(numview));                      % initialise matrix to contain feature vectors
    cc=1;                                                  % initialise column index
    
    for i = numview
        img = imread(strcat(direc,num2str(i),imagetype));   % read image
        im=rgb2gray(img);                                   % change gray scale
        
        [cim,r,c]= harris4(im,1,thres,2);                   % find corner points, maximum is thres
        
        %discard corner points at the extremes
        cod = [c(:), r(:)];
        cod = cod(rup:end,:);
        cod = cod(1:end-rdown,:);
        
        % Delaunay triangulation
        tri = delaunay(cod(:,1),cod(:,2));
        
        %create graph from delanauy, compute adjacency and Normalised Laplacian
        %matrices
        g = digraph(tri, tri(:, [2 3 1]));
        A = adjacency(g);
        A = sparse(A | A');
        Ln = computeNormalisedLap(full(A));
        
        %column vector of eigenvalues of Laplacian
        eg = sort(eig(Ln), 'descend');                %sort eigenvalues in descending order
        eg = eg(1:s,:);                               % select s leading eigenvalues
        %eg = sort(eig(Ln));
        %eg = eg(2:end,:);
        egsym = computeSymmetricPoly(eg);             % compute symmetric matrix
        %size(egsym)
        %build pattern vector matrix
        egMat(:,cc) = egsym;
        cc = cc+1;
    end
end