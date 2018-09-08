

sub(Mul) --> add(Mul).

sub(sub(Mul,Sub)) --> add(Mul), sign_sub , sub(Sub).

add(Mul) --> mul(Mul).

add(add(Mul,Sub)) --> mul(Mul) , sign_add , add(Sub).

mul(Mul) --> divide(Mul).

mul(mul(Mul,Sub)) --> divide(Mul) , sign_multiply, mul(Sub).

divide(Mul) --> var1(Mul).

divide(divide(Mul,Add)) --> var1(Mul) , sign_divide, divide(Add).


is_opening -->["("].
is_closing -->[")"].
sign_divide --> ["/"].  
sign_multiply -->[*].
sign_sub -->[-].
sign_add -->[+].
var1(N) --> [N],{ number(N)}.
var1(Z) -->[Z] ,{ isvalid(Z)}.
var1(X) --> is_opening,sub(X),is_closing.

isvalid(Z):-atom_chars(Z,[_|[T]]),atom(T).



%--------------Parse Tree Complete----------------------------------------------------.



%Clauses for simpliying Add operator--------------------.

simplify_add(add(X,Y),Z):-X==0,Z=Y.

simplify_add(add(X,Y),Z):-Y==0,Z=X.


simplify_add(add(X,Y),Z):-atom_chars(X,[H1|T]),atom_chars(Y,[H2|T]),atom_number(H1,N1),atom_number(H2,N2),N3 is N1+N2,atom_number(H3,N3),total_convert(Z,T,H3).

simplify_add(add(X,Y),Z):-number(X),number(Y),Z is X+Y.

simplify_add(add(X,Y),Z):-Z=X+Y.

%-------------------------------------------------------.



%Clauses for simpliying Subtractio operator---------------------------.

simplify_sub(sub(X,Y),Z):-X==0,Z=Y.
simplify_sub(sub(X,Y),Z):-Y==0,Z=X.
simplify_sub(sub(X,Y),Z):-Y==X,Z=0.
simplify_sub(sub(X,Y),Z):-not_compound(X),not_compound(Y),atom_chars(X,[H1|T]),atom_chars(Y,[H2|T]),atom_number(H1,N1),atom_number(H2,N2),N3 is N1-N2,atom_number(H3,N3),total_convert(Z,T,H3).

simplify_sub(sub(X,Y),Z):-number(X),number(Y),Z is X-Y.

simplify_sub(sub(X,Y),Z):-Z=X-Y

%Clauses for multipy operator----------------------------------------------.

simplify_mul(mul(X,_),Z):-X==0,Z=0.
simplify_mul(mul(_,Y),Z):-Y==0,Z=0.
simplify_mul(mul(X,Y),Z):-Y==1,Z=X.
simplify_mul(mul(X,Y),Z):-X==1,Z=Y.
simplify_mul(mul(X,Y),Z):-number(X),not_compound(Y),atom_chars(Y,[H1|T]),atom_number(H1,N1),N3 is X*N1,atom_number(H3,N3),total_convert(Z,T,H3).
simplify_mul(mul(X,Y),Z):-number(Y),not_compound(X),atom_chars(X,[H1|T]),atom_number(H1,N1),N3 is Y*N1,atom_number(H3,N3),total_convert(Z,T,H3).
simplify_mul(mul(X,Y),Z):-not_compound(X),not_compound(Y),atom_chars(X,[H1|T]),atom_chars(Y,[H2|T]),atom_number(H1,N1),atom_number(H2,N2),N3 is N1*N2,atom_number(H3,N3),total_convert(Z,T,H3).

simplify_mul(mul(X,Y),Z):-number(X),number(Y),Z is X*Y.

simplify_mul(mul(X,Y),Z):-Z=X*Y.

%-------------------------------------------------------------------------.

simplify_div(divide(X,_),Z):-X==0,Z=0.
simplify_div(divide(X,Y),Z):-Y==1,Z=X.

simplify_div(divide(X,Y),Z):-not_compound(X),not_compound(Y),atom_chars(X,[H1|T]),atom_chars(Y,[H2|T]),atom_number(H1,N1),atom_number(H2,N2),N3 is N1/N2,Z=N3.
simplify_div(divide(X,Y),Z):-Z=X/Y.



not_compound(Y):-not(compound(Y)).



total_convert(Z,[H|_],A):-atom_chars(Z,[A,H]).

%Recursive Defination for simpliying addition and subtraction expressions----------------.

simple2(X,X):-atomic(X),!.

simple2(divide(X,Y),Z):-simple2(X,X1),simple2(Y,Y1),simplify_div(divide(X1,Y1),Z).

simple2(mul(X,Y),Z):-simple2(X,X1),simple2(Y,Y1),simplify_mul(mul(X1,Y1),Z).

simple2(sub(X,Y),Z):-simple2(X,X1),simple2(Y,Y1),simplify_sub(sub(X1,Y1),Z).

simple2(add(X,Y),Z):-simple2(X,X1),simple2(Y,Y1),simplify_add(add(X1,Y1),Z).


%------------Final Predicate to use for simpliying expression , currently works only for addition and subtraction----------------------------.


normalize(Parse,Y,Z,Answer):-sub(Parse,Y,Z),simple2(Parse,Answer).
