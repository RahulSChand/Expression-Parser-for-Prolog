%Here The variable Name does not stand for its literal meaning , that is  two studnets in this model cannot have the same "Name" .
%Name here corresponds to the ID of a studnet , but for simplicity common names have been used.

%Helper Functions-------Concatenates two Lists---------------------------------------------------------------.

append([],L,L).
append([H|T],L2,[H|T2]):-append(T,L2,T2).

%-----------------------------------------------------------------------------------------.

%student(Name,Current_Semester,fees_paid,Courses_to_do,Branch_number=1,2,3)-----------------------.
%1=Computer Scinece , 2= EEE , 3=Maths+EEE.
%For dual degree student (Course number=3) , Courses to do is represneted as list of lists , with 1st element being the courses he has to do.
% on his first degree(Msc) and the other on his second degree.

student(trump,4,1,[math4,dd2,disco2,logic2],1).             
student(naruto,4,1,[math4,dd2,ed2,emac2],2).				   	 
student(mickeymouse,2,1,[math2,bio2,chem2,meow2],2).
student(chand,5,1,[algebra1,dd1,ed1,emac1],3).

%-----------------------------------------------------------------------------------------------------.

fees_paid(Name):-student(Name,_,1,_,_).

%-------Grade Sheet withdrawn or not-------------.

grad_sheet_withheld(mickeymouse).
%grad_sheet_withheld(name).

%ps1 completed or not-----------------------------------------------------------------------.

ps_1_complete(chand).

%-------Course Students Have Done f=first degree,h=higher degree-------------.							
															
course_Done(trump,[math1,math2,math3,bio1,bio2,chem1,chem2,meow1,meow2,dd1,disco1,logic1],f).
course_Done(naruto,[math1,math2,math3,bio1,bio2,chem1,chem2,meow1,meow2,dd1,ed1,emac1],f).
course_Done(mickeymouse,[math1,bio1,chem1,meow1],f).
course_Done(chand,[math1,math2,math3,math4,bio1,bio2,chem1,chem2,meow1,meow2],f).
course_Done(chand,[opt1,opt2,calculus1,calculus2,dm1,dm2],h).

%--------------Course according to semester----------------------------------.
%---------------course_sem(Semester number,Course list,Branch_specific[-1(if not)/(1,2,3 according to brach)]).


course_sem(1,[math1,bio1,chem1,meow1],_).                      
course_sem(2,[math2,bio2,chem2,meow2],_).       				
course_sem(3,[math3,dd1,disco1,logic1],1).						
course_sem(3,[math3,dd1,ed1,emac1],2).											
course_sem(3,[math3,opt1,calculus1,dm1],3).
course_sem(4,[math4,dd2,disco2,logic2],1).
course_sem(4,[math4,dd2,ed2,emac2],2).
course_sem(4,[math4,opt2,calculus2,dm2],3).
course_sem(5,[algebra1,dd1,ed1,emac1],3).
course_sem(6,[algebra2,dd2,ed2,emac2],3).


%----------Course Prerequiste-------------------------------.
pre_req(math1,[]).
pre_req(math2,[math1]).
pre_req(math3,[math2,math1]).
pre_req(math4,[math1,math2,math3]).
pre_req(bio1,[]).
pre_req(bio2,[bio1]).
pre_req(chem1,[]).
pre_req(chem2,[chem1]).
pre_req(meow1,[]).
pre_req(meow2,[meow1]).
pre_req(dd1,[]).
pre_req(dd2,[dd1]).
pre_req(disco1,[]).
pre_req(disco2,[disco1]).
pre_req(logic1,[]).
pre_req(logic2,[logic1]).
pre_req(ed1,[]).
pre_req(ed2,[ed1]).
pre_req(emac1,[]).
pre_req(emac2,[emac1]).
pre_req(opt1,[]).
pre_req(opt2,[opt1]).
pre_req(calculus1,[]).
pre_req(calculus2,[calculus1]).
pre_req(dm1,[]).
pre_req(dm2,[dm1]).
pre_req(algebra1,[]).
pre_req(abcd,[]).
%----------------Cousre Belongs to Which Degree-------------------------------------------------------.
course_details(math1,_).
course_belong(bio1,_).
course_belong(chem1,_).
course_belong(meow1,_).

