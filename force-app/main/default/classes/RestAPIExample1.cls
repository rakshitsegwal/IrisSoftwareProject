// Apex HTTP class is used to make HTTP requests
// Ensure you have the necessary Remote Site Settings configured for the API URL

public class RestAPIExample1 {
    public static void hitRestAPI() {
        // Create an HTTP request object
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://fakestoreapi.com/products');
        request.setMethod('GET');
        
        // Create an HTTP object to send the request
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        // Parse and process the response
        if (response.getStatusCode() == 200) {
            String responseBody = response.getBody();
            // Handle the response data as per your requirement
            System.debug(responseBody);
        } else {
            System.debug('HTTP request failed with status code: ' + response.getStatusCode());
        }
    }
}