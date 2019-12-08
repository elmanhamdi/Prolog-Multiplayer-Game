%That is change the specific element in the in the list by "x" and return this list
replace(Element, [X|List], BlankList, E):-
    length(List,Len),
    (Len = 0 ->   
 		lastItemForReplace(Element, X, BlankList, E);
    (Element = X ->  
        append(BlankList,["x"], D),
        replace(Element, List, D, E);
    	append(BlankList, [X], C),
    	replace(Element, List, C, E))).
		
%Helper for function replace, This decide which element that in list  is last
lastItemForReplace(Element, X, BlankList,C):-
    (Element = X ->  
    	append(BlankList,["x"], C);
    	append(BlankList, [X], C)).
    	

		
		
%Print the list as a square, This is also can take two input I and I1 those means is "index", and when user give the number in the game this card will seenable.
p([X|List], [Y|List1], I, I1, Counter) :-
    length(List, Len),  %Take lenght for check last item.
    addSpace(Counter), %Add space and "\n" between the list element for make square
    (Len = 1 ->  lastItemOnList(I, I1, Counter, X, Y);
    (I = -1 ->  %If I is -1 then write all X that X is 1,2....,16
    	write(X), Counter1 is Counter +1, p(List, List1, I, I1, Counter1);
    (I1 = Counter ->  %If I1 is -1 then write Y and that a a spesific letter. This mean it make seenable the card.
    	write(Y), Counter1 is Counter +1, p(List, List1, I, I1, Counter1);
    (I = Counter ->  %If I is -1 then write Y and that a a spesific letter. This mean it make seenable the card.
    	write(Y), Counter1 is Counter +1, p(List, List1, I, I1, Counter1);
    	write(X), Counter1 is Counter +1, p(List, List1, I, I1, Counter1))))).  %Else write  X that X is 1,2....,16

%Helper for function p, This decide which element that in list  is last
lastItemOnList(I,I1, Counter, X, Y):-
    (I = Counter ->  
    	write(Y);
    (I1 = Counter ->  
    	write(Y);
    	write(X))).
		
%Helper for function p, This decide when write "\n and " " on the screen
addSpace(I):-
    (I = 4  ->  write("\n ");
    (I = 8  ->  write("\n ");
    (I = 12 ->  write("\n ");
    (I = 16 ->	write("\n ");
     write(" "))))).


	 
	 
%Delete the given index item in the list
del(X,[X|Tail],Tail).
del(X,[Y|Tail],[Y|Tail1]):-
    del(X,Tail,Tail1).

%Return item in the list for given index
indexof(Index, Item, List):-
  nth1(Index, List, Item).

  
  
  
%Single Player Function
singlePlayer(L,L2, Step):-
	List = [a,a,b,b,c,c,d,d,e,e,f,f,g,g,h,h], %The fronts of game cards
    length(L, Len), %Check length for end the game
	write("\n\n"), p(L2, List, -1, -1, 0), %Print the game card
    (Len = 0 ->  %If Len is 0 then the game is end.
    	write("\nYou win!\n."), write("\nYou finished in "), write(Step), write(" steps.") ;
	write("\nPlease input first card number.:\n."),  % Ask first card number 
    read(Card1), indexof(Card1,Card11,List), 
    p(L2, List, Card1, -1, 1),  %Flip and print the game card
	write("\nPlease input second card number.:\n."), %Ask second card number 
    read(Card2), indexof(Card2,Card22,List),
    p(L2, List, Card1, Card2, 1), %Flip and print the game card
	(Card1 = Card2 -> 
    	write("\n.Please input different card numbers.\n."), singlePlayer(L, L2, Step);
	(Card11 = Card22 -> %If the cards front side is same
    	write("\n.Good job you find  two same cards\n."), Step1 is 1 + Step, %Increase the Step for print at the end game
    	del(Card1, L, Tail), del(Card2, Tail, Tail2), %Delete the index of the matching cards
    	replace(Card1,L2,[],L22), replace(Card2,L22,[],L222),  %Flip the cards on the desk and save it in another list for print next time
    	singlePlayer(Tail2,L222,Step1); 
	write("\nOpps! Wrong choose.\n."), Step1 is 1 + Step , singlePlayer(L, L2,Step1)) %If no maching just increase Step and continue the game
			)).
			
