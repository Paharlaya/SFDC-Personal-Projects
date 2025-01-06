@RestResource(urlMapping='/ContactAPI1/*')

global with sharing class contactResource1 {

    //wrapper class (response wrapper class)
    global class ResponseWrapper{
        String success;
        String message;

    }


   
    //get method

    @HTTPGet

    global static List<Contact> getContactIdNameAndLeadResource(){
        
        RestRequest contactRequest = RestContext.request;

        //getting the URL parameters from the request
        Map<String,String> contactRequestParams = contactRequest.params;

        //getting the parameter's value from the URL
        Integer contactLimit = Integer.valueOf(contactRequestParams.get('limit'));
        String leadSource = contactRequestParams.get('leadSource');
      

        //querying contacts

        List<Contact> contactList = [SELECT Id,Name,LeadSource 
                                    FROM Contact WHERE LeadSource =:leadSource 
                                    LIMIT:contactLimit];

        return contactList;                            
    }

    //post method
    //workbench to org
    //this is without parameter, can enter many fields in the request body
    @HTTPPost
   
    global static Contact createNewContact(){

        RestRequest contactRequest = RestContext.request;
        //Getting the request body from request
        //requestBody Returns or sets the body of the request.
        String requestBody = contactRequest.requestBody.toString();
        //Deserializing the JSON Response body and assignging to to an instance of object
        Contact contact = (Contact)JSON.deserialize(requestBody, Contact.class);  //date fromat "2000-09-09"
        //inserting
        insert contact;

        return contact;
    }



    @HTTPDelete

    global static List<ResponseWrapper> deleteContacts(){
        //Initailizing the reponse wrapper List
       List<ResponseWrapper> responseWrapperList = new List<ResponseWrapper>();

       RestRequest contactRequest = RestContext.request;

       String contactRequestURI = contactRequest.requestURI;

       String[] ContactIds = (contactRequestURI.substring(contactRequestURI.lastIndexOf('/') +1)).split(',');

       //Initailizing contacts list to delete
       List<Contact> contactsToDelete = new List<Contact>();
       //Adding contact in the delete list

       for(String contactId:ContactIds){
        Contact con = new Contact(Id=contactId);
        contactsToDelete.add(con);

       }

       //deleting contact with partial success enabled 
       //Database.DeleteResult : Represents the result of a delete DML operation returned by the Database.delete method.
      Database.DeleteResult[] deleteResults = Database.delete(contactsToDelete,false);
      //Checking the result of delete operation for each content

      for(Database.DeleteResult deleteResult : deleteResults){
        //initializing the reponse wrapper
        ResponseWrapper wrapper = new ResponseWrapper();

        if(deleteResult.isSuccess()){
        // Delete successful, setting up the appropriate message in response wrapper
        wrapper.success = '1';
        wrapper.message = 'Successfully deleted contact with Id :' +deleteResult.getId();

        }
        else{
         // Delete failed, getting errors and setting up the error message in response wrapper
        
         wrapper.success = '0';
        
         for(Database.Error error: deleteResult.getErrors()){

        wrapper.message = 'The following error has occured with contact Id:' +deleteResult.getId() + '.';
        wrapper.message += error.getStatusCode() + ' ' + error.getMessage() + '.';
        wrapper.message += 'Contact field that afected this error: ' + error.getFields();

         }

        }

        //Adding response wrapper instance to the responseWrapper List

        responseWrapperList.add(wrapper);     

      }

      return responseWrapperList;

    }

    //PATCH METHOD

    @HTTPPatch
    global static List<ResponseWrapper> updateContacts() {
        // Initializing the response wrapper list
        List<ResponseWrapper> responseWrapperList = new List<ResponseWrapper>();
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request body from the request
        String requestBody = contactRequest.requestBody.toString();
        // Deserializing the JSON request body and initializing the list of contacts to update
        List<Contact> contactsToUpdate = (List<Contact>) JSON.deserialize(requestBody, List<Contact>.class);
        // Updating contacts with partial success enabled
        Database.SaveResult[] updateResults = Database.update(contactsToUpdate, false);
        // Checking the result of update operation for each contact
        for(Database.SaveResult updateResult : updateResults) {
        // Initializing the response wrapper
            ResponseWrapper wrapper = new ResponseWrapper();
        // Initializing the response wrapper
            if (updateResult.isSuccess()) {
        // Update successful, setting up the appropriate message in response wrapper
                wrapper.success = '1';
                wrapper.message = 'Successfully updated contact with Id: ' + updateResult.getId();
            }
            else {
                // Update failed, getting errors and setting up the error message in response wrapper
                wrapper.success = '0';
                for(Database.Error error : updateResult.getErrors()) {
                    wrapper.message = 'The following error has occurred for contact with Id: ' + updateResult.getId() + '. ';
                    wrapper.message += error.getStatusCode() + ': ' + error.getMessage() + '. ';
                    wrapper.message += 'Contact fields that affected this error: ' + error.getFields();
                }
            }
            // Adding response wrapper instance to the response wrapper list
            responseWrapperList.add(wrapper);
        }
        // Returning the response wrapper list in the response
        return responseWrapperList;
    }

    //put

    @HTTPPut

    global static List<ResponseWrapper> upsertContact(){

        List<ResponseWrapper> responseWrapperList = new List<ResponseWrapper>();
        
        RestRequest req = RestContext.request;
        String requestBody = req.requestBody.toString();
        List<Contact> conList = (List<Contact>) JSON.deserialize(requestBody, List<Contact>.class);

        //upserting
        //The result of an upsert DML operation returned by the Database.upsert method.
        Database.UpsertResult[] upsertResults = Database.upsert(conList,false);

        for(Database.UpsertResult upsertResult : upsertResults){
            ResponseWrapper wrapper = new ResponseWrapper();
            if(upsertResult.isSuccess()){
                wrapper.success = '1';
                wrapper.message = 'Successfully upserted contact with Id :' +upsertResult.getId();
            }else{
                wrapper.success= '0';

                for(Database.Error error : upsertResult.getErrors()){
                    wrapper.message = 'The following error has occurred for contact with Id: ' + upsertResult.getId() + '. ';
                    wrapper.message += error.getStatusCode() + ': ' + error.getMessage() + '. ';
                    wrapper.message += 'Contact fields that affected this error: ' + error.getFields();
                }
            }
            responseWrapperList.add(wrapper);
            
        }

        return responseWrapperList;
    }
}