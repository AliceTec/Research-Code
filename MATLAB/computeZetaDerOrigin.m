
%PCA analysis based on leading eigenvalues of Normalised Laplacian %%%%%%


% arguments to the computeFeatureVecNorm() function %%%%%%%%

%first: directory of object/image
%second  : image type
%third  : number of points/vertices of Delanay graph
%fourth&fifth  : cordinates of the extreme corner points to be deleted



function zVal = computeZetaDerOrigin(direc,imagetype, thres, rup, rdown)
    numview = (0:5:355);                                        % list of view angles
    zVal = [] ;                        % initialise matrix to contain feature vectors
    cc=1;                                                       % initialise column index
    
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
        Ln = computeNormalisedLap(A);
        
        %column vector of eigenvalues of Laplacian
        eg = sort(eig(full(Ln)));
        zSum= 0;
        
        %compute zeta derivative at origin  
        for k = 2 : length(eg)
            zSum = zSum+ (-log(eg(k)));
        end
        
        %build matrix to contain results
        zVal(cc,:) = zSum;
        cc = cc+1;
    end
end