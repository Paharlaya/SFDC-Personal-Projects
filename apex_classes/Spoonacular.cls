public class Spoonacular {
    
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
	 private static final String API_KEY=  'c0a5ff6291c5480fbd7001116b21e335';
    public static void getRandomRecipe(){
        Http http = new Http();
        HttpRequest request= new HttpRequest();
    	request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
		request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        //if the request is successful
        System.debug('reponse code' +response.getStatusCode());
        
        if(response.getStatusCode() == 200){
            System.debug('response :' +response.getBody());
        }
            
    }
    
      public static void getRecipe(String recipeId){
        Http http = new Http();
        HttpRequest request= new HttpRequest();
    	request.setEndpoint(SPOONACULAR_API+'/recipes/'+recipeId+'/information?apiKey='+API_KEY);
          //https://api.spoonacular.com/recipes/{id}/information
		request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        //if the request is successful
        System.debug('reponse code' +response.getStatusCode());
        
        if(response.getStatusCode() == 200){
            System.debug('response :' +response.getBody());
        }
            
    }
      public static void getRecipeByIngredients(String ingredients){
        Http http = new Http();
        HttpRequest request= new HttpRequest();
    	request.setEndpoint(SPOONACULAR_API+'/recipes/findByIngredients?apiKey='+API_KEY+'&ingredients='+ingredients);
          //https://api.spoonacular.com/recipes/findByIngredients
		request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        //if the request is successful
        System.debug('reponse code' +response.getStatusCode());
        
        if(response.getStatusCode() == 200){
            System.debug('response :' +response.getBody());
        }
            
    }
}