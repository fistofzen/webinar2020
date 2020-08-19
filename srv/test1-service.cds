using {  
 webinar2020.MasterData as my
} from '../db/schema';

 
service test1Service {
    entity Employees as projection on my.Employees;
    entity Adresses as projection on my.Addresses;
    view TurkishEmployees   as select from my.TurkishEmployees  ;
    view EmployeeStatus as select from my.EmployeeStatus;
    function loadEmployeeImages() returns Boolean; 
}