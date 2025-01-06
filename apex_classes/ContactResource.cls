@RestResource(urlMapping='/ContactAPI/*')
global with sharing class ContactResource {
 
    @HTTPGet

    global static List<Contact> getContactIdAndNames(){
        //Initializing the request parameter with the incoming request

        RestRequest contactRequest = RestContext.request;

        //getting the request URI

        String contactRequestURI = contactRequest.requestURI;

        //Getting the limit from the request URI

        Integer contactLimit = Integer.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1));

        //Quering Contacts

        List<Contact> contactList = [SELECT Id,Name FROM Contact LIMIT :contactLimit];

        //returning contact in response
      return contactList;

    }
    
    //post method
    //workbench to org
    //this is the parameter mway of doing it
    @HTTPPost 

    global static Contact createNewContact(
    String firstName, 
    String lastName, 
    String birthDate, 
    String leadSource){

      //Initializing the contact

      Contact contact = new Contact(); 
      contact.FirstName = firstName;
      contact.LastName = lastName;
      contact.Birthdate = Date.parse(birthDate); //date format 09/09/2001
      contact.LeadSource = leadSource;

      //Inserting Cotnact 
      insert contact;
      //returning
      return contact;

    }

    //Delete method
    //deleting from workbench

    @HTTPDelete

    global static Map<String,String> deleteContact(){
      //Initializing the response map
      Map<String,String> responseMap = new Map<String,String>();

      RestRequest contactRequest = RestContext.request;

      String contactRequestURI = contactRequest.requestURI;

      Id contactId = Id.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/')+1));

      Contact contact = new Contact(Id=contactId);

      //deleting contact

      try {
        delete contact;
        responseMap.put('success', '1');
        responseMap.put('message', 'Record Deleted Successfully');
    } catch(DmlException ex) {
        responseMap.put('success', '0');
        responseMap.put('message', ex.getMessage());
    }

      return responseMap;

    }

    @HTTPPatch

    global static Contact updateContact(){

      RestRequest contactRequest = RestContext.request;

      String contactURIrequest  =contactRequest.requestURI;

      String ContactId = contactURIrequest.substring(contactURIrequest.lastIndexOf('/')+1);

      String requestBody = contactRequest.requestBody.toString();

      Contact contact;
      
      if(String.isNotEmpty(ContactId)){

        contact = (contact) JSON.deserialize(requestBody, Contact.class);

        contact.Id = ContactId;

        update contact;
    }

      

      return contact;
    }

    //put method
  
    @HTTPPut

    global static Contact upsertContact(String firstName,String lastName,String birthDate,String leadSource){

      RestRequest contactRequest = RestContext.request;

      String contactRequestURI = contactRequest.requestURI;

      String contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);

      Contact contact = new Contact();

      if(String.isNotEmpty(ContactId)){
        contact.Id = ContactId;
      }

      contact.FirstName = firstName;
      contact.LastName = lastName;
      contact.Birthdate = Date.parse(birthDate);
      contact.LeadSource = leadSource;

      upsert contact;

      return contact;
    }

}