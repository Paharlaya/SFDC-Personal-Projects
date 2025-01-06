public class ContactTriggerHandler {
    public static void sendEmail(List<Contact> conList){
        
        List<Messaging.Email> emailList = new List <Messaging.Email>(); //list of email
        
        for(Contact con : conList){
            
            if(con.Email != null){
                
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[] {con.Email};
                emailMsg.setToAddresses(toAddress);
                String emailSub = 'Welcome' + con.Firstname;
                emailMsg.setSubject(emailsub);
                String disName = 'Paharlaya Basnet';
                emailMsg.setSenderDisplayName(disName);
                
                String content = 'Hi' + con.FirstName + ',<br/> <br/>' + 
                    'Welcome to salesForce EcoSystem <br/> <br/>' +
                    'Email triggered through apexclass named ContactTriggerhandler';
                emailMsg.setHtmlBody(content);
                
                emailList.add(emailMsg);
            }
        }
        
        Messaging.sendEmail(emailList);
    }
}