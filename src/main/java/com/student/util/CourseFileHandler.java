package com.student.util;

import com.student.model.Course;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CourseFileHandler {

    private static final String FILE_PATH = System.getProperty("user.home")
            + File.separator + "srs_data" + File.separator + "courses.txt";

    private static final String DELIMITER = "|";
    private static final String HEADER    = "COURSE_CODE|TITLE|CREDITS|MODE|COORDINATOR";

    // ── Ensure the directory and file exist ──────────────────────────────────
    private static void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            file.createNewFile();
        }
    }

    // ── Write all courses to file (overwrites existing content) ──────────────
    public static void saveAllToFile(List<Course> courses) {
        try {
            ensureFileExists();
            BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false));
            writer.write(HEADER);
            writer.newLine();
            for (Course c : courses) {
                writer.write(
                    c.getCourseCode()  + DELIMITER +
                    c.getTitle()       + DELIMITER +
                    c.getCredits()     + DELIMITER +
                    c.getMode()        + DELIMITER +
                    c.getCoordinator()
                );
                writer.newLine();
            }
            writer.close();
            System.out.println("Courses saved to file: " + FILE_PATH);
        } catch (IOException e) {
            System.out.println("Error writing courses to file: " + e.getMessage());
        }
    }

    // ── Read all courses from file ────────────────────────────────────────────
    public static List<Course> readAllFromFile() {
        List<Course> courses = new ArrayList<>();
        try {
            ensureFileExists();
            BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
            String line;
            boolean firstLine = true;
            while ((line = reader.readLine()) != null) {
                if (firstLine) { firstLine = false; continue; } // skip header
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split("\\|", -1);
                if (parts.length >= 5) {
                    Course c = new Course();
                    c.setCourseCode(parts[0].trim());
                    c.setTitle(parts[1].trim());
                    c.setCredits(Integer.parseInt(parts[2].trim()));
                    c.setMode(parts[3].trim());
                    c.setCoordinator(parts[4].trim());
                    courses.add(c);
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("Error reading courses from file: " + e.getMessage());
        }
        return courses;
    }

    // ── Return the file path so it can be shown in the UI ────────────────────
    public static String getFilePath() {
        return FILE_PATH;
    }
}
