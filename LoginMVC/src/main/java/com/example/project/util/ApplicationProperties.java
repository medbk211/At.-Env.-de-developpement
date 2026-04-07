package com.example.project.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.Properties;

public final class ApplicationProperties {

    private static final Properties PROPERTIES = loadProperties();

    private ApplicationProperties() {
    }

    public static String get(String key, String defaultValue) {
        String envKey = key.toUpperCase(Locale.ROOT).replace('.', '_');
        String envValue = System.getenv(envKey);
        if (envValue != null && !envValue.isBlank()) {
            return envValue.trim();
        }

        String value = PROPERTIES.getProperty(key);
        return value == null || value.isBlank() ? defaultValue : value.trim();
    }

    private static Properties loadProperties() {
        Properties properties = new Properties();

        try (InputStream inputStream = ApplicationProperties.class
                .getClassLoader()
                .getResourceAsStream("application.properties")) {

            if (inputStream != null) {
                properties.load(inputStream);
            }
        } catch (IOException e) {
            throw new IllegalStateException("Unable to load application.properties.", e);
        }

        return properties;
    }
}
