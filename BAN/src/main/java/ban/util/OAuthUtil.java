package ban.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets.Details;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.calendar.CalendarScopes;

public class OAuthUtil {

    private static final String APPLICATION_NAME = "BAN";
    
    private static final java.io.File DATA_STORE_DIR = new java.io.File(System.getProperty("user.home"), ".credentials/calendar-ban.json");
 
    private static FileDataStoreFactory DATA_STORE_FACTORY;
 
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();    
 
    private static final List<String> SCOPES = Arrays.asList(CalendarScopes.CALENDAR);

    private static HttpTransport HTTP_TRANSPORT;
 
    static {
        try {
            HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
            DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
        } catch (Throwable t) {
            t.printStackTrace();
            System.exit(1);
        }
    }
    
    public static Credential authorize() throws IOException, GeneralSecurityException {
        // Load client secrets.
        InputStream in = OAuthUtil.class.getResourceAsStream("/client_secret.json");
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
 
        // Build flow and trigger user authorization request.
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder( HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
															                        .setDataStoreFactory(DATA_STORE_FACTORY)
															                        .setAccessType("offline")
															                        .build();
        Details csDetail =  clientSecrets.getDetails();
        List<String> redirectUris = csDetail.getRedirectUris();
        String reDirectUri = redirectUris.get(0);
        String host = reDirectUri.substring(0, reDirectUri.lastIndexOf("/")).replace("http://", "");
        String callBackPath = reDirectUri.substring(reDirectUri.lastIndexOf("/"));
        
        Credential credential = new AuthorizationCodeInstalledApp(flow, new LocalServerReceiver.Builder().setHost(host).setCallbackPath(callBackPath).build() ).authorize("user");
        System.out.println("Credentials saved to " + DATA_STORE_DIR.getAbsolutePath());
        return credential;
    }


}

