%% Merriman-Bence-Osher Method for Mean Curvature Motion
% Circle image on [0,1]x[0,1] 
clear all
close all

%% Loop through different resolutions
for l = 5:9
    % Define resolution
    M = 2^l;  N = 2^l;

    %% create and plot initial binary circle image
    R0 = 0.25;
    dx = 1/M; dy = 1/N;
    x = 0.5*dx:dx:1-0.5*dx; y = 0.5*dy:dy:1-0.5*dy;
    cx = dx*M/2; cy = dy*N/2;
    [X,Y] = ndgrid(x,y);
    [ttheta,rho] = cart2pol(X-cx,Y-cy);
    umat = (rho<=R0);

    figure(1)
    imagesc(umat); colormap(gray); axis off; axis equal;
    title(strcat('$R_0$ = ',num2str(R0,'%4.3f')),'Interpreter','Latex',...
        'FontSize',40);
    %% Parameters
    T = 3/256;
    h = dx;
    dt = T/(2^(l-4));%(2^(l+4))*h^2*T
    t = dt:dt:T;
    Tend = dt;

    if l == 9
        k = dt/30;
    else
        k = dt/20;
    end

    %% Form matrices for linear system solve
    
    E = sparse(2:N,1:N-1,1,N,N); Imat = speye(N); 
    A1D = E+E'-2*Imat; A1D(N,N-1) = 2; A1D(1,2) = 2; 
    A2D = kron(A1D,Imat) + kron(Imat, A1D);

    Amat = speye(N^2) - 0.5*k/h^2*A2D;
    u = reshape(umat,N^2,1);

    %% MBO method
    for q = 1:length(t)
        %--------------------Diffusion-------------------------
        time = 0;
        while (time<=Tend)
            u = Amat\(u+0.5*k/h^2*A2D*u);
            time = time+k;
        end
        %--------------------Threshold-------------------------
        u(u<=0.5) = 0;
        u(u>0.5) = 1;
        
        % Calculate radius of circle
        uu = reshape(u,N,N);
        Ind = uu(1:M-1,:) - uu(2:M,:);
        [row,col] = find(Ind~=0);
        row = reshape(row,2,size(row,1)/2);
        subrow = row(2,:) - row(1,:);
        r = max(subrow)*dx/2;
    
        % plot segmentation
        figure(2);
        imagesc(reshape(u,N,N)); colormap(gray); axis off; axis equal;
        title(strcat('$r$ = ',num2str(r,'%4.3f')),'Interpreter','Latex',...
            'FontSize',40);
        drawnow
    end
    u = reshape(u,N,N);

    % compute error in radius.
    Ind = u(1:M-1,:) - u(2:M,:);
    [row,col] = find(Ind~=0);
    row = reshape(row,2,size(row,1)/2);
    subrow = row(2,:) - row(1,:);
    R(l-4) = max(subrow)*dx/2;
    R_err(l-4) = abs(sqrt(5/128) - R(l-4))/sqrt(5/128);
end