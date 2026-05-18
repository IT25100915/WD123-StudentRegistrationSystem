<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<c:set var="isEdit" value="${not empty course}"/>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2>
                <i class="fas fa-book-open me-2"></i>
                <c:choose><c:when test="${isEdit}">Edit Course</c:when><c:otherwise>Add New Course</c:otherwise></c:choose>
            </h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose><c:when test="${isEdit}">Update course details</c:when><c:otherwise>Add a new course to the catalog</c:otherwise></c:choose>
            </p>
        </div>
        <a href="<c:url value='/courses'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to List
        </a>
    </div>

    <div class="form-card">
        <form method="post" action="<c:url value='/courses'/>" novalidate id="courseForm">
            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">

            <div class="row g-3">

                <div class="col-md-4">
                    <label for="courseCode" class="form-label">Course Code <span class="text-danger">*</span></label>
                    <input type="text" id="courseCode" name="courseCode" class="form-control"
                           value="<c:out value='${course.courseCode}'/>"
                           placeholder="e.g. CS101" required
                           ${isEdit ? 'readonly' : ''}>
                    <c:if test="${isEdit}">
                        <div class="form-text" style="color:#94a3b8;font-size:0.78rem">
                            <i class="fas fa-lock fa-xs me-1"></i>Course code cannot be changed.
                        </div>
                    </c:if>
                    <div class="invalid-feedback">Course code is required.</div>
                </div>

                <div class="col-md-4">
                    <label for="credits" class="form-label">Credits <span class="text-danger">*</span></label>
                    <input type="number" id="credits" name="credits" class="form-control"
                           value="<c:out value='${course.credits}'/>"
                           min="1" max="12" placeholder="1 – 12" required>
                    <div class="invalid-feedback">Credits must be between 1 and 12.</div>
                </div>

                <div class="col-md-4">
                    <label for="mode" class="form-label">Delivery Mode <span class="text-danger">*</span></label>
                    <select id="mode" name="mode" class="form-select" required onchange="toggleMode()">
                        <option value="">-- Select Mode --</option>
                        <option value="Online"  <c:if test="${course.mode == 'Online'}">selected</c:if>>Online</option>
                        <option value="Offline" <c:if test="${course.mode == 'Offline'}">selected</c:if>>Offline</option>
                    </select>
                    <div class="invalid-feedback">Please select a delivery mode.</div>
                </div>

                <div class="col-md-8">
                    <label for="title" class="form-label">Course Title <span class="text-danger">*</span></label>
                    <input type="text" id="title" name="title" class="form-control"
                           value="<c:out value='${course.title}'/>"
                           placeholder="Enter full course title" required>
                    <div class="invalid-feedback">Course title is required.</div>
                </div>

                <div class="col-md-4">
                    <label for="coordinator" class="form-label">Coordinator <span class="text-danger">*</span></label>
                    <input type="text" id="coordinator" name="coordinator" class="form-control"
                           value="<c:out value='${course.coordinator}'/>"
                           placeholder="Coordinator name" required>
                    <div class="invalid-feedback">Coordinator is required.</div>
                </div>

                <div class="col-12" id="onlineSection" style="display:none">
                    <div class="form-section-card">
                        <label class="form-label" style="color:#0ea5e9">
                            <i class="fas fa-wifi me-1"></i>Online Course Details
                        </label>
                        <div class="row g-3 mt-0">
                            <div class="col-12">
                                <label for="platformUrl" class="form-label">Platform URL</label>
                                <input type="url" id="platformUrl" name="platformUrl" class="form-control"
                                       placeholder="https://learn.example.com/course">
                                <c:if test="${isEdit}">
                                    <div class="form-text" style="color:#f59e0b;font-size:0.78rem">
                                        <i class="fas fa-exclamation-triangle fa-xs me-1"></i>Re-enter the platform URL when editing.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12" id="offlineSection" style="display:none">
                    <div class="form-section-card">
                        <label class="form-label" style="color:#64748b">
                            <i class="fas fa-building me-1"></i>Offline Course Details
                        </label>
                        <div class="row g-3 mt-0">
                            <div class="col-md-6">
                                <label for="classroomLocation" class="form-label">Classroom Location</label>
                                <input type="text" id="classroomLocation" name="classroomLocation" class="form-control"
                                       placeholder="e.g. Block A, Room 201">
                                <c:if test="${isEdit}">
                                    <div class="form-text" style="color:#f59e0b;font-size:0.78rem">
                                        <i class="fas fa-exclamation-triangle fa-xs me-1"></i>Re-enter classroom location when editing.
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
                    <c:choose><c:when test="${isEdit}">Update Course</c:when><c:otherwise>Save Course</c:otherwise></c:choose>
                </button>
                <a href="<c:url value='/courses'/>" class="btn btn-outline-secondary px-4">
                    <i class="fas fa-times me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleMode() {
        const mode = document.getElementById('mode').value;
        document.getElementById('onlineSection').style.display  = mode === 'Online'  ? 'block' : 'none';
        document.getElementById('offlineSection').style.display = mode === 'Offline' ? 'block' : 'none';
    }
    toggleMode();

    (() => {
        'use strict';
        const form = document.getElementById('courseForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</div>
</body>
</html>
