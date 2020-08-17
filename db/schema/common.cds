using {    
 cuid,
 Currency,
 Country,
 temporal,
 managed,
 Language
} from '@sap/cds/common';



extend sap.common.Currencies with {
numcode:Integer;
   exponent: Integer;
    minor:String

}


extend sap.common.Countries with {
    code1 : Integer;
    alpha3: String(3);
    iso: String(16);
    regions : Composition of many sap.common_countries.Regions on regions.country = $self.code;
}



context webinar.common {
    type BusinessKey : String(10);
    type SDate: DateTime;
  type Gender : String(1) enum {
    male         = 'M';
    female       = 'F';
    nonBinary    = 'N';
    noDisclosure = 'D';
    selfDescribe = 'S';
  }
  annotate Gender with @(
    title       : '{i18n>gender}',
    description : '{i18n>gender}',
    assert.enum
  );
  type Email : String(255)@title : '{i18n>email}'  @assert.format : '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'; 
  type PhoneNumber : String(30)@title : '{i18n>phoneNumber}'  @assert.format : '((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))';


    abstract entity Amount  {
        currency : Currency;
    }
}



annotate temporal with {
  validFrom @(title : '{i18n>validFrom}');
  validTo   @(title : '{i18n>validTo}');
}



context sap.common_countries {
    entity Regions {
        key country     : String(3);
        key sub_code    : String(5);
            toCountries : Association to one sap.common.Countries
                              on toCountries.code = $self.country;
            name        : String(80);
            type        : String(80);
    }
    annotate Regions with {
        country  @(
            title        : '{i18n>country}',
            Common.Label : '{i18n>country}'
        );
        sub_code @(
            title        : '{i18n>country}',
            Common.Label : '{i18n>country}'
        );
        name     @(
            title               : '{i18n>name}',
            Common.FieldControl : #Mandatory,
            Seacrh.defaultSearchElement,
            Common.Label        : '{i18n>name}'
        );
        type     @(
            title        : '{i18n>type}',
            Common.Label : '{i18n>type}'
        );
    }
}


