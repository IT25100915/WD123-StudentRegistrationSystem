<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<c:set var="isEdit" value="${not empty student}"/>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2>
                <i class="fas fa-user-graduate me-2"></i>
                <c:choose><c:when test="${isEdit}">Edit Student</c:when><c:otherwise>Add New Student</c:otherwise></c:choose>
            </h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose><c:when test="${isEdit}">Update existing student information</c:when><c:otherwise>Register a new student into the system</c:otherwise></c:choose>
            </p>
        </div>
        <a href="<c:url value='/students'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to List
        </a>
    </div>

    <div class="form-card">
        <form method="post" action="<c:url value='/students'/>" novalidate id="studentForm">
            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">

            <div class="row g-3">

                <div class="col-md-6">
                    <label for="studentId" class="form-label">Student ID <span class="text-danger">*</span></label>
                    <input type="text" id="studentId" name="studentId" class="form-control"
                           value="<c:out value='${student.studentId}'/>"
                           placeholder="e.g. IT25100001" required
                           ${isEdit ? 'readonly' : ''}>
                    <c:if test="${isEdit}">
                        <div class="form-text" style="color:#94a3b8;font-size:0.78rem">
                            <i class="fas fa-lock fa-xs me-1"></i>Student ID cannot be changed.
                        </div>
                    </c:if>
                    <div class="invalid-feedback">Student ID is required.</div>
                </div>

                <div class="col-md-6">
                    <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                    <input type="text" id="fullName" name="fullName" class="form-control"
                           value="<c:out value='${student.fullName}'/>"
                           placeholder="Enter full name" required>
                    <div class="invalid-feedback">Full name is required.</div>
                </div>

                <div class="col-md-6">
                    <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                    <input type="email" id="email" name="email" class="form-control"
                           value="<c:out value='${student.email}'/>"
                           placeholder="student@sliit.lk" required>
                    <div class="invalid-feedback">Please enter a valid email.</div>
                </div>

                <div class="col-md-6">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="text" id="phone" name="phone" class="form-control"
                           value="<c:out value='${student.phone}'/>"
                           placeholder="+94 77 123 4567">
                </div>

                <div class="col-md-6">
                    <label for="studentType" class="form-label">Student Type <span class="text-danger">*</span></label>
                    <select id="studentType" name="studentType" class="form-select" required onchange="toggleType()">
                        <option value="">-- Select Type --</option>
                        <option value="Undergraduate" <c:if test="${student.studentType == 'Undergraduate'}">selected</c:if>>Undergraduate</option>
                        <option value="Postgraduate"  <c:if test="${student.studentType == 'Postgraduate'}">selected</c:if>>Postgraduate</option>
                    </select>
                    <div class="invalid-feedback">Please select a student type.</div>
                </div>

                <div class="col-md-6">
                    <label for="courseCode" class="form-label">Course <span class="text-danger">*</span></label>
                    <select id="courseCode" name="courseCode" class="form-select" required>
                        <option value="">-- Select Course --</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.courseCode}"
                                <c:if test="${c.courseCode == student.courseCode}">selected</c:if>>
                                <c:out value="${c.courseCode}"/> — <c:out value="${c.title}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Please select a course.</div>
                </div>

                <div class="col-12" id="ugSection" style="display:none">
                    <div class="form-section-card">
                        <label class="form-label" style="color:#6366f1">
                            <i class="fas fa-layer-group me-1"></i>Undergraduate Details
                        </label>
                        <div class="row g-3 mt-0">
                            <div class="col-md-4">
                                <label for="yearOfStudy" class="form-label">Year of Study <span class="text-danger">*</span></label>
                                <input type="number" id="yearOfStudy" name="yearOfStudy" class="form-control"
                                       min="1" max="4" placeholder="1 – 4">
                                <c:if test="${isEdit}">
                                    <div class="form-text" style="color:#f59e0b;font-size:0.78rem">
                                        <i class="fas fa-exclamation-triangle fa-xs me-1"></i>Re-enter year of study when editing.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12" id="pgSection" style="display:none">
                    <div class="form-section-card">
                        <label class="form-label" style="color:#8b5cf6">
                            <i class="fas fa-scroll me-1"></i>Postgraduate Details
                        </label>
                        <div class="row g-3 mt-0">
                            <div class="col-12">
                                <label for="thesisTitle" class="form-label">Thesis Title</label>
                                <input type="text" id="thesisTitle" name="thesisTitle" class="form-control"
                                       placeholder="Enter thesis title">
                                <c:if test="${isEdit}">
                                    <div class="form-text" style="color:#f59e0b;font-size:0.78rem">
                                        <i class="fas fa-exclamation-triangle fa-xs me-1"></i>Re-enter thesis title when editing.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <hr class="my-4" style="border-color:#e2e8f0">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="fas fa-save me-1"></i>
                    <c:choose><c:when test="${isEdit}">Update Student</c:when><c:otherwise>Save Student</c:otherwise></c:choose>
                </button>
                <a href="<c:url value='/students'/>" class="btn btn-outline-secondary px-4">
                    <i class="fas fa-times me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleType() {
        const type = document.getElementById('studentType').value;
        document.getElementById('ugSection').style.display = type === 'Undergraduate' ? 'block' : 'none';
        document.getElementById('pgSection').style.display = type === 'Postgraduate'  ? 'block' : 'none';
        document.getElementById('yearOfStudy').required = (type === 'Undergraduate');
    }
    toggleType();

    (() => {
        'use strict';
        const form = document.getElementById('studentForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</div>
</body>
</html>
