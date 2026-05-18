<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<c:set var="isEdit" value="${not empty attendance}"/>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2>
                <i class="fas fa-calendar-check me-2"></i>
                <c:choose><c:when test="${isEdit}">Edit Attendance</c:when><c:otherwise>Mark Attendance</c:otherwise></c:choose>
            </h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose><c:when test="${isEdit}">Update an attendance record</c:when><c:otherwise>Record student attendance for a session</c:otherwise></c:choose>
            </p>
        </div>
        <a href="<c:url value='/attendance'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to List
        </a>
    </div>

    <div class="form-card">
        <form method="post" action="<c:url value='/attendance'/>" novalidate id="attendanceForm">
            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
            <c:if test="${isEdit}">
                <input type="hidden" name="attendanceId" value="${attendance.attendanceId}">
            </c:if>

            <div class="row g-3">

                <div class="col-md-6">
                    <label for="studentId" class="form-label">Student <span class="text-danger">*</span></label>
                    <select id="studentId" name="studentId" class="form-select" required>
                        <option value="">-- Select Student --</option>
                        <c:forEach var="s" items="${students}">
                            <option value="${s.studentId}"
                                <c:if test="${s.studentId == attendance.studentId}">selected</c:if>>
                                <c:out value="${s.studentId}"/> — <c:out value="${s.fullName}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Please select a student.</div>
                </div>

                <div class="col-md-6">
                    <label for="courseCode" class="form-label">Course <span class="text-danger">*</span></label>
                    <select id="courseCode" name="courseCode" class="form-select" required>
                        <option value="">-- Select Course --</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.courseCode}"
                                <c:if test="${c.courseCode == attendance.courseCode}">selected</c:if>>
                                <c:out value="${c.courseCode}"/> — <c:out value="${c.title}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Please select a course.</div>
                </div>

                <div class="col-md-6">
                    <label for="date" class="form-label">Date <span class="text-danger">*</span></label>
                    <input type="date" id="date" name="date" class="form-control"
                           value="<c:out value='${attendance.date}'/>" required>
                    <div class="invalid-feedback">Please select a date.</div>
                </div>

                <div class="col-md-6">
                    <label for="status" class="form-label">Attendance Status <span class="text-danger">*</span></label>
                    <select id="status" name="status" class="form-select" required>
                        <option value="">-- Select Status --</option>
                        <option value="Present" <c:if test="${attendance.status == 'Present'}">selected</c:if>>
                            Present
                        </option>
                        <option value="Absent"  <c:if test="${attendance.status == 'Absent'}">selected</c:if>>
                            Absent
                        </option>
                        <option value="Late"    <c:if test="${attendance.status == 'Late'}">selected</c:if>>
                            Late
                        </option>
                    </select>
                    <div class="invalid-feedback">Please select a status.</div>
                </div>

            </div>

            <hr class="my-4" style="border-color:#e2e8f0">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="fas fa-save me-1"></i>
                    <c:choose><c:when test="${isEdit}">Update Record</c:when><c:otherwise>Save Record</c:otherwise></c:choose>
                </button>
                <a href="<c:url value='/attendance'/>" class="btn btn-outline-secondary px-4">
                    <i class="fas fa-times me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const dateField = document.getElementById('date');
    if (!dateField.value) {
        dateField.value = new Date().toISOString().split('T')[0];
    }

    (() => {
        'use strict';
        const form = document.getElementById('attendanceForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</div>
</body>
</html>
