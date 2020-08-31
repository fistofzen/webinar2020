using {  
 webinar2020.MasterData1 as my1
} from '../db/schema';

 
service test1Service {
    entity Employees as projection on my1.Employees;
//    entity Addresses as projection on my1.Addresses;
//    view TurkishEmployees   as select from my1.TurkishEmployees  ;
    view EmployeeStatus as select from my1.EmployeeStatus;
    function loadEmployeeImages() returns Boolean; 
}