%Two Player Function			
twoPlayer(L,L2,Score1,Score2,Turn):-
	List = [a,a,b,b,c,c,d,d,e,e,f,f,g,g,h,h], %The fronts of game cards
	length(L, Len),  %Check length for end the game
	write("\n\n"), p(L2, List, -1, -1, 0),  %Print the game card
	(Len = 0 ->   %If Len is 0 then the game is end.
		(Score1 > Score2 -> write("\nPlayer1 is winner!\n.");
		(Score2 > Score1 -> write("\nPlayer2 is winner!\n.");
		(Score1 = Score2 -> write("\nDRAW!!!Both of you are winner!!!\n."))));
	(Turn = 1 -> write("\nPlayer1 turn."), %Check which player turn
		write("\nPlease input first card number.:\n."), read(Card1),write(Card1 + " --- "),indexof(Card1,Card11,List),p(L2, List, Card1, -1, 1), %Flip and print the game card %Flip and print the game card
		write("\nPlease input second card number.:\n."), read(Card2),write(Card2 + " --- "), indexof(Card2,Card22,List),p(L2, List, Card1, Card2, 1), %Flip and print the game card
			(Card1 = Card2 -> 
				write("\nPlease input different card numbers.\n."), 
				twoPlayer(L,L2,Score1, Score2, Turn);
			(Card11 = Card22 ->  %If the cards front side is same
            	write("\nGood job you find  two same cards\n."), 
				Turn1 is 2, Score11 = 1 + Score1, %Increase Score1 thats player1's score
				del(Card1, L, Tail), del(Card2, Tail, Tail2),  %Delete the index of the matching cards
				replace(Card1,L2,[],L22), replace(Card2,L22,[],L222), %Flip the cards on the desk and save it in another list for print next time
				twoPlayer(Tail2,L222,Score11,Score2,Turn1);
			write("\nOpps! Wrong choose.\n."), Turn1 is 2 , twoPlayer(L,L2,Score1,Score2, Turn1))); %If no maching just increase Step and continue the game
	(Turn = 2 -> write("\nPlayer2 turn."), %Check which player turn
		write("\nPlease input first card number.:\n."), read(Card1), indexof(Card1,Card11,List), p(L2, List, Card1, -1, 1),
		write("\nPlease input second card number.:\n."), read(Card2), indexof(Card2,Card22,List),p(L2, List, Card1, Card2, 1),
			(Card1 = Card2 -> 
				write("\nPlease input different card numbers.\n."), 
				twoPlayer(L,L2,Score1, Score2, Turn);
			(Card11 = Card22 -> 
				write("\nGood job you find  two same cards\n."), 
				Turn1 is 1, Score22 = 1 + Score2, del(Card1, L, Tail), 
				del(Card2, Tail, Tail2), 
				replace(Card1,L2,[],L22), replace(Card2,L22,[],L222), 
				twoPlayer(Tail2,L222,Score1,Score22, Turn1);
			write("\nOpps! Wrong choose.\n."), Turn1 is 1 , twoPlayer(L,L2,Score2, Turn1))
	)))).
	
	
main(L):-
	write("Please select player numbers : \n1. Single Player \n2. Two Player \n3. Exit\n"),
	read(Operation),
	(Operation is 1 ->  singlePlayer(L,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,x],0);
	(Operation is 2 -> twoPlayer(L,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,x],0,0,1);
	(Operation is 3 -> write("Goodbye");
	write("Goodbye")))).

start():- % Use that for start the game
	main([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]).