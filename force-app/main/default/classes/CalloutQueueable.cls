public class CalloutQueueable implements Queueable {
    private String endpoint = 'https://api.example.com/data'; // Replace with your actual API endpoint URL

    public void execute(QueueableContext context) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET'); // Replace with the appropriate HTTP method (GET, POST, etc.)
        
        // If needed, you can set headers, parameters, and payload for your request
        // request.setHeader('Authorization', 'Bearer YourAccessToken');
        // request.setBody('YourRequestBody');

        HttpResponse response = new Http().send(request);

        if (response.getStatusCode() == 200) {
            // Process the successful response here
            String responseBody = response.getBody();
            System.debug('Callout Response: ' + responseBody);
        } else {
            // Handle the error response here
            String errorMessage = 'Callout failed with status code: ' + response.getStatusCode();
            System.debug(errorMessage);
        }
    }
}