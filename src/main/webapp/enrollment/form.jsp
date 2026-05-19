<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<c:set var="isEdit" value="${not empty enrollment}"/>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2>
                <i class="fas fa-clipboard-list me-2"></i>
                <c:choose><c:when test="${isEdit}">Edit Enrollment</c:when><c:otherwise>New Enrollment</c:otherwise></c:choose>
            </h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose><c:when test="${isEdit}">Update enrollment details</c:when><c:otherwise>Enroll a student in a course</c:otherwise></c:choose>
            </p>
        </div>
        <a href="<c:url value='/enrollments'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to List
        </a>
    </div>

    <div class="form-card">

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-4">
                <i class="fas fa-exclamation-circle me-2 flex-shrink-0"></i>
                <c:out value="${error}"/>
            </div>
        </c:if>

        <form method="post" action="<c:url value='/enrollments'/>" novalidate id="enrollForm">
            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
            <c:if test="${isEdit}">
                <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">
            </c:if>

            <div class="row g-3">

                <div class="col-md-6">
                    <label for="studentId" class="form-label">Student <span class="text-danger">*</span></label>
                    <select id="studentId" name="studentId" class="form-select" required>
                        <option value="">-- Select Student --</option>
                        <c:forEach var="s" items="${students}">
                            <option value="${s.studentId}"
                                <c:if test="${s.studentId == enrollment.studentId}">selected</c:if>>
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
                                <c:if test="${c.courseCode == enrollment.courseCode}">selected</c:if>>
                                <c:out value="${c.courseCode}"/> — <c:out value="${c.title}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Please select a course.</div>
                </div>

                <div class="col-md-6">
                    <label for="enrollmentDate" class="form-label">Enrollment Date <span class="text-danger">*</span></label>
                    <input type="date" id="enrollmentDate" name="enrollmentDate" class="form-control"
                           value="<c:out value='${enrollment.enrollmentDate}'/>" required>
                    <div class="invalid-feedback">Please select an enrollment date.</div>
                </div>

                <div class="col-md-6">
                    <label for="enrollmentType" class="form-label">Enrollment Type <span class="text-danger">*</span></label>
                    <select id="enrollmentType" name="enrollmentType" class="form-select" required>
                        <option value="">-- Select Type --</option>
                        <option value="FullTime"  <c:if test="${enrollment.enrollmentType == 'FullTime'}">selected</c:if>>Full Time</option>
                        <option value="PartTime"  <c:if test="${enrollment.enrollmentType == 'PartTime'}">selected</c:if>>Part Time</option>
                    </select>
                    <div class="invalid-feedback">Please select an enrollment type.</div>
                </div>

            </div>

            <hr class="my-4" style="border-color:#e2e8f0">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="fas fa-save me-1"></i>
                    <c:choose><c:when test="${isEdit}">Update Enrollment</c:when><c:otherwise>Save Enrollment</c:otherwise></c:choose>
                </button>
                <a href="<c:url value='/enrollments'/>" class="btn btn-outline-secondary px-4">
                    <i class="fas fa-times me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const dateField = document.getElementById('enrollmentDate');
    if (!dateField.value) dateField.valueAsDate = new Date();

    (() => {
        'use strict';
        const form = document.getElementById('enrollForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</div>
</body>
</html>
