[b1,a1] = ellip(6,3,50,300/500); % filter structure1
[b2,a2] = ellip(6,3,50,100/500);  % filter structure2

N = 3500; % signal length

% compute the reflection coefficients
[k1,v1] = tf2latc(b1,a1);
[k2,v2] = tf2latc(b2,a2);

% generate structure varing matrix
K = zeros(length(k1),N);
V = zeros(length(v1),N);

for n=1:1:length(k1)
    % exponential evolution of 3
    % K(n,:) = linspace(nthroot(k1(n),3),nthroot(k2(n),3),N).^3;
    % V(n,:) = linspace(nthroot(v1(n),3),nthroot(v2(n),3),N).^3;
    
    % linear evolution
     K(n,:) = linspace(k1(n),k2(n),N);
     V(n,:) = linspace(v1(n),v2(n),N);
     
    % log evolution
    % K(n,:) = log(linspace(exp(k1(n)),exp(k2(n)),N));
    % V(n,:) = log(linspace(exp(v1(n)),exp(v2(n)),N));
end
K = K';
V = V';

% generate input noise signal
x=randn(1,N);
x=diag(x);

% output initialization
F = zeros(N,N);
G = zeros(N,N);
R1 = zeros(N,N);
R2 = zeros(N,N);

% implement time varing filter
for n=1:1:N
    [F(n,:),G(n,:)]=latcfilt(K(n,:),V(n,:),x(n,:));
    R1(n,:) = filter(b1,a1,x(n,:));
    R2(n,:) = filter(b2,a2,x(n,:));
end
f = sum(F);
g = sum(G);
r1 = sum(R1);
r2 = sum(R2);

% plot the spectrogram
Nx = length(x);     
nsc = floor(Nx/20); % window bandwidth
nov = floor(nsc/2); % overlap
nff = max(4096,2^nextpow2(nsc)); % fft size

subplot(3,1,1);
spectrogram(r2,hamming(nsc),nov,nff);
subplot(3,1,2);
spectrogram(f,hamming(nsc),nov,nff);
subplot(3,1,3);
spectrogram(r1,hamming(nsc),nov,nff);
