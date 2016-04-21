[b1,a1] = ellip(6,3,50,300/500);
[b2,a2] = ellip(6,3,50,200/500);

A = a1;
P = b1;
%A = [1, -1.99, 1.572, -0.4583];
%P = [0.0154, 0.0462, 0.0462, 0.0154];

K = zeros(1,length(A)-1);
V = zeros(1,length(P));

for i = length(A):-1:2
    K(i-1) = A(i); 
    B = [fliplr(A(1:i)),zeros(1,length(A)-i)];
    tmp = (A - A(i)*B)/(1-A(i)^2);
    A = tmp;
    if (i<=length(P))
        V(i) = P(i);
        tmp2 = P - P(i)*B;
        P = tmp2;
    end
end
V(1)=P(1);
