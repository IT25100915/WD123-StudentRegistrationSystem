package com.student.util;

import com.student.model.Student;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentFileHandler {

    private static final String FILE_PATH = System.getProperty("user.home")
            + File.separator + "srs_data" + File.separator + "students.txt";

    private static final String DELIMITER = "|";
    private static final String HEADER    = "STUDENT_ID|FULL_NAME|EMAIL|PHONE|STUDENT_TYPE|COURSE_CODE";

    private static void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        file.getParentFile().mkdirs();
        if (!file.exists()) file.createNewFile();
    }

    public static void saveAllToFile(List<Student> students) {
        try {
            ensureFileExists();
            BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false));
            writer.write(HEADER);
            writer.newLine();
            for (Student s : students) {
                writer.write(
                    s.getStudentId()   + DELIMITER +
                    s.getFullName()    + DELIMITER +
                    s.getEmail()       + DELIMITER +
                    (s.getPhone() != null ? s.getPhone() : "") + DELIMITER +
                    s.getStudentType() + DELIMITER +
                    (s.getCourseCode() != null ? s.getCourseCode() : "")
                );
                writer.newLine();
            }
            writer.close();
            System.out.println("Students saved to file: " + FILE_PATH);
        } catch (IOException e) {
            System.out.println("Error writing students to file: " + e.getMessage());
        }
    }

    public static List<Student> readAllFromFile() {
        List<Student> students = new ArrayList<>();
        try {
            ensureFileExists();
            BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
            String line;
            boolean firstLine = true;
            while ((line = reader.readLine()) != null) {
                if (firstLine) { firstLine = false; continue; }
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split("\\|", -1);
                if (parts.length >= 6) {
                    Student s = new Student();
                    s.setStudentId(parts[0].trim());
                    s.setFullName(parts[1].trim());
                    s.setEmail(parts[2].trim());
                    s.setPhone(parts[3].trim());
                    s.setStudentType(parts[4].trim());
                    s.setCourseCode(parts[5].trim());
                    students.add(s);
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("Error reading students from file: " + e.getMessage());
        }
        return students;
    }

    public static String getFilePath() { return FILE_PATH; }
}
