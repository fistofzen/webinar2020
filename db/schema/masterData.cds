using {  
Currency,
managed,
temporal,
sap,
cuid
} from '@sap/cds/common';
using { webinar.common } from './common';

namespace  webinar2020.MasterData;

entity Addresses : cuid, temporal {
    city        : String(40);
    postalCode  : String(10);
    street      : String(60);
    building    : String(10);
    country     : Association to one sap.common.Countries;
    region      : String(4);
    addressType : String(2);
    latitude    : Double;
    longitude   : Double;
}

annotate Addresses with  {
    ID          @title : '{i18n>addressId}';
    city        @title : '{i18n>city}';
    postalCode  @title : '{i18n>postalCode}';
    street      @title : '{i18n>street}';
    building    @title : '{i18n>building}';
    country     @title : '{i18n>country}';
    region      @title : '{i18n>region}';
    addressType @title : '{i18n>addressType}';
    latitude    @title : '{i18n>latitude}';
    longitude   @title : '{i18n>longitude}';
};

entity Employees : cuid{
    nameFirst      : String(40);
    nameMiddle     : String(40);
    nameLast       : String(40);
    nameInitials   : String(10);
    sex            : common.Gender;
    language       : String(1);
    phoneNumber    : common.PhoneNumber;
    email          : common.Email;
    loginName      : String(12);
    @cascade : {all}
    address        : Composition of one Addresses;
    currency       : Currency;
    salaryAmount   : Decimal(15, 2);
    accountNumber  : String(10);
    bankId         : String(10);
    bankName       : String(255);
    employeePicUrl : String(255);
    partnerRole    : Integer;
}
annotate Employees with  {
    ID             @title : '{i18n>employeeId}';
    nameFirst      @title : '{i18n>fname}';
    nameMiddle     @title : '{i18n>mname}';
    nameLast       @title : '{i18n>lname}';
    nameInitials   @title : '{i18n>initials}';
    language       @title : '{i18n>language}';
    loginName      @title : '{i18n>loginName}';
    address        @title : '{i18n>address}';
    salaryAmount   @title : '{i18n>salaryAmount}';
    accountNumber  @title : '{i18n>accountNumber}';
    bankId         @title : '{i18n>bankId}';
    bankName       @title : '{i18n>bankName}';
    employeePicUrl @title : '{i18n>employeePicUrl}';
    partnerRole    @title : '{i18n>partnerRole}';
};


define view TurkishEmployees as
    select from Employees as emp {
        key nameFirst,
        nameLast,
        address.ID   as addid,
        address.city as CITY
    }
    where
        'Turkey' = address.city;

define view EmployeeStatus as
    select from Employees as emp {
            @UI.lineItem       : [{importance : Importance.High}]
            @UI.fieldGroup     : [{position : 10}]
            @EndUserText.label : [{
                language : 'EN',
                text     : 'Employee ID'
            }]
        key ID,
            @UI.lineItem       : [{importance : Importance.High}]
            @UI.fieldGroup     : [{position : 20}]
            @EndUserText.label : [{
                language : 'EN',
                text     : 'Role Name'
            }]
            case
                when
                    partnerRole = 1
                then
                    'Internal'
                when
                    partnerRole = 2
                then
                    'External'
            end as partnerdesc : String,
    };
  

define view EmployeesTypes with parameters IM_PR : String(1) as
    select from Employees {
        ID,
        nameLast,
        nameLast email,
        bankName
    }
    where
        partnerRole = : IM_PR;