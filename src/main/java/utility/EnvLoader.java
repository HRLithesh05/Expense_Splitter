package utility;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

public class EnvLoader {
    private static Map<String, String> envVariables = new HashMap<>();
    private static boolean loaded = false;

    public static void load() {
        if (loaded) {
            return;
        }

        // Try to load from the project root first
        String projectRoot = System.getProperty("user.dir");
        String envPath = projectRoot + "/.env";
        
        try (BufferedReader reader = new BufferedReader(new FileReader(envPath))) {
            loadFromReader(reader);
            loaded = true;
            System.out.println("Environment variables loaded from: " + envPath);
        } catch (IOException e) {
            // If not found in project root, try to load from classpath
            try (InputStream is = EnvLoader.class.getClassLoader().getResourceAsStream(".env")) {
                if (is != null) {
                    try (BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {
                        loadFromReader(reader);
                        loaded = true;
                        System.out.println("Environment variables loaded from classpath");
                    }
                } else {
                    System.err.println("Warning: .env file not found. Using default values or system environment variables.");
                    loaded = true; // Mark as loaded to prevent repeated attempts
                }
            } catch (IOException ex) {
                System.err.println("Error loading .env file: " + ex.getMessage());
                loaded = true;
            }
        }
    }

    private static void loadFromReader(BufferedReader reader) throws IOException {
        String line;
        while ((line = reader.readLine()) != null) {
            line = line.trim();
            // Skip empty lines and comments
            if (line.isEmpty() || line.startsWith("#")) {
                continue;
            }
            // Parse key=value pairs
            int separatorIndex = line.indexOf('=');
            if (separatorIndex > 0) {
                String key = line.substring(0, separatorIndex).trim();
                String value = line.substring(separatorIndex + 1).trim();
                envVariables.put(key, value);
            }
        }
    }

    public static String get(String key) {
        if (!loaded) {
            load();
        }
        // First check our loaded env variables
        String value = envVariables.get(key);
        // If not found, check system environment variables
        if (value == null) {
            value = System.getenv(key);
        }
        return value;
    }

    public static String get(String key, String defaultValue) {
        String value = get(key);
        return (value != null) ? value : defaultValue;
    }
}
