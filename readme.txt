2015A7PS163P - Rahul Shiv Chand
2015A7PS116P - Abhishek V Joshi

Problem 1.

---Note : Invoking the query requires x/y/z or any other variables as "1x","1y","1z"..,and brackets as "(",")",
---------and division operator as "/".
---Note : The grammar we have written to parse the expressions resembles the BODMAS rule of simple arithmetic. Hence the order of precedence goes like
--------- division > multiplication > addition > subtraction.
--------- so the expression in example 4, i.e. 5X-X+2X is parsed as 5X-(X+2X).
--------- To override it and get the correct answer parentheses must be used like that in example 5.
--------- Kindly use parantheses to parse the expression as desired, because of the original precedence as stated above.

1)
Input =(2*X+X-X).
Invoking query   :   normalize(Parse,[2,*,"1x",+,"1x",-,"1x"],[],Ans).
Output:            Parse = sub(add(mul(2, "1x"), "1x"), "1x"),
                   Ans = '2x'

2)
Input=(2*X/X).
Invoking query:  normalize(Parse,[2,*,"1x","/","1x"],[],Ans).
Output:		  Parse = mul(2, divide("1x", "1x")),
		  Ans = 2

3)
Input=((X+X)/X)*(Y+Y-Y).
Invoking query       :  normalize(Parse,["(","(","1x",+,"1x",")","/","1x",")",*,"(","1y",+,"1y",-,"1y",")"],[],Ans).
Output:			Parse = mul(divide(add("1x", "1x"), "1x"), sub(add("1y", "1y"), "1y")),
			Ans = '2y'

4)
Input = 5*X-X+2*X
Invoking query: 	normalize(Parse,[5,*,"1x",-,"1x",+,2,*,"1x"],[],Ans).
Output:         	Parse = sub(mul(5, "1x"), add("1x", mul(2, "1x"))),
			Ans = '2x'

5)
Input : (5*X-X)+2*X
Invoking query:		normalize(Parse,["(",5,*,"1x",-,"1x",")",+,2,*,"1x"],[],Ans).
Output:			Parse = add(sub(mul(5, "1x"), "1x"), mul(2, "1x")),
			Ans = '6x'

6)
Input= (X*(Y/Y)-X)*X
Invoking query : normalize(Parse,["(","1x",*,"(","1y","/","1y",")",-,"1x",")",*,"1x"],[],Ans).
Output : Parse = mul(sub(mul("1x", divide("1y", "1y")), "1x"), "1x"),
	Ans = 0 





Problem 2.

-----List of predicates that can be used-------------------------.

1)ps_eligible_1(Student_Name) :- true if student is eligible for PS1.
2)ps_eligible_2(Student_Name) :- true if student is eligible for PS2.
3)registration(Student_Name) :- true if he/she can register for the aforementioned semester.
4)higher_degree_course(Student_Name,B.E.(f)/MSc.(h),Higher_Degree_Course_Name) :- true if he/she is eligible to register for the mentioned higher degree course
5)core_course_another_degree(Student_Name,Course_Name) :- true if eligible
6)course_pre_requsite(Student_Name) :- true if all the pre-requisites for the current semester has been completed
7)completed_semester(Student_Name) :- true if previous semesters have been completed
8)check_specif_course_pre_requiste(Student_Name,Course_Name) :- true if the given student has completed pre-requisite for the given course
9)already_not_done(Student_Name) :- true if one isn't repeating a previously completed course
10)is_dual(Course_Number) :- true if student is offered for a dual degree
11)is_not_dual(Course_Number) :- true if student is offered for a single degree
12)pre_req(Course_Name,X) :- returns the pre-requisites for the given course as X
13)course_done(Student_Name,X,B.E.(f)/MSc.(h)) :- returns the list of courses previously completed as X
14)grade_sheet_withheld(Student_Name) :- true if student's grade sheet has been withheld
15)fees_paid(Student_Name) :- true if fees have been paid

-----------Rest of the predicates play the role of helpers(Can be called for debugging and cheking the internal structure of our model)--------------.

Pre_defined_students 
1)trump
2)mickeymouse
3)naruto
4)chand

Input/Output
Input:registration(chand)
Output:true

Input:ps_eligible_1(trump)
Output:true

Input:ps_eligible_2(naruto)
Output:false.

----------------------------------------------------------------------------------------------------------------.-------------------------------------------.


