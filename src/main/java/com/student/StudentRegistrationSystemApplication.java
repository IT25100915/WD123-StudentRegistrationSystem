package com.student;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/**
 * COMPONENT 01 – Student Management | Application Entry Point
 *
 * This is the main class that boots the entire Spring Boot application.
 *
 * @SpringBootApplication is a shortcut annotation that combines:
 *   @Configuration      — marks this class as a source of Spring bean definitions
 *   @EnableAutoConfiguration — tells Spring Boot to automatically configure
 *                              beans based on the classpath (e.g., Tomcat, JDBC)
 *   @ComponentScan      — scans the 'com.student' package and all sub-packages
 *                         for @Controller, @Service, @Repository, @Component classes
 *
 * OOP CONCEPT: INHERITANCE
 *   This class extends SpringBootServletInitializer, which is required when
 *   the application is packaged as a WAR file and deployed to an external
 *   Tomcat server (as opposed to using the embedded Tomcat server).
 *   The configure() method is overridden to tell the initializer which class
 *   to use as the application source.
 *
 * DEPLOYMENT MODES:
 *   Embedded (development): run main() → Spring starts its own Tomcat on port 8080.
 *   WAR (production):       deploy the .war file to an external Tomcat server;
 *                           Tomcat calls configure() instead of main().
 *
 * The MVC architecture is wired here:
 *   @ComponentScan finds all @Controller classes (StudentController,
 *   StudentPortalController) and registers them to handle HTTP requests.
 */
@SpringBootApplication
public class StudentRegistrationSystemApplication extends SpringBootServletInitializer {

    /**
     * INHERITANCE – Method Overriding.
     * Overrides SpringBootServletInitializer.configure() to register this class
     * as the Spring Boot application source when deployed as a WAR file.
     */
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(StudentRegistrationSystemApplication.class);
    }

    /**
     * Application entry point — used when running as a standalone JAR/embedded Tomcat.
     * SpringApplication.run() bootstraps the Spring context, performs component scanning,
     * auto-configures all beans, and starts the embedded web server.
     */
    public static void main(String[] args) {
        SpringApplication.run(StudentRegistrationSystemApplication.class, args);
    }
}