course_belong(math2,_).
course_belong(bio2,_).
course_belong(chem2,_).
course_belong(meow2,_).

course_belong(math3,_).
course_belong(dd1,1).
course_belong(disco1,1).
course_belong(logic1,1).
course_belong(ed1,1).
course_belong(emac1,1).
course_belong(opt1,2).
course_belong(calculus1,2).
course_belong(dm1,2).

course_belong(math4,_).
course_belong(dd2,1).
course_belong(disco2,1).
course_belong(logic2,1).
course_belong(ed2,1).
course_belong(emac2,1).
course_belong(opt2,2).
course_belong(calculus2,2).
course_belong(dm2,2).


%----------Course Details-----------------------------------.
%----------course_belong(Course_Name,Monday/Tuesday_Series,Hour_of_the_day).--------------------.
%-----------------------------------------------------1 for Monday_Series, 2 for Tuesday_Series------------------.

course_details(math1,1,4).
course_details(bio1,1,5).
course_details(chem1,2,4).
course_details(meow1,2,5).

course_details(math2,1,4).
course_details(bio2,1,5).
course_details(chem2,2,4).
course_details(meow2,2,5).

course_details(math3,1,4).
course_details(dd1,1,5).
course_details(disco1,2,4).
course_details(logic1,2,5).
course_details(ed1,2,4).
course_details(emac1,2,5).
course_details(opt1,2,4).
course_details(calculus1,2,5).
course_details(dm1,1,5).

course_details(math4,1,4).
course_details(dd2,1,5).
course_details(disco2,2,4).
course_details(logic2,2,5).
course_details(ed2,2,4).
course_details(emac2,2,5).
course_details(opt2,2,4).
course_details(calculus2,2,5).
course_details(dm2,1,5).


%is_dual takes the branch number as term.
is_dual(3).
%is_dual takes the branch number as term.
is_not_dual(1).
is_not_dual(2).




%-------------If there is a course in which student is trying to register which he has already done-----------------------------------------------------------.

already_not_done(Name):-courses_done_1(Name,Coursedone),if_not_done_before(Name,Coursedone).

if_not_done_before(Name,Coursedone):-student(Name,_,_,Course_list,_),similiar(Course_list,Coursedone).

similiar([],_).
similiar(_,[]).
similiar([H|T],Coursedone):-not(member(H,Coursedone)),similiar(T,Coursedone).



%-----Course check 1------------------------------------------------------.

course_check(_,[]).
course_check([],_).
course_check(Name,[H|T]):-check_specif_course_pre_requiste(Name,H),course_check(Name,T).

%---------------------------------------------------------------------------.


courses_done_1(Name,X):-student(Name,_,_,_,Branch),is_not_dual(Branch),course_Done(Name,X,f).
courses_done_1(Name,X):-student(Name,_,_,_,Branch),is_dual(Branch),course_Done(Name,X1,f),course_Done(Name,X2,h),append(X1,X2,X).

