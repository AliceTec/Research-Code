
%%%%%%%%%function to compute feature vector of zeta function
            %%%%%%%%%(Laplacian)%%%%
            
%%%% Arguments of the function %%%%%
%%% 1st: list of zeta arguments 
%%% 2nd: directory of images
%%% 3rd: image type
%%% 4th: number of points/vertices of Delanay graph
%%% 5th&6th: cordinates of the extreme corner points to be deleted  



function egMat = computeFeatureVectorZeta(s,direc,imagetype, thres, rup, rdown)
    slen = length(s);                                     %length of zeta argument list
    numview = (0:5:355);                                  % list of views of images
    egMat = zeros(slen,length(numview));                  % initialise matrix to contain feature vectors  
    cc=1;                                                 % initialise column index
    
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
        
        %create graph from delanauy, compute adjacency and Laplacian
        %matrices
        g = digraph(tri, tri(:, [2 3 1]));
        A = adjacency(g);
        A = sparse(A | A');
        L = diag(sum(A))-A;
        
        %column vector of eigenvalues of Laplacian
        eg = sort(eig(full(L)));                   %sort in ascending order
        eg = eg(2:end,:);                          %eliminate the zero eigenvalue
        
        
        egvec = zeros(1,slen);                      %initialise row vector to capture computed zeta values
        
        ct = 1;                                    % set column index
        
        %compute zeta functions
        for ss = s
            egsum = sum(eg.^(-ss));
            egvec(:,ct) = egsum;
            ct = ct+1;
        end
        
        %append result to matrix
        egMat(:,cc) = egvec;
        cc = cc+1;
    end
end