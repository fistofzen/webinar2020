using {
   
    opensap.MD as my
} from '../db/schema';

 
service test1Service {
    entity Employees as projection on my.Employees;
    entity Adresses as projection on my.Addresses;
    view TurkishEmployees   as select from my.TurkishEmployees  ;
    function loadEmployeeImages() returns Boolean;
}