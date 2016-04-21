K = [-0.875587128665256,0.835462647015623,-0.458300000000000];
V = [0.0856458873365265,0.145490980552995,0.0768460000000000,0.0154000000000000];

A = zeros(1, length(K)+1);
A(1) = 1;
A(2) = K(1);
A(length(K)+1) = K(length(K));
Tmp = zeros(1, length(K)+1);

P = zeros(1,length(V));
P(1) = V(1)+V(2)*K(1);
P(2) = V(2);

if(length(K) >= 2)
    for M = 2:length(K)
        for k = 1:1:M-1;
            Tmp(k) = A(k+1)+K(M)*A(M-k+1);
        end
    A(2:M) = Tmp(1:M-1);
    A(M+1) = K(M);
    
    B = [fliplr(A(1:M+1)),zeros(1,length(V)-M-1)];
    P = P+B*V(M+1);
    end
end
    