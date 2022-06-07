Program ex2_11;

const ini = 1 ; fim = 20; 

type  vetor = array[ini..fim] of integer;

var   u,w: vetor ;  n_semanas,quinto, a, i, enviado: integer;
//********************************************************************

Procedure gera_U_e_W(var u,w: vetor);
 var i, aux:integer;
Begin
 aux:= 1000;
 For i:= 1 to 20 do
 Begin
  u[i]:= aux;
  aux:= aux - 50;
 End;
 w:= u;
End;

Procedure imprime(var v: vetor; n: integer);
 var i: integer;
Begin
 For i:=1 to n do
  write(v[i],' ');
 writeln;
End;

Procedure soma_w(var v: vetor; var quinto: integer);
 var i: integer;
Begin
 // atualizamos o quinto
 quinto:= v[5];
 // somar 100 em 'todas' as posi��es exceto em v[5]. Como evitar a soma desnecess�ria?
 // por enquanto somaremos tudo, mesmo os elementos que n�o precisa
 For i:= 1 to 20 do
 Begin
  If i <> 5 then
   v[i]:= v[i] + 100
  Else
   v[i]:= v[i] + 30;
 End; 
End;

Function busca_simples_v2(x: integer; var v: vetor; n: integer): integer;
var i: integer; achou: boolean;
Begin
 busca_simples_v2:= 0;
 achou:= false;
 i:=1;
 while (i<= n) and (not achou ) do 
 begin
  if v[i] = x then
   achou:= true;
  i:= i +1;
 end;
 if achou then
  busca_simples_v2:= i - 1;
End;

Procedure soma_u(var u: vetor; quinto,a: integer);
 var i,pos_quinto: integer;
Begin 
 // pesquisamos quinto em U, o primeiro valor de quinto eh 800 N�O 830!!!
 pos_quinto:= busca_simples_v2(quinto,u,20); // devolve a posi��o do 5o reg em U
 // agora que realmente alterara o vetor u com a soma:
 For i:= 1 to 20-(a-1) do  // aqui conseguimos evitar somas desnecess�rias?
 Begin
  If i = pos_quinto then 
   u[i]:= u[i] + 30
  Else
   u[i]:= u[i] + 100;
 End;
 // j� temos u somado, agora precisamos orden�-lo mas antes o imprimiremos   
End;

Procedure metodo_da_troca_alterado(var v: vetor; n: integer);
// po enquanto estamos ordenando o tamanho inteiro do vetor, tem outro jeito???
 var i: integer; aux: integer; troca: boolean;
Begin
 Repeat
  n:= n-1;
  troca:= true;
  For i:=1 to n do
   If (v[i] < v[i+1]) then
   Begin
    aux:= v[i];
    v[i]:= v[i+1];
    v[i+1]:= aux;
    troca:= false;
   End;
 Until(troca);
End;

//********************************************************************
BEGIN
 gera_U_e_W(u,w); // w n�o muda mais, apenas somaremos
 quinto:= u[5];
 write('Situa��o inicial dos vetores u e w, lembrando que w');
 writeln(' somente far� a opera��o de soma:' );
 imprime(u,20);
 writeln;
 writeln;
 FOR a:=1 TO 20 DO // temos certeza que sao 20 semanas, for eh o mais adequado?
 BEGIN
  // semana a = 1, semana i=2, semana i= 3 etc,...
  writeln('SITUA��O DA SEMANA ',a,':');
  // soma em w: 
  soma_w(w,quinto); //quinto por refer�ncia, atualizar quinto sempre aqui??
  // soma em u:
  soma_u(u,quinto,a);
	writeln('Ap�s somar W:'); 
  imprime(w,20);
  writeln('Ap�s somar U:');
  imprime(u,20);
  writeln;
  // ordenamos u, obviamente u est� sendo ordenado em ordem CRESCENTE, ALTERAR o 
  // metodo_da_troca!!!
  metodo_da_troca_alterado(u,20);
  
  writeln('Ap�s ordenar U em ordem DECRESCENTE:');
  imprime(u,20);
  // pesquisamos u[1] em w e MOSTRAMOS QUAL REGIMENTO EST� SENDO ENVIADO:
  enviado:= busca_simples_v2(u[1],w,20); // vc sabe que o regimento que vai ser enviado
  // est� na primeira posicao do vetor u, pois j� ordenamos u,
	// basta pesquisar este u[1] em W para sabermos
  // com precisao de qual regimento definido no come�o se trata. � como se fosse desig
  // nado um "r�tulo" para cada regimento no in�cio, algo como "voc� � o oitavo regi
	// mento"
  writeln;
  // mostramos o status dos regimentos:
  writeln;
  writeln('O regimento que est� sendo enviado � o: ', enviado); 
  writeln;
	For i:= 1 to (20-(a-1)) do
	 writeln('O ',busca_simples_v2(u[i],w,20):2,' regimento est� na posi��o ',i);
	writeln;	   
  // if u[1] = w[5] then
	// n_semanas = i
	If u[1] = w[5] then
	 n_semanas:= a;
	// deslocar cada elemento de u para esquerda:
	For i:= 1 to 20-a do
	 u[i]:= u[i+1];
	writeln('Ap�s enviar o regimento da semana nosso vetor u fica:');
	imprime(u,20);
	writeln;  
 END;
 writeln;
 writeln('   O quinto regimento levou exatamente ',n_semanas,' semanas para ser enviado ao front');
 readln;
END.