%-----------Check specific course(Check prerequiste for a specific course------------.

check_specif_course_pre_requiste(Name,C):-pre_req(C,Small),courses_done_1(Name,Big),final_check(Big,Small).

%-----FInal check function---------------------.

final_check(_,[]).
final_check([],_).
final_check(All_course,[H|T]):-member(H,All_course),final_check(All_course,T).

%Checking if Semester is Complete or Not---------------------------------------------------------.

all_semesters_clear(_,0,_).

all_semesters_clear(Name,Sem,Branch):-is_not_dual(Branch),check_course_for_sem_normal(Name,Sem,Branch),Sem2 is Sem-1,all_semesters_clear(Name,Sem2,Branch).
all_semesters_clear(Name,Sem,Branch):-is_dual(Branch),check_course_for_sem_dual(Name,Sem,Branch),Sem2 is Sem-1,all_semesters_clear(Name,Sem2,Branch).

%----------------------------General Predicate to Check if a given semester has been cleared----------------------------------------.

check_if_semester_cleared(Name,Sem_number):-student(Name,_,_,_,Branch),is_dual(Branch),check_course_for_sem_dual(Name,Sem_number,Branch).
check_if_semester_cleared(Name,Sem_number):-student(Name,_,_,_,Branch),is_not_dual(Branch),check_course_for_sem_normal(Name,Sem_number,Branch).

%---------------------------------------------------------------------------------------------------------------.
check_course_for_sem_normal(Name,Sem_number,Branch):-course_sem(Sem_number,Smaller,Branch),course_Done(Name,Bigger,f),final_check2(Bigger,Smaller).
check_course_for_sem_normal_dual_second(Name,Sem_number,Branch):-course_sem(Sem_number,Smaller,Branch),course_Done(Name,Bigger,h),final_check2(Bigger,Smaller).
check_course_for_sem_dual(Name,Sem_number,Branch):-course_sem(Sem_number,Smaller,Branch),course_Done(Name,Bigger,f),course_Done(Name,Bigger2,h),append(Bigger,Bigger2,Bigger3),final_check2(Bigger3,Smaller).


final_check2(_,[]).
final_check2([],_).
final_check2(Big,[H|T]):-member(H,Big),final_check2(Big,T).

%------------------Can Do Higer Degree or Not----------------------------------------------------------------------------------------.

%---------------------------------------------------------------------------------------------------------------------------.

check_if_higher_on_first(Name,Branch,f,Course_name):-check_specif_course_pre_requiste(Name,Course_name),all_semesters_clear(Name,4,Branch).
check_if_higher_on_second(Name,3,h,Course_name):-check_specif_course_pre_requiste(Name,Course_name),all_semesters_clear(Name,6,3).

%-------------Check if it can apply for core course of another branch ---------------------------------------.

check_if_core(Name,Course_name,Branch):-check_specif_course_pre_requiste(Name,Course_name),all_semesters_clear(Name,2,Branch).

%Completed previous semesters ----------------------------------------------------------------------------------.

completed_semester(Name):-student(Name,Sem,_,_,Branch),Sem2 is Sem-1,all_semesters_clear(Name,Sem2,Branch).

%----------------------Predicate know if a student has completed all of his Prerequistes--------------------------------------------.

course_pre_requsite(Name):-student(Name,_,_,Course_list,_),course_check(Name,Course_list).

%--------------------Core Course of Another Degree----------------------------------------------------------------------.

core_course_another_degree(Name,Course):-student(Name,_,_,_,Branch),check_if_core(Name,Course,Branch).

%-----------------------------------------------------------------------------------------------------.



%First Degree studnet can do a Higher Degree course------------------------------------------------------.
%Since a dualite studnet can take a higher course in both his first Degree and his secomd degree therefore the user must provide that detal.
%in the field Which_Degree_For_Higher.

higher_degree_course(Name,Which_Degree_For_Higher,Course_name):-already_not_done(Name),student(Name,_,_,_,Branch),Which_Degree_For_Higher==f,check_if_higher_on_first(Name,Branch,f,Course_name).
higher_degree_course(Name,Which_Degree_For_Higher,Course_name):-already_not_done(Name),student(Name,_,_,_,Branch),Which_Degree_For_Higher==h,is_dual(Branch),check_if_higher_on_second(Name,Branch,h,Course_name).

%---------------------Predicate to check if Student is eligible for Registration in the Course--------------.

registration(Name):-student(Name,_,_,_,_),not(grad_sheet_withheld(Name)),fees_paid(Name),completed_semester(Name),course_pre_requsite(Name),already_not_done(Name).

%------------------To know if the Student is eligible for applying for Practice School-----------------------.

ps_eligible_1(Name):-student(Name,Semester,_,_,_),not(grad_sheet_withheld(Name)),Semester==4,completed_semester(Name).
ps_eligible_2(Name):-student(Name,Semester,_,_,_),not(grad_sheet_withheld(Name)),ps_1_complete(Name),Semester==7,completed_semester(Name).
ps_eligible_2(Name):-student(Name,Semester,_,_,_),not(grad_sheet_withheld(Name)),ps_1_complete(Name),Semester==8,completed_semester(Name).


which_course(Course_Name,Value):-course_belong(Course_Name,Value).



